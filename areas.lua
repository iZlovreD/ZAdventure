
local areas = {}

areas['test'] = {

	-- Area blueprint string. "" to ignore whole area
	-- Areas larger than 64x64 will be ignored (temporarily)
	bp = ""
	
	
	-- blueprint options
	,probability = 100						-- [default: 100] from 1 to 1000 (*0.1%)
	,remoteness = 10						-- [default: 10] minimal distance in chunks (32x32) from starting point
	,ignore_technologies = true				-- [default: true] If false, only if all necessary technologies is learned - area can be placed
	,force = "neutral"						-- [default: "neutral"] "player", "neutral", "enemy" or custom name to use/create new Force to use for the building
	,random_direction = false				-- [default: false] When true, area will be randomly rotated to one of four direction (north, east, south, west) each time when placed on surface
	,force_build = true						-- [default: true] When true, anything that can be built is else nothing is built if any one thing can't be built. When false, all additional options for entities belw will be ignored
	,finalize_build = true					-- [default: true] Build entities; place ghosts if "false"
	,force_reveal = false					-- [default: false] If "true" area will be revealed after build
	,ignore_water = false					-- [default: false] If "true" ignore water and place entities above them (entities may be unreachable)
	,ignore_all_collision = false			-- [default: false] If "truth" ignores all possible collisions and places entities on top of them (performance lags while placing area)


	-- additional options will be applied
	-- for each entity if allowed to do so
	-- comment/delete line to exclude
	,active = true							-- [default: true] Deactivating an entity will stop all its operations (inserters will stop working)
	,minable = true							-- [default: true] Not minable entities can still be destroyed
	,destructible = true					-- [default: true] When the entity is not destructible it can't be damaged
	,remains = false						-- [default: false] Replace entities with their remains if they have it
	,health = -1							-- [default: -1 (ignored)] Set health in procentage of the entity. Entities with 0 health can not be attacked. Setting health to higher than max health will set health to max health
	,operable = true						-- [default: true] Player can't open gui of this entity and he can't quick insert/input stuff in to the entity when it is not operable
	,order_deconstruction = false			-- [default: false] Sets the entity to be deconstructed by construction robots
	,rotatable = true						-- [default: true] When entity is not to be rotatable (inserter, transport belt etc), it can't be rotated by player using the R key


	--- Script would be running for each entity in new area
	-- @param game - game script root
	-- @param surface - working surface
	-- @param entity - builded entity reference
	-- @param namelist - "false" in none; array of entity names in this blueprint
	,ScriptForEach = function(game, surface, entity, namelist) end
	
	--- Script would be running once after new area created
	-- @param game - game script root
	-- @param surface - working surface
	-- @param area - area where blueprint was builded
	-- @param center - center of the area where blueprint was builded
	-- @param namelist - "false" in none; array of entity names in this blueprint
	-- @param entitylist - "false" in none; array of entities themselfs builded (if so) on surface ( surface.find_entities_filtered{area=area, name=newarea.names}; )
	,ScriptForAll = function(game, surface, area, center, namelist, entitylist) end
	
	-- An array of messages to be printed in the chat after the creation of the area.
	-- One will be selected randomly. Message ignored if empty.
	,messages = {
		{ msg = "", color = {r=0.30, g=0.70, b=1, a=0.8} }, -- { "Message", {Color RGBA} }
		{ msg = "", color = {r=0.30, g=0.70, b=1, a=0.8} } 	-- { "Message", {Color RGBA} }
	}
	
}

return areas
