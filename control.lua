local md5 = require("lib/format/md5")
require 'stdlib/area/position'
require 'stdlib/area/area'
require 'stdlib/table'
require 'lib/bplib'

--
-- variables
--

local format = string.format
local floor = math.floor
serpd = serpent.dump
serpb = serpent.block


--
-- debug settings
--

local function debug ( msg, ... )
	if type(msg) == 'table' then
		if global.ZADV.debug >= 1 then log("\n[[ZADV]] ".. serpent.block(msg)) end
	else
		if type(msg) ~= 'string' then
			msg = tostring(msg)
		end
		log("[[ZADV]] ".. format(msg,...))
		if global.ZADV.debug >= 2 and game and string.len(msg) <= 200 then 
			game.print(format(msg,...))
		end
	end
end

function errlog(name, msg, ...)
	
	global.ZADV.errors[name] = global.ZADV.errors[name] or {}
	
	local str = string.format(msg, ...)
	
	table.insert(global.ZADV.errors[name], {[game.tick] = str})
	
	log("[[ZADV]] ".. str)
	if game and string.len(str) <= 200 then 
		game.print(str)
	else
		game.print(string.format('%s... More info in log file.',str:sub(1,170)))
	end
	
end


--
-- Functions
--

--- Integer to base with up rounding
-- @param T : to be searched
-- @param ... : arguments what to search
-- @return possitive integer rounded up to neares solid number
function table.contains( T, ... )
	local args = ...
	local func = function(v,k, arg)
		if v == arg or ( type(v) == 'table' and v.name == arg) then
		return true else return false end
	end
	if type(args) == 'table' then
		for _,v in pairs(args) do
			if table.find(T, func, v) == nil then
				return false
			end
		end
	end
	return table.any(T, func, args) ~= nil
end

--- Get table pairs lenght
-- @param T : table
-- @return table length
function table.length(T)
	local count = 0
	for k,v in pairs(T) do if v then count = count + 1 end end
	return count
end

--- Integer to base with up rounding
-- @param int
-- @return possitive integer rounded up to neares solid number
local function base( int )
	int = tonumber(int)
	return math.floor((int < 0 and 0 - int or int)  + 0.5)
end

--- Check if position inside restricted area
-- @param distance : from position in chunks
-- @param position : {x,y} array current position
-- @return true if the position inside area, false otherwise
local function isInsideBounds( position, distance )
	for _,sp in pairs(global.ZADV.StartingAreas) do
		if Area.inside(Area.expand(sp.area, math.max(0,((distance or 14)-14)*32)), position) then
		return true end
	end
	return false
end

--- Collision check on surface in selected area
-- @param surface : LuaSurface instance
-- @param area : BoundingBox {left_top :: Position, right_bottom :: Position}
-- @return true if area have collision tles, false otherwise
local function AreaHasCollisions(surface, area)
	if not area then return false end
	local types = {"unit", "unit-spawner", "corpse", "resource"} -- , "simple-entity", "cliff"
	for t,_ in pairs(global.ZADV.UsedTypes) do table.insert(types, t) end
	local water = surface.count_tiles_filtered{area=area, collision_mask="water-tile"}
	if water > 0 or surface.count_entities_filtered{area=area, type=types} > 0 then
	return true else return false end
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
function ZADV_Rnd(min,max,adseed)

	min = min or 1
	max = max or 1000
	
	global.ZADV.seed = (global.ZADV.seed or game.tick) + (adseed or game.tick)
	global.ZADV.seed = global.ZADV.seed < 0 and 0 - global.ZADV.seed or global.ZADV.seed
	global.ZADV.seed = global.ZADV.seed >= 2^32-1 and 1 or global.ZADV.seed
	
	global.ZADV.generator.re_seed(global.ZADV.seed)
	
	return math.min(max, math.max(min, floor(global.ZADV.generator(min, math.max(min, base(max + global.ZADV.seed))) % max) ) )
	
end

--- Calculates the chunk coordinates for the tile position given
--  @param position to calculate the chunk for
--  @return the chunk position as a table
local function ChunkFromPosition(position)
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

--- Force create entity
-- @param array data
function ZADV_ForceCreateEntity(surface, name, pos, force, dir)
	
	local atempts = math.min(15, math.max(3, game.speed * 3))
	
	for i=1,atempts do
		for _,e in pairs(surface.find_entities_filtered{area=Position.expand_to_area(pos, 0.2)}) do e.destroy() end
		local ent = surface.create_entity{name=name, position=pos, force=force, direction=dir or 0}
		if ent and ent.valid then return ent end
	end
	
	return false
	
end


--
-- Area generation
--

--- Prepare operable blueprint
local function PrepareBlueprint()
	
	if not global.ZADV.Blueprint then
		
		if not game.surfaces['ZADV_SURFACE'] then
			game.create_surface("ZADV_SURFACE",{width=3,height=3,peaceful_mode=true})
			debug("Creating operable surface")
		end
		
		local entity = game.surfaces['ZADV_SURFACE'].create_entity{name="wooden-chest", position={0,0}, force=game.forces["neutral"]}
		entity.insert{name="blueprint", count=1}
		debug("Creating operable entity")
		
		global.ZADV.Blueprint = entity.get_inventory(defines.inventory.chest).find_item_stack("blueprint")
		debug("Creating operable blueprint")
		
	end
	
end

