require 'stdlib/area/position'
require 'stdlib/area/area'
require 'stdlib/area/chunk'
require 'stdlib/area/tile'
require 'stdlib/log/logger'
require 'stdlib/table'
require 'stdlib/game'
require 'lib/bplib'

--
-- global variables
--
global.ZADV = global.ZADV or {}
ZADV = global.ZADV or {}
ZADV.Data = global.ZADV.Data

format = string.format
floor = math.floor

ZADV_initialized = false
ZADV_ForcedArea = false
ZADV_InProcess = false
ZADV_AreaList = {}

Color = {
	red 	= {r = 1, g = 0, b = 0, a = 0.5},
	green 	= {r = 0, g = 1, b = 0, a = 0.5}
}


--
-- debug settings
--
ZADV.debug = 0

_logger = Logger.new('ZAdventure', 'main')
function debug ( msg, ... )
	
	if type(msg) == 'table' then
		msg = '\n'.. serpent.block(msg)
	elseif type(msg) ~= 'string' then
		msg = tostring(msg)
	end
	
	log("[[ZADV]] ".. format(msg,...))
	
	if ZADV.debug >= 1 then
		_logger.log(format(msg,...))
	end
	
	if ZADV.debug >= 3 and game and string.len(msg) <= 200 then
		Game.print_all(format(msg,...))
	end
end



--
-- Initialization
--

--- Prepare operable blueprint
function PrepareBlueprint()
	
	if not global.ZADV.blueprint then
		
		if not global.ZADV.entity then
			
			if not game.surfaces['ZADV_SURFACE'] then
				game.create_surface("ZADV_SURFACE",{width=3,height=3,peaceful_mode=true})
				debug("Creating operable surface")
			end
			
			global.ZADV.entity = game.surfaces['ZADV_SURFACE'].create_entity{name="wooden-chest", position={0,0}, force=game.forces["neutral"]}
			global.ZADV.entity.insert{name="blueprint", count=1}
			debug("Creating operable entity")
			
		end
		
		global.ZADV.blueprint = ZADV.entity.get_inventory(defines.inventory.chest).find_item_stack("blueprint")
		debug("Creating operable blueprint")
		
	end
	
end

--- Get Settings
local function UpdateSettings()

	ZADV.Settings = ZADV.Settings or {}
	ZADV.Settings['global_frequency'] = settings.global["zadv_global_frequency"].value
	ZADV.Settings['start_area'] = settings.global["zadv_starting_radiius"].value
	
	debug("Settings updated")
	
end

