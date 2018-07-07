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
ZADV_QueuedArea = false


--
-- debug settings
--
ZADV.debug = 0

_logger = Logger.new('ZADV', 'main')
function debug ( msg, ... )
	
	if type(msg) == 'table' then
		msg = serpent.dump(msg)
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
-- pre-initialization
--

ZADV.Settings = ZADV.Settings or {}
ZADV.Settings['start_area'] = settings.global["zadv_starting_radiius"].value


--
-- Initialization
--

--- Prepare operable blueprint
function PrepareBlueprint()
	
	if not global.ZADV.blueprint then
		
		if not global.ZADV.entity then
			
			if not game.surfaces['ZADV_SURFACE'] then
				game.create_surface("ZADV_SURFACE")
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

-- Post initialization
local function PostInit()
	
	-- skip if already done
	if ZADV_initialized then return end
	
	-- creating blueprint instance
	PrepareBlueprint()
	
	-- localize globals
	ZADV.blueprint = global.ZADV.blueprint
	ZADV.debug = global.ZADV.debug
	ZADV.Data = global.ZADV.Data
	
	-- debug settings
	if ZADV.debug >= 3 then
		_logger = Logger.new('ZADV', 'debug', true, { force_append = true })
		debug("Set debug level to 3.")
	elseif ZADV.debug >= 2 then
		_logger = Logger.new('ZADV', 'debug', true)
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
	
	-- Done
	ZADV_initialized = true
	debug("Initialization complete.")
	
end

-- Global initialization
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
	
	local adjustedX = base(position.x / 32)
	local adjustedY = base(position.y / 32)
	local start_radius = ZADV.Settings['start_area']
	
	if (adjustedX + adjustedY <= start_radius) then return true end
	
	return Area.inside(Area.expand(Area.construct(0,0,0,0), start_radius*32), position)
	--return false
end

--- Collision check on surface in selected area
-- @param surface : LuaSurface instance
-- @param area : BoundingBox {left_top :: Position, right_bottom :: Position}
-- @return true if area have collision tles, false otherwise
local function CollisionCheckArea(surface, area)
	if surface.count_tiles_filtered{area=area,  collision_mask="water-tile"} > 0 then return true 
	else return false end
end







--
-- Area preparation
--
local function Randomizer()
	
	global.generator.re_seed(game.tick)
	
	
end





--
-- Chunk charted event
--
local function localChartedChunk( event )
		
	-- local variables
	local _area = Area.construct(event.position.x*32, event.position.y*32, event.position.x*32+32, event.position.y*32+32)
	local center = Area.center(_area)
	local surface = game.surfaces[event.surface_index]
	local chunk_data = Tile.get_data(surface, center) or {}
	
	-- check collisions and if true - ignore chunk
	if CollisionCheckArea(surface, _area) then 
		chunk_data["generated"] = true
		ZADV_QueuedArea = true
	end
	
	-- 
	
	
	-- check if chunk already generated - ignore if true
	if chunk_data["generated"] or isInStartingArea(center) then
		return
	end
	
	-- debugging
	if ZADV.debug >= 2 then
		local tiles = {}	
		local bp = BPlib.chunkMarkerArray	
		for _,t in pairs(bp['blueprint']["tiles"]) do
			table.insert(tiles, { name = t.name, position = Position.offset(center, t.position.x, t.position.y) } )
		end	
		surface.set_tiles( tiles )
	end
	
	
	ZADV.blueprint.clear()
	ZADV.blueprint.import_stack(ZADV.Data["ZADV_Base"]['test'].bp)
	
	--[[
	for k,v in pairs(ZADV.blueprint.build_blueprint{
		surface=surface,
		force=game.forces["player"],
		position=center,
		force_build=true,
		direction=defines.direction.north,
		skip_fog_of_war=false
	}) do if not v.revive() then
			for _,e in pairs(surface.find_entities_filtered{
				area=v.bounding_box,
				name=v.name,
				invert=true
			}) do e.destroy() end
			v.revive()
		end
	end--]]
	
	local ghosts = ZADV.blueprint.build_blueprint{
		surface=surface,
		force=game.forces["neutral"],
		position=center,
		force_build=true,
		direction=defines.direction.north,
		skip_fog_of_war=false
	}
	for k,v in pairs(ghosts) do if not v.revive() then
			for _,e in pairs(surface.find_entities_filtered{
				area=v.bounding_box,
				name=v.name,
				invert=true
			}) do e.destroy() end
			v.revive()
		end
	end
	
	
	--debug(ZADV.blueprint.is_blueprint_setup())
	
	chunk_data["generated"] = true
	Tile.set_data(surface, center, chunk_data)
	
end

local function localGenerateChunk( event )

	local center = Area.center(event.area)
	local chunk_data = Chunk.get_data(event.surface, center) or {}
	
	if CollisionCheckArea(event.surface, area, {"water", "deepwater", "water-green", "deepwater-green"}) then 
		chunk_data["generated"] = true
		return
	end
	
	if chunk_data["generated"] or isInStartingArea(center) then return end
	
	local tiles = {}
	
	local bp = BPlib.GetChunkMarker()
	for _,t in pairs(bp["blueprint"]["tiles"]) do
		table.insert(tiles, { name = t.name, position = {center.x + t.position.x, center.y + t.position.y} } )
	end
	
	event.surface.set_tiles( tiles )
	--[[
	game.surfaces[event.surface_index ].create_entity {
		name = "refined-hazard-concrete-left",
		position = {center.x, center.y},
		force=event.force
	}--]]
	
	chunk_data["generated"] = true
	Chunk.set_data(event.surface, center, chunk_data)
	
end


--
-- EVENTS
--
script.on_init(Init)
script.on_event(defines.events.on_tick, 				PostInit)
script.on_event(defines.events.on_chunk_charted, 		localChartedChunk)
--script.on_event(defines.events.on_chunk_generated, 		localGenerateChunk)


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



