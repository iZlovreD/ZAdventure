require 'stdlib/area/position'
require 'stdlib/area/area'
require 'stdlib/table'

--
-- global variables
--
global.ZADV = global.ZADV or {}
global.ZADV_InProcess = false
global.ZADV_ForceUnlock = false
global.ZADV_NextForceUnlock = 0 
global.ZADV_EventLock = 0


--
-- local variables
--
local format = string.format
local floor = math.floor
local serpd = serpent.dump
local serpb = serpent.block
local ZADV = {}
local ZADV_initialized = false

Color = {
	black 	= {r = 0.0, g = 0.0, b = 0.0},
	red 	= {r = 1.0, g = 0.2, b = 0.2},
	green 	= {r = 0.3, g = 0.7, b = 0.0},
	yellow	= {r = 0.9, g = 0.7, b = 0.0},
	orange	= {r = 0.9, g = 0.4, b = 0.0},
	blue	= {r = 0.3, g = 0.7, b = 1.0}
}


--
-- debug settings
--
ZADV.debug = 0

function debug ( msg, ... )
	if type(msg) == 'table' then
		if ZADV.debug >= 1 then log("\n[[ZADV]] ".. serpent.block(msg)) end
	else
		if type(msg) ~= 'string' then
			msg = tostring(msg)
		end
		if ZADV.debug >= 1 then log("[[ZADV]] ".. format(msg,...)) end
		if ZADV.debug >= 2 and game and string.len(msg) <= 200 then
			game.print(format(msg,...))
		end
	end
end


--
-- Local functions
--

--- Integer to base with up rounding
-- @param tbl : to be searched
-- @param ... : arguments what to search
-- @return possitive integer rounded up to neares solid number
function table.contains( tbl, ... )
	local args = ...
	local func = function(v,k, arg)
		if v == arg or ( type(v) == 'table' and v.name == arg) then
		return true else return false end
	end
	if type(args) == 'table' then
		for _,v in pairs(args) do
			if table.find(tbl, func, v) == nil then
				return false
			end
		end
	end
	return table.any(tbl, func, args) ~= nil
end

--- Integer to base with up rounding
-- @param int
-- @return possitive integer rounded up to neares solid number
local function base( int )
	int = tonumber(int)
	return floor((int < 0 and 0 - int or int)  + 0.5)
end

--- Check if position inside restricted area
-- @param distance : from position in chunks
-- @param position : {x,y} array current position
-- @return true if the position inside area, false otherwise
local function isInsideBounds( position, distance )
	for _,sp in pairs(ZADV.StartingAreas) do
		if Area.inside(Area.expand(sp.area, math.max(0,((distance or 15)-15)*32)), position) then
		return true end
	end
	return false
end

--- Collision check on surface in selected area
-- @param surface : LuaSurface instance
-- @param area : BoundingBox {left_top :: Position, right_bottom :: Position}
-- @return true if area have collision tles, false otherwise
local function CollisionCheckArea(surface, area)
	local types = {"unit", "unit-spawner", "corpse", "simple-entity", "container", "resource", "cliff"}
	for t in pairs(global.ZADV.UsedTypes) do table.insert(types, t) end
	if surface.count_tiles_filtered{area=area,  collision_mask="water-tile"} > 0
	or surface.count_entities_filtered{area=area, type=types} > 0
	then return true else return false end
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
-- @param adseed : additional seed
-- @return random number
local function Rnd(min,max,adseed)
	min = min or 1
	max = max or 1
	adseed = adseed or 0
	global.adseed = global.adseed or 2^16
	global.adseed = global.adseed + adseed
	global.adseed = global.adseed > 2^31 and 1 or global.adseed
	local seed = game.tick + floor(tonumber(tostring({}):sub(8,-4))) + adseed
	global.generator = global.generator or game.create_random_generator(seed)
	global.generator.re_seed(seed)
	return math.min(max, math.max(min, floor(global.generator(min, math.max(min, base(max+global.adseed))) % max) ) )
end
--- globalize Rnd function
function ZADVRnd(min,max,adseed)
	return Rnd(min,max,adseed)