--- Create operable blueprint
local function CreateBlueprint()
	
	if not game.surfaces['ZADV_SURFACE'] then
		game.create_surface("ZADV_SURFACE",{width=3,height=3,peaceful_mode=true})
		debug("Creating operable surface")
	end
	
	local entity = game.surfaces['ZADV_SURFACE'].create_entity{name="wooden-chest", position={0,0}, force=game.forces["neutral"]}
	entity.insert{name="blueprint", count=1}
	debug("Creating operable entity")
	
	local blueprint = entity.get_inventory(defines.inventory.chest).find_item_stack("blueprint")
	debug("Creating operable blueprint")
	
	return blueprint
	
end

--- Clear blueprint
local function ClearBlueprint()
	
	if not game.surfaces['ZADV_SURFACE'] then return end
	
	for _,ent in pairs(game.surfaces['ZADV_SURFACE'].find_entities_filtered{position={0,0}}) do
		if ent and ent.valid then ent.destroy() end
	end
	
end

--- Parse blueprint
-- @param bp : blueprint string
-- @param center : initial position to aply offset
-- @return array of entities
local function ParseBlueprint(bp, center)

	local ret, indx, bp = {}, 1, BPlib.ParseToArray(bp)
	
	ret.e = bp.blueprint.entities and {} or nil
	ret.t = bp.blueprint.tiles and {} or nil
	
	for _,e in pairs(bp.blueprint.entities) do
		
		local id = e.entity_number or indx
		e.id = id
		e.entity_number = nil
		e.position = Position.offset(e.position, center.x, center.y)
		
		ret.e[e.id] = table.deepcopy(e)
		indx = indx + 1
	end
	
	for _,t in pairs(bp.blueprint.tiles or {}) do
		
		t.position = Position.offset(t.position, center.x, center.y)
		table.insert(ret.t, t)
	end
		
	return ret
	
end

--- Area preparation to deploy
-- @param surface : Surface to build on
-- @param center : The position to build at
-- @param newarea : blueprint to build
-- @return updated newarea
-- @return array or area coordinates
-- @return corrected center
local function PrepareNewArea(surface, center, newarea)
	
	debug("New area: %s [%s]",newarea.name ,newarea.current_force)
	
	-- force
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
		newarea.direction = math.min(4,ZADV_Rnd(1,5))*2-2
	else
		newarea.direction = 0
	end
	
	-- recalculate area sizes
	local c = math.ceil
	local area = {
		{ c(center.x)-(newarea.area.size.x/2)-1, c(center.y)-(newarea.area.size.y/2)-1 },
		{ c(center.x)+(newarea.area.size.x/2)+1, c(center.y)+(newarea.area.size.y/2)+1 }
	}
	center = Area.center(area)
	
	debug('a:%s  s:%s',base(area[1][1])-base(area[2][1]),newarea.area.size.x)
	
	-- remove rocks and cliffs
	for _,r in pairs(surface.find_entities_filtered{area=Area.expand(area,1), type={"cliff"}}) do --"simple-entity"
		if r and r.valid then r.die('neutral') end
		if r and r.valid then r.destroy() end
	end
	
	return newarea, area
	
end

--- Create entity manualy
-- @param surface : Surface to build on
-- @param ent : entity data
-- @param force : string or LuaForce
-- @return LuaEntity reference
local function PlaceEntity(surface, ent, force)
	
	local e, done, attempts = {}, false, 3
		
	while not done do
	
		e = surface.create_entity{
			 name = ent.name
			,position = ent.position
			,direction = ent.direction or 0
			,force = force
			
			-- assembling-machine
			,recipe = ent.recipe -- string (optional)

			-- container
			,bar = ent.bar -- uint (optional): Inventory index where the red limiting bar should be set.

			-- flying-text
			,text = ent.text -- LocalisedString: The string to show.
			,color = ent.color -- Color (optional): Color of the displayed text.

			-- entity-ghost
			,inner_name = ent.inner_name -- string: The prototype name of the entity contained in the ghost.
			,expires = ent.expires -- boolean (optional): If false the ghost entity will not expire. Default is false.

			-- fire
			,initial_ground_flame_count = ent.initial_ground_flame_count -- uint: With how many small flames should the fire on ground be created.

			-- inserter
			,conditions = ent.conditions or {
				 circuit = ent.circuit -- CircuitCondition (optional)
				,logistics = ent.logistics -- CircuitCondition (optional)
			}
			,filters = ent.filters -- array of Filter

			-- item-entity
			,stack = ent.stack -- SimpleItemStack: The stack of items to create. This must be a table, i.e. a single string is not allowed here.

			-- item-request-proxy
			,target = ent.target -- LuaEntity: The target items are to be delivered to.
			,modules = ent.modules -- dictionary string → uint: The stacks of items to be delivered to target entity from logistic network.

			-- logistic-container
			,request_filters = ent.request_filters -- array of Filter (optional)

			-- particle
			,movement = ent.movement -- Vector
			,height = ent.height -- float
			,vertical_speed = ent.vertical_speed -- float
			,frame_speed = ent.frame_speed -- float

			-- projectile
			,speed = ent.speed -- double
			,max_range = ent.max_range -- double

			-- resource
			,amount = ent.amount -- uint
			,enable_tree_removal = ent.enable_tree_removal -- boolean (optional): If colliding trees are removed normally for this resource entity based off the prototype tree removal values. Default is true.
			,enable_cliff_removal = ent.enable_cliff_removal -- boolean (optional): If colliding cliffs are removed. Default is true.

			-- underground-belt
			,type = ent.type -- string (optional): "output" or "input"; default is "input".

			-- programmable-speaker
			,parameters = ent.parameters -- ProgrammableSpeakerParameters (optional)
			,alert_parameters = ent.alert_parameters -- ProgrammableSpeakerAlertParameters (optional)

			-- character-corpse
			,inventory_size = ent.inventory_size -- uint (optional)
			,player_index = ent.player_index -- uint (optional)
		}
		
		if e and e.valid then
			return e
			
		elseif attempts >= 3 then
			attempts = attempts - 1
			
		elseif attempts <= 0 then
			done = true
			
		end
		
	end
	
	return false
	