--- Post initialization
local function PostInit()
	
	-- skip if already done
	if ZADV_initialized then return end
	
	-- creating blueprint instance
	PrepareBlueprint()
	
	-- localize globals
	ZADV.blueprint = global.ZADV.blueprint
	ZADV.debug = global.ZADV.debug
	ZADV.Data = global.ZADV.Data
	
	-- get settings
	UpdateSettings()
	
	-- debug settings
	if ZADV.debug >= 3 then
		_logger = Logger.new('ZAdventure', 'debug', true, { force_append = true })
		debug("Set debug level to 3.")
	elseif ZADV.debug >= 2 then
		_logger = Logger.new('ZAdventure', 'debug', true)
		debug("Set debug level to 2.")
	elseif ZADV.debug >= 1 then
		debug("Set debug level to 1.")
	end
	
	-- debug dependings
	if ZADV.debug >= 2 then
		BPlib.chunkMarkerArray = BPlib.ParseToArray(BPlib.chunkMarker)
		debug("Prepare Chunk Marker Array")
	end
	
	-- globals
	global.generator = game.create_random_generator(game.tick)
	
	-- generate area list
	for m,v in pairs(ZADV.Data) do for a,d in pairs(v) do
		ZADV_AreaList[#ZADV_AreaList+1] = {m, a}
	end end
	
	-- Done
	ZADV_initialized = true
	debug("Initialization complete.")
	
end

--- Global initialization
function Init(event)
	
	-- creating blueprint instance
	PrepareBlueprint()
	
	-- check if data already prepared by someone else
	if global.ZADV.Data then return end
	
	--parse raw data
	local dump = ""
	local chunks = game.entity_prototypes["ZADV_DATA_C"].order
	global.ZADV.debug = tonumber(game.entity_prototypes["ZADV_DATA_D"].order)
	
	for i=0, chunks-1 do
		local name = "ZADV_DATA_"..i
		dump = dump .. game.entity_prototypes[name].order
	end
	
	-- apply parsed data
	global.ZADV.Data = loadstring(dump)() or {}
	debug("Raw data requested.")
	debug(ZADV)
	
	-- erase debug log
	_logger = Logger.new('ZAdventure', 'debug', true)
	_logger.write()
	
	-- localize globals
	PostInit()
	
end



--
-- Local functions
--

--- Integer to base with up rounding
-- @param int
-- @return possitive integer rounded up to neares solid number
local function base( int )
	int = tonumber(int)
	return floor((int < 0 and 0 - int or int)  + 0.5)
end

--- Check if position inside starting area
-- @param position : {x,y} array
-- @return true if the position inside starting area, false otherwise
local function isInStartingArea( position )
	return Area.inside(Area.expand(Area.construct(0,0,0,0), ZADV.Settings['start_area']*32), position)
end

--- Collision check on surface in selected area
-- @param surface : LuaSurface instance
-- @param area : BoundingBox {left_top :: Position, right_bottom :: Position}
-- @return true if area have collision tles, false otherwise
local function CollisionCheckArea(surface, area)
	if surface.count_tiles_filtered{area=area,  collision_mask="water-tile"} > 0 then return true 
	else return false end
end

--- Split string to array
-- @param str : input string
-- @param sep : separator
-- @return arrray of strings
local function strsplit(str,sep)
	local sar = {}
	for s in string.gmatch(str,"([^"..sep.."]+)") do sar[#sar+1] = s end
	return sar
end

--- Generate random number
-- @param min : minimum value
-- @param max : maximum value
-- @return random number
local function Rnd(min,max)
	global.adseed = global.adseed or 1
	global.adseed = global.adseed + game.tick
	global.adseed = global.adseed > 2^31 and 1 or global.adseed
	local seed = game.tick + floor(tonumber(tostring({}):sub(8))/(math.pi*1000))
	global.generator = global.generator or game.create_random_generator(seed)
	global.generator.re_seed(seed)
	return math.min(max,math.max(min,floor(global.generator(min,max+global.adseed)%max)))
end

--- Generate random number
-- @param T : table
-- @return table length
local function tlength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end

--- Randomize and prepare new area
-- @return table area data
local function GetRandomArea()
	
	-- randomize global step
	local roll = Rnd(1,1000)
	debug("Let's take our chance: ".. roll ..' prob: '.. tonumber(ZADV.Settings['global_frequency']))
	if not ZADV_ForcedArea and roll > tonumber(ZADV.Settings['global_frequency']) then return nil end
	
	-- run through the list of areas
	local areas = {}
	for mn,mod in pairs(ZADV.Data) do
		for an,a in pairs(mod) do
	
		-- calculate random possibility for each area
		roll = Rnd(1,1000)
		debug("area chance... ".. roll ..' '.. a.probability)
		if roll <= a.probability then
			-- store triggered area
			table.insert(areas, {mn,an})
		end
		
	end end
	
	-- if we have multiple triggered areas - choose one
	if tlength(areas) > 0 then
		areas = areas[Rnd(1,tlength(areas))]
		debug("Next area  is found")
		
	-- select one if we must
	elseif ZADV_ForcedArea then
		areas = ZADV_AreaList[Rnd(1,tlength(ZADV_AreaList))]
		debug("Next area is found (forced)")
		
	-- nothing to do
	else return nil end
	
	ZADV_ForcedArea = false
	debug("Next area [%s - %s] is ready", areas[1], areas[2])
	
	-- return area
	return ZADV.Data[areas[1]][areas[2]]
	
end





--
-- Chunk charted event
--
local function localChartedChunk( event )
		
	-- local variables
	local pos = event.position
	local _area = Area.round_to_integer(Area.construct(pos.x*32, pos.y*32, pos.x*32+32, pos.y*32+32))
	local center = Area.center(_area)
	local surface = game.surfaces[event.surface_index]
	local chunk_data = Tile.get_data(surface, center) or {}
	
	-- check collisions and if true - ignore chunk
	if CollisionCheckArea(surface, _area) then 
		chunk_data["generated"] = true
		ZADV_ForcedArea = true
	end
	
	-- check if chunk already generated - ignore if true
	if chunk_data["generated"] or isInStartingArea(center) then
		return
	end
	
	-- get random area
	local newarea = GetRandomArea()	
	
	if newarea then
	
		-- prepare blueprint
		ZADV.blueprint.import_stack(newarea.bp)
		if ZADV.blueprint.is_blueprint_setup() then
			
			-- place blueprint on surface
			local ghosts = ZADV.blueprint.build_blueprint{
				surface=surface,
				force=game.forces["neutral"],
				position=center,
				force_build=true,
				direction=defines.direction.north,
				skip_fog_of_war=false
			}
			
			-- finalize placed entities
			for k,v in pairs(ghosts) do
				if v.valid and not v.revive() then
					for _,e in pairs(surface.find_entities_filtered{
						area=v.bounding_box,
						name=v.name,
						invert=true
					}) do e.destroy() end
					v.revive()
				end
			end
			
			
			
			-- erase blueprint
			ZADV.blueprint.clear()
		
		end
	
		-- mark chunk
		chunk_data["generated"] = true
		Tile.set_data(surface, center, chunk_data)
		
	end
	
end

local function localGenerateChunk( event )
	
	if ZADV_InProcess then return end
	ZADV_InProcess = true
	
	local center = Area.center(event.area)
	local chunk_data = Chunk.get_data(event.surface, center) or {}
	
	-- check collisions and if true - ignore chunk
	if CollisionCheckArea(event.surface, event.area) then 
		chunk_data["generated"] = true
		ZADV_ForcedArea = true
	end
	
	-- check if chunk already generated - ignore if true
	if chunk_data["generated"] or isInStartingArea(center) then
		ZADV_InProcess = false
		return
	end
	
	-- get random area
	local newarea = GetRandomArea()	
	
	if newarea then
	
		-- prepare blueprint
		ZADV.blueprint.import_stack(newarea.bp)
		if ZADV.blueprint.is_blueprint_setup() then
			
			-- place blueprint on surface
			local ghosts = ZADV.blueprint.build_blueprint{
				surface=event.surface,
				force=game.forces["neutral"],
				position=center,
				force_build=true,
				direction=defines.direction.north,
				skip_fog_of_war=false
			}
			
			-- finalize placed entities
			for k,v in pairs(ghosts) do
				if v.valid and not v.revive() then
					for _,e in pairs(event.surface.find_entities_filtered{
						area=v.bounding_box,
						name=v.name,
						invert=true
					}) do e.destroy() end
					v.revive()
				end
			end
			
			
			
			-- erase blueprint
			ZADV.blueprint.clear()
		
		end
		
		-- mark chunk
		chunk_data["generated"] = true
		Chunk.set_data(event.surface, center, chunk_data)
		
	end
	
	ZADV_InProcess = false
	
end


--
-- EVENTS
--
script.on_init(Init)
script.on_event(defines.events.on_tick, 						PostInit)
--script.on_event(defines.events.on_chunk_charted, 				localChartedChunk)
script.on_event(defines.events.on_chunk_generated, 				localGenerateChunk)
script.on_event(defines.events.on_runtime_mod_setting_changed,	UpdateSettings)


script.on_event(defines.events.on_player_mined_item, function(event)
--[[
	
	local player = game.players[event.player_index]
	local force = player.force
	local surface = player.surface
	local area = Area.construct(player.position.x-16, player.position.y-16, player.position.x+16, player.position.y+16)
	
	local tiles = surface.find_tiles_filtered{area=area, collision_mask="water-tile"}
	
	local watermask = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
	local mask = {}
	for i=1,32 do mask[i] = 1 .. string.rep('0',i-1) end
	for _,v in pairs(tiles) do
		local x = floor(v.position.x-player.position.x+18)
		local y = floor(v.position.y-player.position.y+18)
		watermask[y] = watermask[y] or tonumber(0,2)
		watermask[y] = bit32.bor(watermask[y], tonumber(mask[x]))
		
	end
	
	
	debug(watermask)
	
--]]

	
	
end)