end

--- Generate random number
-- @param T : table
-- @return table length
local function tlength(T)
	local count = 0
	for k,v in pairs(T) do if v then count = count + 1 end end
	return count
end

--- Generate random number
-- @param name : requested name
-- @return string with possible replacement name
-- [ not implemented yet ]
local function getname(name)
	return name
end

--- Calculates the chunk coordinates for the tile position given
--  @param position to calculate the chunk for
--  @return the chunk position as a table
function ChunkFromPosition(position)
    position = Position.to_table(position)
    local x = math.floor(position.x)
    local y = math.floor(position.y)
    local chunk_x = bit32.arshift(x, 5)
    if x < 0 then
        chunk_x = chunk_x - (2^32)
    end
    local chunk_y = bit32.arshift(y, 5)
    if y < 0 then
        chunk_y = chunk_y - (2^32)
    end
    return {x = chunk_x, y = chunk_y}
end

--- Find nearest players
-- @param pos : relative position
-- @return LuaPlayer table
local function FindNearestPlayer(pos)
	local indx = 0
	local dist = false
	for i,p in pairs(game.connected_players) do
		if not dist or Position.distance(pos, p.position) < dist then
			indx = i; dist = Position.distance(pos, p.position)
		end
	end
	return game.connected_players[indx] or false
end