end

--- Adjust entity with additional options
-- @param entity : LuaEntity
-- @param data : Area data
local function AdjustEntities(ent, data)
	
	-- store type for future checks
	global.ZADV.UsedTypes[ent.type] = true
	
	-- Deactivating an entity will stop all its operations (inserters will stop working)
	ent.active = data.active
	
	-- Not minable entities can still be destroyed
	ent.minable = data.minable
	
	-- When the entity is not destructible it can't be damaged
	ent.destructible = data.destructible
	
	-- Replace entities with their remains if they have it
	if data.remains then
		ent.die('neutral')
	end
	
	-- Set health in procentage of the entity. Entities with 0 health can not be attacked. Setting health to higher than max health will set health to max health
	if data.health >= 0 then
		ent.health = ent.prototype.max_health * (data.health/100)
	end
	
	-- Player can't open gui of this entity and he can't quick insert/input stuff in to the entity when it is not operable
	ent.operable = data.operable
	
	-- Sets the entity to be deconstructed by construction robots
	if data.order_deconstruction then
		ent.order_deconstruction(data.current_force)
	end
	
	-- When entity is not to be rotatable (inserter, transport belt etc), it can't be rotated by player using the R key
	ent.rotatable = data.rotatable
	
end

--- Save results of nea area creation
-- @param surface : LuaSurface
-- @param data : working area field
-- @param newarea : Area base data
-- @param areadata : Area working data
local function SaveNewAreaData(surface, area, newarea, areadata)
	
	if ZADVData[newarea.modname][newarea.bpname].Events and type(ZADVData[newarea.modname][newarea.bpname].Events) == 'table' then
		for evnt,func in pairs(ZADVData[newarea.modname][newarea.bpname].Events) do
			if evnt and type(func) == 'function' then
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
	ZADV_ReEvent()
	
	-- remove unfinished deconstruction
	surface.cancel_deconstruct_area{area=area, force=newarea.current_force}
	
	-- force chart area
	if global.ZADV.debug >= 2 or newarea.force_reveal or global.ZADV.force_reveal then
	
		local area2d = newarea.workarea
		
		area2d.right_bottom.x = area2d.right_bottom.x - 1
		area2d.right_bottom.y = area2d.right_bottom.y - 1
		
		for _,f in pairs(game.forces) do
		if f.name ~= 'neutral' and f.name ~= 'enemy' then
			f.chart(surface, area2d)
		end end
		
	end
	
	-- shoot the message
	local possiblemessages = {}
	
	for _,m in pairs(newarea.messages) do
		if m.msg:len() > 0 then table.insert(possiblemessages, m) end
	end
	
	if #possiblemessages > 0 then
		local message = possiblemessages[ZADV_Rnd(1,#possiblemessages)]
		pcall(game.print, message.msg, message.color)
	end
	
end

--- Randomize and prepare new area
-- @param seed : center of new chunk
-- @return table area data
local function GetRandomArea(pos, surface)
	
	local seed = pos.x + pos.y
	
	-- randomize global step
	local roll = ZADV_Rnd(1,1000,seed)
	if roll > tonumber(global.ZADV.Settings['zadv_global_frequency']) then return false end
	
	-- run through the list of areas
	local areas = {}
	roll = ZADV_Rnd(1,1000,seed)

	for mn,mod in pairs(ZADVData) do
		for an,ar in pairs(mod) do
			
			global.ZADV.RestrictedAreas = global.ZADV.RestrictedAreas or {}
			global.ZADV.copy_per_force = global.ZADV.copy_per_force or {}
			if not ar.current_force or ar.current_force == nil then 
				ZADVData[mn][an].current_force = ZADVData[mn][an].force or 'neutral'
				ar.current_force = ar.force or 'neutral'
			end
			local nf = tostring(mn) ..'-'.. tostring(an) ..'-'.. (ar.current_force or ar.force)
			
			if ar.only_freeplay and global.ZADV.PVP_MODE then
				global.ZADV.RestrictedAreas[nf] = true
			end
			
			-- force check
			local skip_force = false
			
			if not global.ZADV.RestrictedAreas[nf] and ar.unique and ar.force == 'player' then
				
				ZADVData[mn][an].max_copies = 1
				global.ZADV.copy_per_force[ar.name] = global.ZADV.copy_per_force[ar.name] or {}
				
				if global.ZADV.PVP_MODE then
				
					local teams = {}
					for _,t in pairs(global.ZADV.teams) do
						if not global.ZADV.copy_per_force[ar.name][t]
						or tonumber(global.ZADV.copy_per_force[ar.name][t]) > 0 then
							table.insert(teams,t)
						end
					end
					
					if not table.length(teams) then
						global.ZADV.RestrictedAreas[nf] = true
						
					else
						local _force = teams[ZADV_Rnd(1,#teams,seed)] or 'neutral'
						
						if FindNearestPlayer(pos).force.name ~= _force then
							skip_force = true
						else
							ZADVData[mn][an].current_force = _force or 'neutral'
							nf = ar.name ..'-'.. _force
						end
					end
				
				else
			
					if not global.ZADV.copy_per_force[ar.name][ar.force] then
						ZADVData[mn][an].max_copies = 1
					else
						global.ZADV.RestrictedAreas[nf] = true
					end
					
				end
			end
			
			-- Check if last copy too close
			local skip_distance = false
			ZADVData[mn][an].copies = ZADVData[mn][an].copies or {}
			if #ZADVData[mn][an].copies then
				for _,p in pairs(ZADVData[mn][an].copies) do
					if Position.distance(p, pos) < ar.nearest_copy * 32 then
						skip_distance = true
					end
				end
			end
			
			
			-- check if no more copiees allowed
			if not global.ZADV.RestrictedAreas[nf] and not skip_force and not skip_distance
			and (roll <= ar.probability + (global.ZADV.debug*200)) then
				
				-- technology check
				local techallow = false
				if ar.ignore_technologies or global.ZADV.debug == 2 then
					techallow = true
				elseif ar.techs then
					techallow = true
					for _,f in pairs(game.forces) do
					for _,t in pairs(ar.techs) do
					if not f.technologies[t].researched then
						techallow = false
					end end	end
					if not techallow then debug('Not enough technologies for "%s - %s", skip this time..',mn,an) end
				end
				
				-- placeing check
				local placeallow = true
				
				if isInsideBounds(pos, ar.remoteness_min or ZADVData[mn][an].remoteness_min) then
					placeallow = false
					
				elseif ( ZADVData[mn][an].remoteness_max ~= 0 and not isInsideBounds(pos, ar.remoteness_max or ZADVData[mn][an].remoteness_max) ) then
					placeallow = false
					
				end
				
				-- all checks done
				if techallow and placeallow then
					-- store triggered area
					table.insert(areas, {mn,an})
				end
				
			end
			
	end end
	
	-- if we have multiple triggered areas - choose one
	if table.length(areas) > 0 then
		roll = (ZADV_Rnd(1,1000,seed) % #areas) + 1
		areas = areas[roll]
		
	-- nothing to do
	else return false end
	
	local a,b = areas[1],areas[2]
	local n,f = ZADVData[a][b].name,ZADVData[a][b].current_force
	local nf = n..'-'..f
	
	-- check area size
	if ZADVData[a][b].area.size.x > 32 or ZADVData[a][b].area.size.y > 32 then
		
		global.ZADV.NextForceUnlock = game.tick + 300
		global.ZADV.ForceUnlock = true
	
	end
	
	local newpos = table.deepcopy(pos)
	local offset_x, offset_y
	
	if ZADVData[a][b].area.size.x < 30 then
		offset_x = math.floor((ZADV_Rnd(1,1000,seed) % (30 - ZADVData[a][b].area.size.x)) * (ZADV_Rnd(1,1000,seed) > 500 and 1 or -1) / 2)
		newpos = Position.offset(newpos, offset_x, 0)
	end
	
	if ZADVData[a][b].area.size.y < 30 then
		offset_y = math.floor((ZADV_Rnd(1,1000,seed) % (30 - ZADVData[a][b].area.size.y)) * (ZADV_Rnd(1,1000,seed) > 500 and 1 or -1) / 2)
		newpos = Position.offset(newpos, 0, offset_y)
	end
	
	-- check remoteness from last area
	local buffer = 32
	local newradius = math.max(ZADVData[a][b].area.size.x, ZADVData[a][b].area.size.y)/2
	buffer = buffer + newradius
	if global.ZADV.lastArea and Position.distance(global.ZADV.lastArea.pos, newpos) < global.ZADV.lastArea.halfsize + buffer then return false end 
	
	-- calculate new area box
	ZADVData[a][b].workarea = {
		{newpos.x-(ZADVData[a][b].area.size.x/2), newpos.y-(ZADVData[a][b].area.size.y/2)},
		{newpos.x+(ZADVData[a][b].area.size.x/2), newpos.y+(ZADVData[a][b].area.size.y/2)}
	}
		
	-- re-check collisions
	ZADVData[a][b].lastcollisioncheck = AreaHasCollisions(surface, ZADVData[a][b].workarea)
	if ZADVData[a][b].lastcollisioncheck then
		return false
	end
	
	-- decrease copies counter
	local copy_left = ZADVData[a][b].max_copies
	if copy_left and copy_left > 0 then
		
		global.ZADV.copy_per_force[n] = global.ZADV.copy_per_force[n] or {}
	
		if ZADVData[a][b].force == 'player' and global.ZADV.PVP_MODE then
			
			for _,t in pairs(global.ZADV.teams) do
				if not global.ZADV.copy_per_force[n][t] then
					global.ZADV.copy_per_force[n][t] = copy_left
				end
			end
			
		else
			global.ZADV.copy_per_force[n][f] = 
				global.ZADV.copy_per_force[n][f] or copy_left
		
		end
		
		global.ZADV.copy_per_force[n][f] = 
			global.ZADV.copy_per_force[n][f] < 0 and -10
			or ZADVData[a][b].unique and 0 or math.max(0, global.ZADV.copy_per_force[n][f] - 1)
			
	end
	
	-- save last position
	ZADVData[a][b].copies = ZADVData[a][b].copies or {}
	table.insert(ZADVData[a][b].copies, newpos)
	
	-- if only once or no more copiees
	if ZADVData[a][b].only_once or copy_left then
		global.ZADV.copy_per_force[n] = global.ZADV.copy_per_force[n] or {}
		global.ZADV.RestrictedAreas[nf] = ZADVData[a][b].only_once or global.ZADV.copy_per_force[n][f] == 0
	end
	
	-- increace remotness
	if ZADVData[a][b].progressive_remoteness > 0 then
		ZADVData[a][b].remoteness_min = ZADVData[a][b].remoteness_min + ZADVData[a][b].progressive_remoteness
	end
	
	-- save last area position
	global.ZADV.lastArea = {pos = newpos, halfsize = newradius}
	
	-- return area
	return ZADVData[a][b], newpos
	
end

--- place blueprint automaticly
-- @param surface : Surface to build on
-- @param center : The position to build at
-- @param newarea : blueprint to build
local function AplyBlueprintAuto(surface, center, newarea)
	
	-- fault check
	if not newarea or not center or not surface then return end
	
	-- prepare blueprint
	global.ZADV.Blueprint.import_stack(type(newarea.bp) == 'table' and newarea.bp[ZADV_Rnd(1,#newarea.bp)] or newarea.bp)
	if global.ZADV.Blueprint.is_blueprint_setup() then

		local area = {}
		newarea, area = PrepareNewArea(surface, center, newarea)
		
		--[[ place blueprint on surface ]]--
		local ghosts = global.ZADV.Blueprint.build_blueprint{
			surface=surface,
			force=game.forces[newarea.current_force],	-- modded
			position=center,
			force_build=newarea.force_build,			-- modded
			direction=newarea.direction,				-- modded
			skip_fog_of_war=false
		}
		
		-- local storage
		local locstore = {}
		
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
				
				-- update used types list
				global.ZADV.UsedTypes = global.ZADV.UsedTypes or {}
				
				-- add custom entities
				for _,ent in pairs(newarea.entities) do
					local e = PlaceEntity(surface, ent, newarea.current_force)
					if e and e.valid then
						table.insert(entities, e)
					end
				end
				
				for _,e in pairs(entities) do if e and e.valid then 
					
					-- alpy optional settings
					AdjustEntities(e, newarea)
					
					-- Script for each entity in new area
					if type(newarea.ScriptForEach) == 'function' then
					
						local done, err = pcall(newarea.ScriptForEach, game, surface, newarea.current_force, area, center, e, newarea.names or {}, locstore, areadata)
						if not done and err then
							errlog(newarea.name ..'ScriptForEach', "\n[%s].ScriptForEach error::\n\t%s\n", newarea.name, err:gsub('function ',''))
						end
						
						if global.ZADV.debug >= 2 and newarea.name:find('TEST') then
							local _testfunc = loadstring(serpd(function(game, surface, force, area, center, entity, namelist, locstore, areadata)
-------------------------------------------------------------------------------------------------------------------------------------------
----v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v----
-------------------------------------------------------------------------------------------------------------------------------------------
	
	
	
-------------------------------------------------------------------------------------------------------------------------------------------
----^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^--------
-------------------------------------------------------------------------------------------------------------------------------------------
							end))()
							done, err = pcall(_testfunc, game, surface, newarea.current_force, area, center, e, newarea.names or {}, locstore, areadata)
							if not done and not global.ZADV.errors[newarea.name ..'ScriptForEach [[DEBUG]]'] then
								debug("\n[[DEBUG]]\n[%s].ScriptForEach error::\n\t%s\n", newarea.name, err:gsub('function ',''))
							end
						end
						
					end
					
				end end
			end
		else
			entities = ghosts
		end
		
		
		-- Script for all entities in new area
		if type(newarea.ScriptForAll) == 'function' then
		
			local done, err = pcall(newarea.ScriptForAll, game, surface, newarea.current_force, area, center, newarea.names or {}, entities or {}, areadata, locstore)
			if not done and err then
				errlog(newarea.name ..'_ScriptForAll', "\n[%s].ScriptForAll error::\n\t%s\n", newarea.name, err:gsub('function ',''))
			end
			
			if global.ZADV.debug >= 2 and newarea.name:find('TEST') then
				local _testfunc = loadstring(serpd(function(game, surface, force, area, center, namelist, entitylist, areadata, locstore)
-------------------------------------------------------------------------------------------------------------------------------------------
----v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v----
-------------------------------------------------------------------------------------------------------------------------------------------
	
	
	
-------------------------------------------------------------------------------------------------------------------------------------------
----^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^--------
-------------------------------------------------------------------------------------------------------------------------------------------
				end))()
				done, err = pcall(_testfunc, game, surface, newarea.current_force, area, center, newarea.names or {}, entities or {}, areadata, locstore)
				if not done and not global.ZADV.errors[newarea.name ..'_ScriptForAll [[DEBUG]]'] then
					debug("\n[[DEBUG]]\n[%s].ScriptForAll error::\n\t%s\n", newarea.name, err:gsub('function ',''))
				end
			end
		end
		
		-- Event handling
		
		if global.ZADV.debug >= 2 and newarea.name:find('TEST') then
		--	ZADVData[newarea.modname][newarea.bpname].Events = {
-------------------------------------------------------------------------------------------------------------------------------------------
----v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v----
-------------------------------------------------------------------------------------------------------------------------------------------
	
	
	
-------------------------------------------------------------------------------------------------------------------------------------------
----^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^--------
-------------------------------------------------------------------------------------------------------------------------------------------
		--	}
		end
		
		-- save progress
		SaveNewAreaData(surface, area, newarea, areadata)
		
		-- erase blueprint
		global.ZADV.Blueprint.clear_blueprint()
	
	end
	
end

--- place blueprint directly
-- @param surface : Surface to build on
-- @param center : The position to build at
-- @param newarea : blueprint to build
local function AplyBlueprintManualy(surface, center, newarea)
	
	-- fault check
	if not newarea or not center or not surface then return end
	
	--game.print('Parsed BP 1')
	local bpar = ParseBlueprint((type(newarea.bp) == 'table' and newarea.bp[ZADV_Rnd(1,#newarea.bp)] or newarea.bp), center)
	if not bpar or type(bpar.e) ~= 'table' then error(format('Invalid blueprint for area "%s"',newarea.name)); return end
	
	debug(bpar)
	
	-- preparations
	local area = {}
	newarea, area = PrepareNewArea(surface, center, newarea)
	
	-- prepare areadata
	global.ZADV.ArData = global.ZADV.ArData or {}
	local areadata = table.deepcopy(newarea.areadata) or {}
	
	-- temporal data storage
	local locstore = {}
	
	-- deploy tiles
	if bpar.t then
		surface.set_tiles(bpar.t, true)
	end
	
	-- add custom entities
	for _,ent in pairs(newarea.entities) do
		ent.id = math.max(1,ent.id) + #bpar.e
		ent.position = Position.offset(ent.position, center.x, center.y)
		bpar.e[#bpar.e+1] = ent
	end
	
	-- deploy entities
	local entities = {}
	for k,ent in pairs(bpar.e) do
		
		local e = PlaceEntity(surface, ent, newarea.current_force)
		if e and e.valid then
			
			-- alpy optional settings
			AdjustEntities(e, newarea)
			
			-- Script for each entity in new area
			if type(newarea.ScriptForEach) == 'function' then
				
				local done, err = pcall(newarea.ScriptForEach, game, surface, newarea.current_force, area, center, e, newarea.names or {}, locstore, areadata)
				if not done and err then
					errlog(newarea.name ..'ScriptForEach', "\n[%s].ScriptForEach error::\n\t%s\n", newarea.name, err:gsub('function ',''))
				end
				
			end
			
			table.insert(entities, e)
		end
		
	end
		
	-- Script for all entities in new area
	if type(newarea.ScriptForAll) == 'function' then
	
		local done, err = pcall(newarea.ScriptForAll, game, surface, newarea.current_force, area, center, newarea.names or {}, entities or {}, areadata, locstore)
		if not done and err then
			errlog(newarea.name ..'_ScriptForAll', "\n[%s].ScriptForAll error::\n\t%s\n", newarea.name, err:gsub('function ',''))
		end
		
	end
	
	-- save progress
	SaveNewAreaData(surface, area, newarea, areadata)
	
end



--
-- EVENTS
--

--- new chunk generated event handler
local function GenerateArea( event )
	
	-- not initialized or disabled or wrong surface?
	if not global.ZADV.Initialized or global.ZADV.GLOBALY_DISABLED
	or event.surface_index or event.surface ~= game.surfaces[global.ZADV.MainSurface]
	then return false end
	
	-- event lock
	if global.ZADV.InProcess then return
	else global.ZADV.InProcess = true end
	
	-- variables
	local position = Area.center(event.area)
	local skip_chunk = false
	
	-- check collisions and if true - ignore chunk
	if AreaHasCollisions(event.surface, event.area) then 
		skip_chunk = true
	end
	
	-- check if chunk already generated or in starting area - ignore if true
	if skip_chunk or isInsideBounds(position, global.ZADV.Settings['zadv_starting_radius']) then
		-- event unlock and exit
		global.ZADV.InProcess = false
		return
	end
	
	-- get random area
	local newarea, newposition = GetRandomArea(position, event.surface)
	
	-- if we get one...
	if newarea then
	
		-- let's build it
		newarea.workarea = event.area
	
		local pos = newposition
		local area = newarea
		local done, err, func = false, '', ''
		
		if area.ignore_water or area.ignore_all_collision then
			func = 'AplyBlueprintManualy'
			done, err = pcall(AplyBlueprintManualy, event.surface, pos, area)
		else
			func = 'AplyBlueprintAuto'
			done, err = pcall(AplyBlueprintAuto, event.surface, pos, area)
		end
	
		if not done and err then
			errlog(newarea.name .. func, "\n[%s].%s error::\n\t%s\n", newarea.name, func, err:gsub('function ',''))
	
		elseif global.ZADV.RestrictedAreas[newarea.name ..'-'.. newarea.current_force] then
	
			if newarea.areadata and newarea.areadata.bp then
				newarea.areadata.bp = nil
			end
			
			if global.ZADV.debug == 0 then
				for prop,_ in pairs(newarea) do
					if  prop ~= 'Events'
					and prop ~= 'ScriptForAll'
					and prop ~= 'ScriptForEach'
					and prop ~= 'active'
					and prop ~= 'areadata'
					and prop ~= 'bpname'
					and prop ~= 'current_force'
					and prop ~= 'dangerous'
					and prop ~= 'max_copies'
					and prop ~= 'modname'
					and prop ~= 'name'
					then newarea[prop] = nil end
				end
			end
			
		end
	end
	
	-- event unlock
	if not global.ZADV.ForceUnlock then global.ZADV.InProcess = false end
	
end

--- Global handler
local function Global_Handler( event )
	
	if not global.ZADV.GLOBALY_DISABLED then
		
		ZADV_ReInit()
		
		if global.ZADV.Initialized then
			
			if global.ZADV.debug_pulse then
				global.ZADV.debug_pulse = false
				log(string.format('\n\n[[ZADV Dump]]\nGlobal = %s\nData = %s',serpb(global),serpb(ZADVData)))
				game.print("Data dump created")
			end
			
			if global.ZADV.ForceUnlock and event.tick >= global.ZADV.NextForceUnlock then
				global.ZADV.InProcess = false
				global.ZADV.ForceUnlock = false
				debug("ForceUnlock")
			end
			
			if 
			global.ZADV.Events[event.name]
			then
				for
				dname,edata in pairs(global.ZADV.Events[event.name])
				do
					if
					ZADVData[edata.mod] and
					ZADVData[edata.mod][edata.area] and
					ZADVData[edata.mod][edata.area].Events and
					type(ZADVData[edata.mod][edata.area].Events[event.name]) == 'function' and
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
							
								local done, err = pcall(ZADVData[edata.mod][edata.area].Events[event.name], event,  global.ZADV.ArData[dname][indx], game)
								if not done and err then
									errlog(dname ..'_'.. event.name, "\n%s.on_event[%s] error:\n\t%s\n", dname, event.name, err:gsub('function ',''))
								end
								
							elseif
							ardata.disabled
							then
							
								global.ZADV.ArData[dname][indx] = nil
								
								local cnt = 0
								for i in pairs(global.ZADV.ArData[dname]) do cnt = cnt+1 end
								
								if cnt == 0 then
									global.ZADV.ArData[dname] = nil
									global.ZADV.Events[event.name][dname] = nil
									
								end
								
			end end end end end
		
		end
	end
end

--- Reassign events areas events
function ZADV_ReEvent()
	
	if global.ZADV.Events then
		for event,_ in pairs(global.ZADV.Events) do
			if not script.get_event_handler(event) then
				script.on_event(event, Global_Handler)
			end
		end
	end
	
end

--
-- INITIALIZATION
--

--- detect scenarios
local function detectScenarios()
	
	if not global.ZADV.GLOBALY_DISABLED then
	
		if not global.ZADV.PVP_MODE and table.find(game.surfaces, function(v) if v.name:find('battle_surface_') then return true end end) then
			
			if not global.ZADV.Settings['zadv_disable_in_pvp'] then
				debug('Prepare to PvP...')
				
				local surf = table.find(game.surfaces, function(v) if v.name:find('battle_surface_') then return true end end)
				global.ZADV.MainSurface = surf and surf.name or global.global.ZADV.MainSurface
				
				global.ZADV.teams = {}
				for _,f in pairs(game.forces) do
					if f.name ~= 'player' and f.name ~= 'neutral' and f.name ~= 'enemy' and f.name ~= 'spectator' then
						table.insert(global.ZADV.StartingAreas, {center=f.get_spawn_position(game.surfaces[global.ZADV.MainSurface]), area=Position.expand_to_area(f.get_spawn_position(game.surfaces[ZADV.MainSurface]), 240)})
						table.insert(global.ZADV.teams, f.name)
					end
				end
				
				global.ZADV.PVP_MODE = true
			else
				debug('ZADV_DISABLED - PVP')
				global.ZADV.GLOBALY_DISABLED = true
			end
			
		elseif table.contains( game.forces, {'black','blue','brown','cyan'} ) then
			debug('ZADV_DISABLED - TEAM CHALLANGE')
			global.ZADV.GLOBALY_DISABLED = true
			
		elseif game.tick < 10 and game.surfaces[1].count_entities_filtered{area=Position.expand_to_area({0,0},5), name='rocket-silo'} > 0 then
			debug('ZADV_DISABLED - WAVE DEFENCE')
			global.ZADV.GLOBALY_DISABLED = true
			
		elseif game.tick < 10 and game.surfaces[1].count_entities_filtered{area=Position.expand_to_area({0,0},5), name='red-chest'} > 0 then
			debug('ZADV_DISABLED - SUPPLY CHALANGE')
			global.ZADV.GLOBALY_DISABLED = true
			
		end
		
	end
end

--- Global initialization
local function GetRawData()

	global.ZADV.raw = { d='', s='', u='' }
	local chunks = game.entity_prototypes["ZADV_DATA_C"].order
	local schunks = game.entity_prototypes["ZADV_DATA_S"].order
	local uchunks = game.entity_prototypes["ZADV_DATA_U"].order
	global.ZADV.ControlString = game.entity_prototypes["ZADV_DATA_CS"].order
	global.ZADV.debug = tonumber(game.entity_prototypes["ZADV_DATA_D"].order)
	debug("Set debug level: ".. global.ZADV.debug)
	
	for i=0, chunks-1 do
		local name = "ZADV_DATA_C_"..i
		global.ZADV.raw.d = global.ZADV.raw.d .. game.entity_prototypes[name].order
	end
	
	for i=0, schunks-1 do
		local name = "ZADV_DATA_S_"..i
		global.ZADV.raw.s = global.ZADV.raw.s .. game.entity_prototypes[name].order
	end
	
	for i=0, uchunks-1 do
		local name = "ZADV_DATA_U_"..i
		global.ZADV.raw.u = global.ZADV.raw.u .. game.entity_prototypes[name].order
	end
	
end

local function ParseRawData()
	
	if global.ZADV.raw then
		-- apply parsed data
		ZADVData = loadstring(global.ZADV.raw.d)() or {}
		global.ZADV.Settings = loadstring(global.ZADV.raw.s)() or {}
		local usedTypes = loadstring(global.ZADV.raw.u)() or {}
		debug("Raw data parsed.")
		
		-- set globals
		global.ZADV.UsedTypes = global.ZADV.UsedTypes or {}
		for _,t in pairs(usedTypes) do
			global.ZADV.UsedTypes[t] = true
		end
	end
	
end

local function Init()

	-- global variables
	global.ZADV = global.ZADV or {}
	global.ZADV.Events = global.ZADV.Events or {}
	global.ZADV.errors = global.ZADV.errors or {}
	global.ZADV.InProcess = false
	global.ZADV.ForceUnlock = false
	global.ZADV.NextForceUnlock = 0 
	global.ZADV.EventLock = 0
	global.ZADV.debug = 0

	global.ZADV.Color = {
		orange	= { r = 0.869, g = 0.5  , b = 0.130	},
		purple	= { r = 0.485, g = 0.111, b = 0.659	},
		red		= { r = 0.815, g = 0.024, b = 0.0	},
		green	= { r = 0.093, g = 0.768, b = 0.172	},
		blue	= { r = 0.155, g = 0.540, b = 0.898	},
		yellow	= { r = 0.835, g = 0.666, b = 0.077	},
		pink	= { r = 0.929, g = 0.386, b = 0.514	},
		white	= { r = 0.8  , g = 0.8  , b = 0.8	},
		black	= { r = 0.1  , g = 0.1  , b = 0.1	},
		gray	= { r = 0.4  , g = 0.4  , b = 0.4	},
		brown	= { r = 0.300, g = 0.117, b = 0.0	},
		cyan	= { r = 0.275, g = 0.755, b = 0.712	},
		acid	= { r = 0.559, g = 0.761, b = 0.157	}
	}
	
	-- manage raw data
	GetRawData()
	ParseRawData()
	
	-- blueprint
	PrepareBlueprint()
	
	-- main surface
	global.ZADV.MainSurface = 'nauvis'
	
	-- starting area(s)
	global.ZADV.StartingAreas = {
		{center={x=0,y=0},area={left_top={x=-240,y=-240},right_bottom={x=240,y=240}}}
	}
	
	-- if unsupported challange
	global.ZADV.PVP_MODE = false
	if (global.required ~=nil and global.points ~=nil and global.accumulated ~=nil and global.story ~=nil)
	or (global.afk_time ~=nil and global.points ~=nil and global.round_number ~=nil and global.start_round_tick ~=nil)
	or (global.bounty_bonus ~=nil and global.money ~=nil and global.send_satellite_round ~=nil and global.wave_number ~=nil) then
		debug('ZADV_DISABLED')
		global.ZADV.GLOBALY_DISABLED = true
	end
	
	detectScenarios()
	
	-- randomizer
	global.ZADV.seed = global.ZADV.seed or floor(tonumber(tostring({}):sub(8,-4)))
	global.ZADV.generator = global.ZADV.generator or game.create_random_generator(global.ZADV.seed)
	
	script.on_event(defines.events.on_tick, Global_Handler)
	script.on_event(defines.events.on_chunk_generated, GenerateArea)
	
	if global.ZADV.debug == 0 then
		log("[[ZADV]] Initialization complete.")
	else debug("Initialization complete.") end
	
	global.ZADV.Initialized = true
	
end

local function Load()
	
	ParseRawData()
	ZADV_ReEvent()
	
	script.on_event(defines.events.on_tick, Global_Handler)
	script.on_event(defines.events.on_chunk_generated, GenerateArea)
	
end

function ZADV_ReInit()
	
	if global.ZADV.ControlString ~= game.entity_prototypes["ZADV_DATA_CS"].order then
		
		game.print("[Z] Adventure: New or updated data found. Start re-initialization...", { r = 0.093, g = 0.768, b = 0.172})
		log("[[ZADV]] New or updated data found. Start re-initialization...")
		
		Init()
		
		if global._chunk_data then global._chunk_data = nil end
		if global._chunk_indexes then global._chunk_indexes = nil end
		if global.ZADV.Data then global.ZADV.Data = nil end
		if global.ZADV.NamePairList then global.ZADV.NamePairList = nil end
		if global.ZADV.areadata then
			global.ZADV.areadata = nil
			global.ZADV.restrictedareas = {}
			global.ZADV.copy_per_force = {}
		end
		
	end
	
end

script.on_init(Init)
script.on_load(Load)

--
-- Script commands
--

function ZADV_debug_lvl(args)
	
	local lvl = tonumber(args.parameter)
	if not lvl then lvl = 0 end
	if type(lvl) == 'number' then
		lvl = math.min(3,math.max(0,lvl))
		if global.ZADV.debug ~= lvl then game.print("Debug level set to "..lvl) end
		global.ZADV.debug = lvl
		debug("Debug level set to "..lvl)
	else
		game.print("Incorrect argument, number expected")
	end
	
end

function ZADV_force_reveal()
	global.ZADV.force_reveal =  not global.ZADV.force_reveal
	game.print("Force reveal = ".. tostring(global.ZADV.force_reveal))
end

function ZADV_dump()
	global.ZADV.debug_pulse = true
end

function ZADV_dinfo(args)

	global.ZADV.dinfo = global.ZADV.dinfo or {}
	
	if not global.ZADV.dinfo[args.player_index] then
	
		global.ZADV.dinfo[args.player_index] = game.players[args.player_index].gui.left.add{type='frame', name='ZADV_dinfo', direction='vertical'}
		global.ZADV.dinfo[args.player_index].add{type='label', name='info', direction='vertical', style='zadv_lable_info'}
		
		script.on_event(defines.events.on_tick, function()
			for i,_ in pairs(global.ZADV.dinfo) do
				if global.ZADV.dinfo[i] then
					local pos = game.players[i].position
					local chnk = ChunkFromPosition(pos)
					global.ZADV.dinfo[i]['info'].caption = string.format('Player:\nx = %.2f\ny = %.2f\nChunk:\nx = %.2f\ny = %.2f\nDistance: %.2f',pos.x, pos.y, chnk.x, chnk.y, Position.distance(pos, {x=0,y=0}))
				end
			end
		end)
	
	else 
		global.ZADV.dinfo[args.player_index].destroy()
		global.ZADV.dinfo[args.player_index] = false
	end
end

function ZADV_errors()
	log(string.format('\n[[ZADV Errors]]\n%s', serpent.block(global.ZADV.errors)))
end


-- /command arg
commands.add_command("zadv_debug", "",	ZADV_debug_lvl)
commands.add_command("zadv_reveal", "",	ZADV_force_reveal)
commands.add_command("zadv_dump", "",	ZADV_dump)
commands.add_command("zadv_dinfo", "",	ZADV_dinfo)
commands.add_command("zadv_errors", "",	ZADV_errors)
