require 'defines'

local areas = {}

areas['test'] = {

	-- Area blueprint string.
	-- Areas larger than 32x32 will be ignored (temporarily)
	bp = "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"

	
	-- blueprint options
	,propability = 25.0						-- [default: 25.0] from 1.0 to 100.0
	,force = "neutral"						-- [default: "neutral"] "player", "neutral", "enemy" or custom name to use/create new Force to use for the building
	,force_build = true						-- [default: true] When true, anything that can be built is else nothing is built if any one thing can't be built
	,finalize_build = true					-- [default: true] Build entities; place ghosts if "false"
	,direction = defines.direction.north	-- [default: defines.direction.north] The direction to use when building
	,ignore_water = false					-- [default: false] If "true" ignore water and place entities above them (entities may be unreachable)
	,ignore_all_collision = false			-- [default: false] If "truth" ignores all possible collisions and places entities on top of them (performance lags while placing area)


	
	-- additional options will be applied
	-- for each entity if allowed to do so
	-- comment/delete line to exclude
	,active = true							-- [default: true] Deactivating an entity will stop all its operations (inserters will stop working)
	,armed = true							-- [default: true] If this land mine is armed
	,consumption_modifier = 1.0				-- [default: 1.0] Multiplies the energy consumption
	,damage = 0								-- [default: 0] Damages the entity (if it have health). Will be used "neutral" Force as source and fire as damage type
	,destructible = true					-- [default: true] When the entity is not destructible it can't be damaged
	,remains = false						-- [default: false] Replace entities with their remains if they have it
	,energy_stored = 0.0					-- [default: 0.0] Energy stored in the entity (heat in furnace, energy stored in electrical devices etc
	,health = 100							-- [default: 100] Set health in procentage of the entity. Entities with 0 health can not be attacked. Setting health to higher than max health will set health to max health
	,operable = true						-- [default: true] Player can't open gui of this entity and he can't quick insert/input stuff in to the entity when it is not operable
	,order_deconstruction = false			-- [default: false] Sets the entity to be deconstructed by construction robots
	,rotatable = true						-- [default: true] When entity is not to be rotatable (inserter, transport belt etc), it can't be rotated by player using the R key

	
	-- events after creating area
	,message = ""							-- [default: ""] print message to the chat; ignored if ""
	,script = function(self)				-- Script would be running once after area created
		local data = self
	end
}

return areas