--- Randomize and prepare new area
-- @param seed : center of new chunk
-- @return table area data
local function GetRandomArea(seed)
	
	local pos = seed
	seed = pos.x + pos.y
	
	-- randomize global step
	local roll = Rnd(1,1000,seed)
	if roll > tonumber(ZADV.Settings['zadv_global_frequency']) then return nil end
	
	-- run through the list of areas
	local areas = {}
	roll = Rnd(1,1000,seed)
	
	
	for mn,mod in pairs(ZADV.Data) do
		for an,ar in pairs(mod) do
			
			global.ZADV.restrictedareas = global.ZADV.restrictedareas or {}
			global.ZADV.copy_per_force = global.ZADV.copy_per_force or {}
			if not ar.current_force or ar.current_force == nil then 
				ZADV.Data[mn][an].current_force = ZADV.Data[mn][an].force or 'neutral'
				ar.current_force = ar.force or 'neutral'
			end
			local nf = tostring(mn) ..'-'.. tostring(an) ..'-'.. (ar.current_force or ar.force)
			
			-- force check
			local skip_force = false
			
			if ar.unique and ar.force == 'player' then
				
				ZADV.Data[mn][an].max_copies = 1
				global.ZADV.copy_per_force[ar.name] = global.ZADV.copy_per_force[ar.name] or {}
				
				if global.ZADV_PVP_MODE then
				
					--debug('unique check 1 %s',serpb(global.ZADV.copy_per_force[ar.name]))
					
					local teams = {}
					for _,t in pairs(global.teams) do
						if not global.ZADV.copy_per_force[ar.name][t]
						or tonumber(global.ZADV.copy_per_force[ar.name][t]) > 0 then
							table.insert(teams,t)
						end
					end
					--debug('unique check 2 %s',serpb(teams))
					
					if not tlength(teams) then
						global.ZADV.restrictedareas[nf] = true
						
					else
						local _force = teams[Rnd(1,#teams,seed)] or 'neutral'
						
						if FindNearestPlayer(pos).force.name ~= _force then
							skip_force = true
						else
							ZADV.Data[mn][an].current_force = _force or 'neutral'
							nf = ar.name ..'-'.. _force
						end
					end
					--debug('unique check 3 %s',ZADV.Data[mn][an].current_force)
				
				else
			
					if not global.ZADV.copy_per_force[ar.name][ar.force] then
						ZADV.Data[mn][an].max_copies = 1
					else
						global.ZADV.restrictedareas[nf] = true
					end
					
				end
			end
			
			-- check if no more copiees allowed
			if not global.ZADV.restrictedareas[nf] and not skip_force
			and (roll <= ar.probability) then
				
				-- technology check
				local techallow = false
				if ar.ignore_technologies then
					techallow = true
				elseif ar.techs then
					techallow = true
					for _,f in pairs(game.forces) do
					for _,t in pairs(ar.techs) do
					if not f.technologies[t].researched then
						techallow = false
					end end	end
					--if not techallow then debug('Not enough technologies for "%s - %s", skip this time..',mn,an) end
				end
				
				-- placeing check
				local placeallow = true
				if isInsideBounds(pos, ar.remoteness_min or ZADV.Data[mn][an].remoteness_min) then
					placeallow = false
					--debug('Area "%s-%s" too close starting area', mn, an)
				elseif ( ZADV.Data[mn][an].remoteness_max ~= 0 and not isInsideBounds(pos, ar.remoteness_max or ZADV.Data[mn][an].remoteness_max) ) then
					placeallow = false
					--debug('Area "%s-%s" is outside placing bounds', mn, an)
				end
				
				-- all checks done
				if techallow and placeallow then
					-- store triggered area
					table.insert(areas, {mn,an})
				end
				
			end
	end end
	
	-- if we have multiple triggered areas - choose one
	if tlength(areas) > 0 then
		roll = (Rnd(1,1000,seed) % #areas) + 1
		areas = areas[roll]
		
	-- nothing to do
	else return false end
	
	local a,b = areas[1],areas[2]
	local n,f = ZADV.Data[a][b].name,ZADV.Data[a][b].current_force
	local nf = n..'-'..f
	
	-- decrease copies counter
	local copy_left = ZADV.Data[a][b].max_copies
	if copy_left and copy_left > 0 then
		
		global.ZADV.copy_per_force[n] = global.ZADV.copy_per_force[n] or {}
	
		if ZADV.Data[a][b].force == 'player' and global.ZADV_PVP_MODE then
			
			for _,t in pairs(global.teams) do
				if not global.ZADV.copy_per_force[n][t] then
					global.ZADV.copy_per_force[n][t] = copy_left
				end
			end
			--debug('1 %s',serpb(global.ZADV.copy_per_force))
			
		else
			global.ZADV.copy_per_force[n][f] = 
				global.ZADV.copy_per_force[n][f] or copy_left
			--debug('2 %s',serpb(global.ZADV.copy_per_force))
		
		end
		
		global.ZADV.copy_per_force[n][f] = 
			global.ZADV.copy_per_force[n][f] < 0 and -10
			or ZADV.Data[a][b].unique and 0 or math.max(0, global.ZADV.copy_per_force[n][f] - 1)
			--debug('3 %s',serpb(global.ZADV.copy_per_force))
	end
	
	-- if only once or no more copiees
	if ZADV.Data[a][b].only_once or copy_left then
		global.ZADV.copy_per_force[n] = global.ZADV.copy_per_force[n] or {}
		global.ZADV.restrictedareas[nf] = ZADV.Data[a][b].only_once or global.ZADV.copy_per_force[n][f] == 0
	end
	
	-- return area
	return ZADV.Data[a][b]
	
end


--
-- Area generation
--

--- place blueprint automaticly
-- @param surface : Surface to build on
-- @param center : The position to build at
-- @param newarea : blueprint to build
local function AplyBlueprintAuto(surface, center, newarea)
	
	debug("New area: %s",newarea.name)
	
	-- fault check
	if not newarea or not center or not surface then return end
	
	-- prepare blueprint
	global.ZADV.blueprint.import_stack(newarea.bp)
	if global.ZADV.blueprint.is_blueprint_setup() then
		
		--[[ adapt blueprint options ]]--
		
		-- force
		debug("Selected force: ".. newarea.current_force)
		if not game.forces[newarea.current_force] then
			if type(newarea.current_force) == 'string' then
				if #game.forces >= 62 then
					newarea.current_force = "neutral"
				else
					game.create_force(newarea.current_force)
				end
			else newarea.current_force = "neutral" end
		end
		
		-- direction
		if newarea.random_direction then
			newarea.direction = math.min(4,Rnd(1,5))*2-2
		else
			newarea.direction = 0
		end
		
		
		--[[ place blueprint on surface ]]--
		--debug("place bp @ %s", serpent.block(center))
		local ghosts = global.ZADV.blueprint.build_blueprint{
			surface=surface,
			force=game.forces[newarea.current_force],	-- modded
			position=center,
			force_build=newarea.force_build,			-- modded
			direction=newarea.direction,				-- modded
			skip_fog_of_war=false
		}
		
		--[[ finalize placed entities ]]--
		
		local area = {
			{center.x-(newarea.area.size.x/2)-1, center.y-(newarea.area.size.y/2)-1},
			{center.x+(newarea.area.size.x/2)+1, center.y+(newarea.area.size.y/2)+1}
		}
		local _center = Area.center(area)
		
		local area2d = newarea.chunkarea
		area2d.right_bottom.x = area2d.right_bottom.x - 1
		area2d.right_bottom.y = area2d.right_bottom.y - 1
		
		local bigarea2d = newarea.bigchunkarea or false
		if bigarea2d then
			bigarea2d.right_bottom.x = bigarea2d.right_bottom.x - 1
			bigarea2d.right_bottom.y = bigarea2d.right_bottom.y - 1
		end
		
		-- prepare areadata
		global.ZADV.ArData = global.ZADV.ArData or {}
		local areadata = table.deepcopy(newarea.areadata) or {}

		local entities = {}
		if newarea.finalize_build then					-- modded
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
			
			if newarea.names then
				
				entities = surface.find_entities_filtered{
					area=area,
					name=newarea.names
				}
				
				-- local storage
				local locstor = {}
				
				-- update used types list
				global.ZADV.UsedTypes = global.ZADV.UsedTypes or {}
				
				for _,e in pairs(entities) do if e and e.valid then 
				
					-- store type for future checks
					global.ZADV.UsedTypes[e.type] = true
					
					-- Deactivating an entity will stop all its operations (inserters will stop working)
					e.active = newarea.active
					
					-- Not minable entities can still be destroyed
					e.minable = newarea.minable
					
					-- When the entity is not destructible it can't be damaged
					e.destructible = newarea.destructible
					
					-- Replace entities with their remains if they have it
					if newarea.remains then
						e.die('neutral')
					end
					
					-- Set health in procentage of the entity. Entities with 0 health can not be attacked. Setting health to higher than max health will set health to max health
					if newarea.health >= 0 then
						e.health = e.prototype.max_health * (newarea.health/100)
					end
					
					-- Player can't open gui of this entity and he can't quick insert/input stuff in to the entity when it is not operable
					e.operable = newarea.operable
					
					-- Sets the entity to be deconstructed by construction robots
					if newarea.order_deconstruction then
						e.order_deconstruction('neutral')
					end
					
					-- When entity is not to be rotatable (inserter, transport belt etc), it can't be rotated by player using the R key
					e.rotatable = newarea.rotatable
					
					-- Script for each entity in new area
					if type(newarea.ScriptForEach) == 'function' then
					
						local done, err = pcall(newarea.ScriptForEach, Rnd(1,1000), game, surface, newarea.current_force, area, _center, e, newarea.names or {}, locstor, areadata)
						if not done then debug("\n[%s].ScriptForEach return with error:\n%s", newarea.name, err) end
						
						if ZADV.debug >= 2 and newarea.name:find('TEST') then
							local _testfunc = loadstring(serpd(function(rndroll, game, surface, force, area, center, entity, namelist, locstore, areadata)
-------------------------------------------------------------------------------------------------------------------------------------------
----v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v----
--[[-----------------------------------------------------------------------------------------------------------------------------------]]--
		
--[[-------------------------------------------------------------------------------------------------------------------------------]]--]]--
----^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^--------
-------------------------------------------------------------------------------------------------------------------------------------------
							end))()
							done, err = pcall(_testfunc, Rnd(1,1000), game, surface, newarea.current_force, area, _center, e, newarea.names or {}, locstor, areadata)
							if not done then debug("\n[[DEBUG]]\n[%s].ScriptForEach return with error:\n%s", newarea.name, err) end
						end
						
					end
					
				end end
			end
		else
			entities = ghosts
		end
		
		
		-- Script for all entities in new area
		if type(newarea.ScriptForAll) == 'function' then
		
			local done, err = pcall(newarea.ScriptForAll, Rnd(1,1000), game, surface, newarea.current_force, area, _center, newarea.names or {}, entities or {}, areadata)
			if not done then debug("\n[%s].ScriptForAll return with error:\n%s", newarea.name, err) end
			
			if ZADV.debug >= 2 and newarea.name:find('TEST') then
				local _testfunc = loadstring(serpd(function(rndroll, game, surface, force, area, center, namelist, entitylist, areadata)
-------------------------------------------------------------------------------------------------------------------------------------------
----v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v----
--[[-----------------------------------------------------------------------------------------------------------------------------------]]--
		
--[[-------------------------------------------------------------------------------------------------------------------------------]]--]]--
----^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^--------
-------------------------------------------------------------------------------------------------------------------------------------------
				end))()
				done, err = pcall(_testfunc, Rnd(1,1000), game, surface, newarea.current_force, area, _center, newarea.names or {}, entities or {}, areadata)
				if not done then debug("\n[[DEBUG]]\n[%s].ScriptForAll return with error:\n%s", newarea.name, err) end
			end
		end
		
		-- Event handling
		
		if ZADV.debug >= 2 and newarea.name:find('TEST') then
		--	ZADV.Data[newarea.modname][newarea.bpname].Events = {
-------------------------------------------------------------------------------------------------------------------------------------------
----v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v----
--[[-----------------------------------------------------------------------------------------------------------------------------------]]--
		
--[[-------------------------------------------------------------------------------------------------------------------------------]]--]]--
----^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^--------
-------------------------------------------------------------------------------------------------------------------------------------------
		--	}
		end
		
		if ZADV.Data[newarea.modname][newarea.bpname].Events and type(ZADV.Data[newarea.modname][newarea.bpname].Events) == 'table' then
			for evnt,func in pairs(ZADV.Data[newarea.modname][newarea.bpname].Events) do
				if type(func) == 'function' then
					global.ZADV.Events[evnt] = global.ZADV.Events[evnt] or {}
					global.ZADV.Events[evnt][newarea.name] = {mod = newarea.modname, area = newarea.bpname}
				end
			end
		end
		
		-- save areadata
		if type(areadata) == 'table' then
			local cnt = 0
			for i in pairs(areadata) do cnt = cnt + 1 end
			if cnt > 0 then
				global.ZADV.ArData[newarea.name] = global.ZADV.ArData[newarea.name] or {}
				table.insert(global.ZADV.ArData[newarea.name], areadata)
			end
		else
			global.ZADV.ArData[newarea.name] = global.ZADV.ArData[newarea.name] or {}
			table.insert(global.ZADV.ArData[newarea.name], areadata)
		end

		-- update events
		ReEvent()
		
		-- remove unfinished deconstruction
		surface.cancel_deconstruct_area{area=area, force=newarea.current_force}
		
		-- force chart area
		if ZADV.debug >= 2 or newarea.force_reveal or ZADV.force_reveal then
		for _,f in pairs(game.forces) do
		if f.name ~= 'neutral' and f.name ~= 'enemy' then
			if bigarea2d then f.chart(surface, bigarea2d)
			else f.chart(surface, area2d) end
		end end end
		
		-- shoot the message
		local possiblemessages = {}
		for _,m in pairs(newarea.messages) do if m.msg:len() > 0
			then table.insert(possiblemessages, m) end end
		if #possiblemessages > 0 then
			local message = possiblemessages[Rnd(1,#possiblemessages)]
			pcall(game.print, message.msg, message.color)
		end
		if ZADV.force_reveal then game.print("New area  ".. newarea.name) end
		
		
		-- erase blueprint
		global.ZADV.blueprint.clear()
	
	end
end

--- place blueprint directly
-- @param surface : Surface to build on
-- @param center : The position to build at
-- @param newarea : blueprint to build
local function AplyBlueprintManualy(surface, center, newarea)

end



--
-- INITIALIZATION
--

--- Prepare operable blueprint
local function PrepareBlueprint()
	
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
		
		global.ZADV.blueprint = global.ZADV.entity.get_inventory(defines.inventory.chest).find_item_stack("blueprint")
		debug("Creating operable blueprint")
		
	end
	
end

--- Reassign events after loadstring
function ReEvent()

	global.ZADV.Events = global.ZADV.Events or {}
	
	for event,data in pairs(global.ZADV.Events) do
		if not script.get_event_handler(event) then
			script.on_event(event, Global_Handler)
		end
	end
	
end


--- detect scenarios
local function detectScenarios()
	
	if not global.ZADV_DISABLED then
	
		if not global.ZADV_PVP_MODE and table.find(game.surfaces, function(v) if v.name:find('battle_surface_') then return true end end) then
			
			if not ZADV.Settings['zadv_disable_in_pvp'] then
				debug('Prepare to PvP...')
				
				local surf = table.find(game.surfaces, function(v) if v.name:find('battle_surface_') then return true end end)
				ZADV.MainSurface = surf and surf.name or ZADV.MainSurface
				
				global.teams = {}
				for _,f in pairs(game.forces) do
					if f.name ~= 'player' and f.name ~= 'neutral' and f.name ~= 'enemy' and f.name ~= 'spectator' then
						table.insert(ZADV.StartingAreas, {center=f.get_spawn_position(game.surfaces[ZADV.MainSurface]), area=Position.expand_to_area(f.get_spawn_position(game.surfaces[ZADV.MainSurface]), 240)})
						table.insert(global.teams, f.name)
					end
				end
				
				global.ZADV_PVP_MODE = true
			else
				debug('ZADV_DISABLED - PVP')
				global.ZADV_DISABLED = true
			end
			
		elseif table.contains( game.forces, {'black','blue','brown','cyan'} ) then
				debug('ZADV_DISABLED - TEAM CHALLANGE')
				global.ZADV_DISABLED = true
		
		elseif false then
		end
	
	end
end

--- Global initialization
local function PrepareData()
	
	--parse raw data
	local dump, sdump, ndump = "", "", ""
	local chunks = game.entity_prototypes["ZADV_DATA_C"].order
	local schunks = game.entity_prototypes["ZADV_SDATA_C"].order
	local nchunks = game.entity_prototypes["ZADV_NDATA_C"].order
	ZADV.debug = tonumber(game.entity_prototypes["ZADV_DATA_D"].order)
	debug("Set debug level: ".. ZADV.debug)
	
	for i=0, chunks-1 do
		local name = "ZADV_DATA_"..i
		dump = dump .. game.entity_prototypes[name].order
	end
	
	for i=0, schunks-1 do
		local name = "ZADV_SDATA_"..i
		sdump = sdump .. game.entity_prototypes[name].order
	end
	
	for i=0, nchunks-1 do
		local name = "ZADV_NDATA_"..i
		ndump = ndump .. game.entity_prototypes[name].order
	end
	
	-- apply parsed data
	ZADV.Data = loadstring(dump)() or {}
	ZADV.Settings = loadstring(sdump)() or {}
	ZADV.NamePairList = loadstring(ndump)() or {}
	debug("Raw data requested.")
	
	-- set globals
	global.ZADV.UsedTypes = global.ZADV.UsedTypes or {}
	
end
local function Init()
	
	if not ZADV.Data or not ZADV.Settings or not ZADV.NamePairList then
		ZADV_initialized = false
	end
	
	-- info about new data
	if not global.ZADV.ControlString
	or game.entity_prototypes["ZADV_DATA_CS"].order ~= global.ZADV.ControlString
	then
		if global.ZADV.ControlString
		and game.entity_prototypes["ZADV_DATA_CS"].order ~= global.ZADV.ControlString then
			game.print("[ZAdv] New or updated data found. Start re-initialization...", Color.green)
			debug("Old seed:\t".. (global.ZADV.ControlString or 'nil'))
			debug("New seed:\t".. game.entity_prototypes["ZADV_DATA_CS"].order)
		end
		global.ZADV.ControlString = game.entity_prototypes["ZADV_DATA_CS"].order
		ZADV_initialized = false
	end
	
	if not ZADV_initialized then
	
		PrepareData()
		
		-- creating blueprint instance
		PrepareBlueprint()
		
		-- main surface
		ZADV.MainSurface = 'nauvis'
		
		-- starting area(s)
		ZADV.StartingAreas = {
			{center={x=0,y=0},area={left_top={x=-240,y=-240},right_bottom={x=240,y=240}}}
		}
		
		-- if unsupported challange
		if (global.required ~=nil and global.points ~=nil and global.accumulated ~=nil and global.story ~=nil)
		or (global.afk_time ~=nil and global.points ~=nil and global.round_number ~=nil and global.start_round_tick ~=nil)
		or (global.bounty_bonus ~=nil and global.money ~=nil and global.send_satellite_round ~=nil and global.wave_number ~=nil) then
			debug('ZADV_DISABLED')
			global.ZADV_DISABLED = true
		end
		
		-- events
		debug('Prepare events')
		ReEvent()
		
		
		ZADV_initialized = true
		global.ZADV_PVP_MODE = false
		debug("Initialization complete.")
		
	end
end

-- force unlock event
local function UnlockChunkEvent(tick)
	if global.ZADV_ForceUnlock and tick >= global.ZADV_NextForceUnlock then
		global.ZADV_InProcess = false
		global.ZADV_ForceUnlock = false
		debug("ForceUnlock")
	end
end

--- Global handler
function Global_Handler(event)
		
	if ZADV.debug_pulse then
		ZADV.debug_pulse = false
		log(string.format('\n\n[[debug_pulse]]\n%s\n%s',serpb(global),serpb(ZADV)))
	end
	
	Init()
	detectScenarios()
	UnlockChunkEvent(event.tick)
	
	if not global.ZADV_DISABLED and ZADV_initialized and global.ZADV_EventLock ~= game.tick then
		
		global.ZADV_EventLock = game.tick
		
		for 
		id,data in pairs(global.ZADV.Events)
		do
			for
			dname,edata in pairs(data)
			do
				if
				ZADV.Data[edata.mod] and
				ZADV.Data[edata.mod][edata.area] and
				ZADV.Data[edata.mod][edata.area].Events and
				type(ZADV.Data[edata.mod][edata.area].Events[id]) == 'function' and
				global.ZADV.ArData[dname]
				then
					
					for
					indx,ardata in pairs(global.ZADV.ArData[dname])
					do
						if
						not ardata.disabled and
						( (event.name == 0 and event.tick % 10 == indx % 10) or
						event.name ~= 0 )
						then
							
							
							local done, err = pcall(ZADV.Data[edata.mod][edata.area].Events[id], event,  global.ZADV.ArData[dname][indx], game)
							if not done and err then
								debug("\n%s.on_event[%s] return with error:\n--\t%s\n", dname, id, err)
							end
						
						elseif
						ardata.disabled
						then
						
							global.ZADV.ArData[dname][indx] = nil
							
							local cnt = 0
							for i in pairs(global.ZADV.ArData[dname]) do cnt = cnt+1 end
							
							if cnt == 0 then
								
								global.ZADV.ArData[dname] = nil
								global.ZADV.Events[id][dname] = nil
								
							end
							
end end end end end end end


--
-- EVENTS
--

--- new chunk generated event handler
local function GenerateChunkArea( event )
	
	-- not initialized or disabled or wrong surface?
	if not ZADV_initialized or global.ZADV_DISABLED
	or event.surface ~= game.surfaces[ZADV.MainSurface]
	or event.surface_index
	then return false end
	
	-- event lock
	if global.ZADV_InProcess then return
	else global.ZADV_InProcess = true end
	
	-- variables
	local position = Area.center(event.area)
	local cpos = ChunkFromPosition(position)
	local skip_chunk = false
	
	-- get chunk data
	global.ZADV.Chunks = global.ZADV.Chunks or {}
	if global.ZADV.Chunks[cpos.x] and global.ZADV.Chunks[cpos.x][cpos.y] then
		skip_chunk = global.ZADV.Chunks[cpos.x][cpos.y] end
	
	-- check collisions and if true - ignore chunk
	if CollisionCheckArea(event.surface, event.area) then 
		skip_chunk = true
	end
	
	-- check if chunk already generated or in starting area - ignore if true
	if skip_chunk or isInsideBounds(position, ZADV.Settings['zadv_starting_radiius']) then
		-- event unlock and exit
		global.ZADV_InProcess = false
		return
	end
	
	-- get random area
	local newarea = GetRandomArea(position)
	
	-- if we get one...
	if newarea then
	
		-- check area size
		if newarea.area.size.x > 32 or newarea.area.size.y > 32 then
			
			global.ZADV_NextForceUnlock = game.tick + 300
			global.ZADV_ForceUnlock = true
			
			-- apply offset to x
			if position.x < 0 then position.x = position.x - 16
			else position.x = position.x + 16 end
			
			-- apply offset to y
			if position.y < 0 then position.y = position.y - 16
			else position.y = position.y + 16 end
			
			-- calculate new area box
			newarea.bigchunkarea = {
				left_top={x = position.x-(newarea.area.size.x/2), y = position.y-(newarea.area.size.y/2)},
				right_bottom={x = position.x+(newarea.area.size.x/2), y = position.y+(newarea.area.size.y/2)}
			}
			
			-- re-check collisions
			if CollisionCheckArea(event.surface, newarea.bigchunkarea) then
				return
			end
			
			-- mark chunks
			global.ZADV.Chunks[cpos.x] = {}
			global.ZADV.Chunks[cpos.x-1] = {}
			global.ZADV.Chunks[cpos.x+1] = {}
			global.ZADV.Chunks[cpos.x][cpos.y+1] = true
			global.ZADV.Chunks[cpos.x][cpos.y-1] = true
			global.ZADV.Chunks[cpos.x-1][cpos.y] = true
			global.ZADV.Chunks[cpos.x-1][cpos.y-1] = true
			global.ZADV.Chunks[cpos.x-1][cpos.y+1] = true
			global.ZADV.Chunks[cpos.x+1][cpos.y] = true
			global.ZADV.Chunks[cpos.x+1][cpos.y-1] = true
			global.ZADV.Chunks[cpos.x+1][cpos.y+1] = true
		
		end
		
		-- let's build it
		newarea.chunkarea = event.area
		AplyBlueprintAuto(event.surface, position, newarea)
		
		-- mark chunk
		global.ZADV.Chunks[cpos.x] = {}
		global.ZADV.Chunks[cpos.x][cpos.y] = true
	
	end
	
	-- event unlock
	if not global.ZADV_ForceUnlock then global.ZADV_InProcess = false end
	
end


script.on_event(defines.events.on_tick, Global_Handler)
script.on_event(defines.events.on_chunk_generated, GenerateChunkArea)
--script.on_event(defines.events.on_chunk_charted, GenerateChunkArea)

--
-- Script commands
--

remote.add_interface("ZADV", {

	-- /c remote.call("ZADV", "debug_lvl", 0)
	debug_lvl = function(lvl)
		
		if not lvl then lvl = 0 end
		if type(lvl) == 'string' then lvl = tonumber(lvl) end
		if type(lvl) == 'number' then
			lvl = math.min(3,math.max(0,lvl))
			if ZADV.debug ~= lvl then game.print("Debug level set to "..lvl) end
			ZADV.debug = lvl
			debug("Debug level set to "..lvl)
		else
			game.print("Incorrect 3rd argument, number expected")
		end
		
	end,

	-- /c remote.call("ZADV", "force_reveal", true)
	force_reveal = function(state)
		ZADV.force_reveal = state
		game.print("Force reveal = ".. tostring(state))
	end,

	-- /c remote.call("ZADV", "dump")
	dump = function()
		ZADV.debug_pulse = true
		game.print("Data dump created")
	end,
})

