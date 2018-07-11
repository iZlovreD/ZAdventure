
local areas = {}

areas['example'] = {

	-- Area blueprint string. "" to ignore whole area
	-- Areas larger than 64x64 will be ignored (temporarily)
	bp = ""
	
	
	-- blueprint options
	,probability = 100						-- [default: 100] from 1 to 1000 (*0.1%)
	,remoteness_min = 10					-- [default: 10] minimal distance in chunks (32x32) from starting point
	,remoteness_max = 0						-- [default: 0] maximal distance in chunks (32x32) from starting point, 0 for unlimited
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
	-- @param rndroll - random number 1-1000
	-- @param game - game script root
	-- @param surface - working surface
	-- @param force - what build the area
	-- @param entity - builded entity reference
	-- @param namelist - "false" in none; array of entity names in this blueprint
	-- @param locstore - temporal storage fo data, exist for all iteration while area generated
	,ScriptForEach = function(rndroll, game, surface, force, entity, namelist, locstore) end
	
	--- Script would be running once after new area created
	-- @param rndroll - random number 1-1000
	-- @param game - game script root
	-- @param surface - working surface
	-- @param force - what build the area
	-- @param area - area where blueprint was builded
	-- @param center - center of the area where blueprint was builded
	-- @param namelist - "false" in none; array of entity names in this blueprint
	-- @param entitylist - "false" in none; array of entities already builded (if remains = false)
	,ScriptForAll = function(rndroll, game, surface, force, area, center, namelist, entitylist) end
	
	-- An array of messages to be printed in the chat after the creation of the area.
	-- One will be selected randomly. Message ignored if empty.
	,messages = {
		{ msg = "", color = {r=0.30, g=0.70, b=1, a=0.8} } -- { "Message", {Color RGBA} }
	}
	
}

areas['armored rail junction'] = {

	bp = "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"
	
	,probability = 25
	,remoteness_min = 20
	,remoteness_max = 50
	,destructible = false
	,rotatable = false
}

areas['lone yellow belt'] = {
	
	bp = "0eNqVlN1ugzAMhd/F10Qi0JaOV5mmKYBXLOUHJem2quLdl0JHqzV0cBkSPtvHxz5DJY/YWdIeyjNQbbSD8vUMjg5ayMs3f+oQSiCPChLQQl1OzkhhWSc0SugTIN3gN5S8f0sAtSdPOGKGw+ldH1WFNjyIAhLojAv/GH2JFzhpAicoWd73yQMiW4bInyDyCUHWaFa36PwjgT1DbCbEh3CekXZofbiYpWRBpYYs1uPdJsLcTkzhHKpKkj4wJeqWNLJsFp0GcuDS0CVvhXadsZ5VKD1EouymKAobOiqGMiRlqWadkRiJwscCeEyG4qbkvAJ8SvNOgCxC2080aULprQiuap5om/5m9i/55WYajyjnWp5eM40QeLqg1GiluxiNr+x1pNWDdw8YRuCrxWEMH8MsHJark6JO5/mamY0jNsttsqCZfLumm1Hf8t2aLRIvqlhsCP7XEGFLDuu0vNu+CXyideODfZFle/6SFlnf/wCjbd0a"
	
	,probability = 150
	,remoteness_max = 20
	,ignore_technologies = true
	,random_direction = true
	
	,minable = false
	,operable = false
	,rotatable = false
	
	,ScriptForEach = function(rndroll, game, surface, force, entity, namelist, locstore)
		if entity.prototype.name == "steel-chest" then
			entity.get_inventory(defines.inventory.chest).insert( {name="iron-plate", count=5000} )
		elseif entity.prototype.name == "iron-chest" then
			entity.operable = true
		end
	end
	
}

areas['yellow belts'] = {
	
	bp = "0eNqdmu1u6zYMhu/Fv2PAkqyv3MpQHLiJ0BpznMB2z1YUvfe5TbsGG628r34VSepHJEWKlMm36nF4SZepH5dq/1b1h/M4V/s/3qq5fxq74eO75fWSqn3VL+lU7aqxO318ms9DN9WXbkxD9b6r+vGY/q726n1398luntPpcejHp/rUHZ77MdXqBqHfH3ZVGpd+6dNVks8Pr7/Gl9NjmtY1RBl21eU8r8+cx4+FV06t9K56Xf+G9w+h/gPRICRmGAZkuAyjBRkmw7AYo8kgHIbISeExRM4YAUPk9iRiiKxvqOZfyDJ143w5T0v9mIZFcrL2CnKrAx/7KR2uP7YSVhFYI2KdhNUEVuNYQ2AVjm0JbINjLY6NONXh1IBTPU71uHcFnOpwWSNOtTBVEwHW4lQivvDw0po7UayYbQx/orT391y3PNYC2J9g6sc5Tcv65fZZggBdPvlvw80KX9H9RdBRWshDkje45Dcp6dQNQ52G9d+n/lBfzkPKHIWyG0TWDrHIDKahT0NRXqPo88/ejyij6fMPoRpk6x2886Zl98qV7ZUlPczmNowONFMmNBRnBjd2IOVuBLH76TzWT2k9ov96Tp+3kv+vEzlj54K5bUiZTZnMrSLXcYXr/ITlKR37l9M944SccQwpdCwUuiAD6vv+2FoeawCs42oJLZr25qK1dIc/61ym+5JNiaCfoPu09OE5zRkFG5ERmVJB3TeR/Ymq4by6zHM3HtMxq6P5Eu8+++bNwbI61LbGeltjy4bJd0kg0wytbgOr2yJ7E/GtsaD5YkZfR2RpRCbP2s/D5gugui6jbixK7iLL0ZHRoqo6RaRzYFecBk1nMuoi9VyDi9TSgZaRDYyEJoNwJZWIjGJjIHO6uQBYnXCEiBkq4we+ASTCDwyvSGNlItKDbp45ILzh3MBnUKyHhwwLeQOAZw7vMENlEofnqx5EsEDXeWJN5pkySCzGQlP4ioStmIMqewdBr6Px6kO2CHGhlwGFN3haU1t26abXcXiWlg3i4ZQqP192SyffLYRYdK8mV4kNnOhEW0QFpyX5eV10q2e1LLuGs6u0cLaQbWGpa7F4AkdHn+RG5Hia04qcQOkkvkSJkZbFyf1MvqFpZRDfwkSaTA3fwoSwfAsTwvItTAhry1oNGzvl2BYAJKNnGwIQNbANAYga2YYoQmVmAyxOVWxDFKLqorcPskMx8wB45DPjAHjgM9MAeNwT0wB41Cu8JtvYF+TGrnOAop6IzCIa+7jdib4+7iIaTznfCRGA4jFiJKg410E0+fG405ZUH4LiAWJxm3oSKpdAOsD1+oZr4+kEzyY3jXqm5yZLSHTr8SxKNOvxhA/16mNOVTwm8OLGWG6wVJ4dNI6aLN2AeGq0dAMSqNnSDUhkhktlxk2nHJgu3WAoZrx0g6GZ+dINhqHudSvkYXedf97fDFrvqt9pmq+uGLzWQcXGr/fafwC4fA53"
	
	,probability = 100
	,remoteness_max = 25
	,random_direction = true
	
	,minable = false
	,operable = false
	,rotatable = false
	
	,ScriptForEach = function(rndroll, game, surface, force, entity, namelist, locstore)
		if entity.prototype.name == "steel-chest" then
			entity.get_inventory(defines.inventory.chest).insert( {name="iron-plate", count=5000} )
		elseif entity.prototype.name == "iron-chest" then
			entity.operable = true
		end
	end
	
}

areas['red belts'] = {
	
	bp = "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"
	
	,probability = 75
	,remoteness_min = 15
	,remoteness_max = 35
	,random_direction = true
	
	,minable = false
	,operable = false
	,rotatable = false
	
	,ScriptForEach = function(rndroll, game, surface, force, entity, namelist, locstore)
	
		if entity.prototype.name == "assembling-machine-2" then
			entity.get_inventory(defines.inventory.assembling_machine_modules).insert( {name="effectivity-module-3", count=2} )
			if not entity.get_recipe() then entity.set_recipe("fast-transport-belt") end
			
		elseif entity.prototype.name == "steel-chest" then
			entity.get_inventory(defines.inventory.chest).insert( {name="iron-plate", count=5000} )
			
		elseif entity.prototype.name == "iron-chest" then
			entity.operable = true
			
		end
	end
	
}

areas['blue belts'] = {
	
	bp = "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"
	
	,probability = 35
	,remoteness_min = 20
	,remoteness_max = 50
	,random_direction = false
	
	,minable = false
	,operable = false
	,rotatable = false
	
	,ScriptForEach = function(rndroll, game, surface, force, entity, namelist, locstore)
		if entity.prototype.name == "stone-wall"
		or entity.prototype.name == "pipe"
		or entity.prototype.name == "pipe-to-ground"
		then
			entity.destructible = false
		
		elseif entity.prototype.name == "oil-refinery" then
			entity.get_inventory(defines.inventory.furnace_modules).insert( {name="effectivity-module-3", count=3} )
			entity.set_recipe("basic-oil-processing")
			entity.destructible = false
			
		elseif entity.prototype.name == "chemical-plant" then
			entity.get_inventory(defines.inventory.furnace_modules).insert( {name="effectivity-module-3", count=3} )
			entity.set_recipe("lubricant")
			entity.destructible = false
		
		elseif entity.prototype.name == "assembling-machine-2" then
			entity.get_inventory(defines.inventory.assembling_machine_modules).insert( {name="effectivity-module-3", count=2} )
			entity.set_recipe("fast-transport-belt")
			
		elseif entity.prototype.name == "assembling-machine-3" then
			entity.get_inventory(defines.inventory.assembling_machine_modules).insert( {name="effectivity-module-3", count=4} )
			entity.set_recipe("express-transport-belt")
			
		elseif entity.prototype.name == "iron-chest" then
			entity.operable = true
		end
	end
	
	,ScriptForAll = function(rndroll, game, surface, force, area, center, namelist, entitylist)
		for _,entity in pairs(entitylist) do
			if entity.prototype.name == "iron-chest" then
				entity.operable = true
			elseif  entity.prototype.name == "storage-tank"
				and entity.position.x > center.x+5
				and entity.position.y > center.y+5
				then
				entity.fluidbox[1] = { name = "crude-oil", amount = 25000 }
			end
		end
	end
	
}

areas['garage'] = {
	
	bp = "0eNqV2Ntu4jAUBdB/8XMixZc4l1+p0IiC1VpKHJSYmUGIf6+hD1Tqxj7nCXFbOTjbO8BVvE9nd1p9iGK8Cn9YwibGt6vY/EfYT/fH4uXkxCh8dLOoRNjP93tbXIKr/+2nSdwq4cPR/RejvO0q4UL00btv5XHn8iec53e3pheg91fitGzpLUu4Hy0xdVeJS7rRt1v1i1A0wmYITSPaDGFohMkQLY3QGcLSCJUhOhohM0RPIpqMMJCE3AyyIRG5lZC0cObOh6SFM5cKSQtnLpuSFs7cDpG0cOb2qbSsva6g0bEMCY2eVRh4joFlwDlUw2odOIeSrNrBhmKVBjY0q7uwYTi1gYmWVV7YsJziwETHqS9M9JziwMTAqS9I6IZTHDDlWnIIPIXiNCAmNKe+MGE4BF6LltNeDSRYJYqn6DjdhadgVSie4pnO2R39ea7d5A5x9Yf6tEzuZXdAzPzI6ZxGKVkyQ0keZTKUYkQfC5ohwDNlOKnFAufKjz/FM7Mf++he5kSn3w1Hv6blfjylEMW6/sN9bHoOgb/rs67+cIq2Ka1JS12TVpYoQ6ZUiVJkSpcoTaZMgWrIUlsaSpKpUqjpK9UVJPpMfUGiB2EoSOSTZ59B9+sS6sOn2+KrCoNbxZbyTW4PW4o3ec9ZzvcJ/Kk4xZxaaFd9/98y/vh7phJ/3bo9Xmz7TqleDk2XjvYFgTvM9g=="
	
	,probability = 25
	,remoteness_min = 15
	,remoteness_max = 40
	,force = "player"
	,random_direction = false
	
	,minable = false
	,destructible = true
	
	,ScriptForEach = function(rndroll, game, surface, force, entity, namelist, locstore)
		
		local function _rnd(seed)
			global.adseed = math.max(469827,global.adseed) + seed
			global.generator.re_seed(global.adseed)
			return global.generator(1,1000)
		end
		
		locstore.cars = locstore.cars or 1 + (_rnd(rndroll) > 600 and 1 or 0)
		
		if entity.prototype.name == "stone-wall"
		or entity.prototype.name == "gate" then
			entity.force = 'enemy'
			entity.health = entity.prototype.max_health * (_rnd(rndroll)/400)
			if _rnd(rndroll) < 100 then entity.die('neutral') end
			
		elseif entity.prototype.name == "medium-electric-pole" then
			
				local pos = entity.position
				
				if _rnd(rndroll) > 700 then
				
					local ent = surface.create_entity{name="tank", position=pos, force=force}
					
					if ent.valid then
					
						local variations = {
							[000] =	{ "firearm-magazine" },
							[100] =	{ "cannon-shell",					"firearm-magazine"},
							[200] =	{ "cannon-shell",					"firearm-magazine",			"flamethrower-ammo" },
							[400] =	{ "cannon-shell",					"piercing-rounds-magazine",	"flamethrower-ammo" },
							[550] =	{ "explosive-cannon-shell",			"piercing-rounds-magazine",	"flamethrower-ammo" },
							[750] =	{ "uranium-cannon-shell",			"piercing-rounds-magazine",	"flamethrower-ammo" },
							[850] =	{ "cannon-shell",					"uranium-rounds-magazine",	"flamethrower-ammo" },
							[925] =	{ "explosive-cannon-shell",			"uranium-rounds-magazine",	"flamethrower-ammo" },
							[950] =	{ "explosive-uranium-cannon-shell",	"uranium-rounds-magazine",	"flamethrower-ammo" }
						}
						
						local selct = variations[000]
						for chance,variant in pairs(variations) do
							if _rnd(rndroll) >= chance then selct = variant end
						end
						
						for _,ammo in pairs(selct) do
							ent.get_inventory(defines.inventory.car_ammo).insert( ammo )
							ent.get_inventory(defines.inventory.car_trunk).insert( ammo )
							ent.get_inventory(defines.inventory.car_trunk).insert( ammo )
						end
					end
					
				end
				
				if entity.valid then entity.destroy() end
				
		elseif entity.prototype.name == "small-electric-pole" then
		
			local pos = entity.position
			
			if _rnd(rndroll) > 400 and locstore.cars > 0 then
			
				local ent = surface.create_entity{name="car", position=pos, force=force}
					
				if ent.valid then
					
					local variations = {
						[000] =	"",
						[200] =	"firearm-magazine",
						[450] =	"piercing-rounds-magazine",
						[825] =	"uranium-rounds-magazine"
					}
					
					local selct = variations[000]
					for chance,variant in pairs(variations) do
						if _rnd(rndroll) >= chance then selct = variant end
					end
					
					if selct:len() > 0 then
						ent.get_inventory(defines.inventory.car_ammo).insert( selct )
						ent.get_inventory(defines.inventory.car_trunk).insert( selct )
						ent.get_inventory(defines.inventory.car_trunk).insert( selct )
					end
					
					locstore.cars = locstore.cars - 1
					
				end
				
			end
			
			if entity.valid then entity.destroy() end
			
		elseif entity.prototype.name == "iron-chest" then
			if _rnd(rndroll) > 100 then
				entity.get_inventory(defines.inventory.chest).insert( {name="solid-fuel", count=100} )
				if _rnd(rndroll) > 700 then
					entity.get_inventory(defines.inventory.chest).insert( {name="nuclear-fuel", count=4} )
				else
					entity.get_inventory(defines.inventory.chest).insert( {name="rocket-fuel", count=20} )
				end
			end
			
		end
	end
	
}

areas['danger chest'] = {
	
	bp = "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"
	
	,probability = 50
	,remoteness_min = 20
	,force = "enemy"
	,random_direction = true
	
	,destructible = false
	
	,ScriptForEach = function(rndroll, game, surface, force, entity, namelist, locstore)
		
		local function _rnd(seed)
			global.adseed = math.max(469827,global.adseed) + seed
			global.generator.re_seed(global.adseed)
			return global.generator(1,1000)
		end
	
		if entity.prototype.name == "wooden-chest" then
			entity.force = 'neutral'
			
			local variations = {
				{ "coal",						-1, 16 },
				{ "raw-wood",					10, 16 },
				{ "coal",						10, 16 },
				{ "stone",						10, 16 },
				{ "iron-ore",					10, 16 },
				{ "empty-barrel",				-1, 16 },
				{ "copper-cable",				10, 16 },
				{ "copper-ore",					10, 16 },
				{ "crude-oil-barrel",			10, 16 },
				{ "light-armor",				-1, 16 },
				{ "raw-fish",					-1, 16 },
				{ "iron-plate",					10, 16 },
				{ "copper-plate",				10, 16 },
				{ "steel-plate",				 4, 10 },
				{ "heavy-oil-barrel",			 4, 10 },
				{ "heavy-armor",				-1, 16 },
				{ "light-oil-barrel",			 4, 10 },
				{ "firearm-magazine",			 6, 12 },
				{ "piercing-rounds-magazine",	 4, 10 },
				{ "uranium-rounds-magazine",	 2,  6 },
				{ "modular-armor",				-1, 16 },
				{ "power-armor",				-1, 16 },
				{ "iron-gear-wheel",			10, 16 }
			}
			
			local armorpack = {
				["modular-armor"] = {
					{-1, 1,	"night-vision-equipment" },
					{-4, 1,	"solar-panel-equipment" }
				},
				["power-armor"] = {
					{-1, 1,	"exoskeleton-equipment" },
					{-1, 1,	"night-vision-equipment" },
					{-1, 1,	"personal-roboport-equipment" },
					{-8, 1,	"solar-panel-equipment" },
					{1, 1,	"battery-equipment" },
					{1, 1,	"construction-robot" }
				},
			}
			
			variations = variations[math.max(1,_rnd(rndroll) % #variations)]
			
			if variations[2] < 0 then
				entity.get_inventory(defines.inventory.chest).insert({ name=variations[1], count=1 })
				
			elseif variations[2] ~= 0 or (variations[2] == 0 and _rnd(rndroll) % 10 ~= 0) then 
				for i=1, math.min(16, math.max(variations[2], _rnd(rndroll) % variations[3])), 1 do
					entity.get_inventory(defines.inventory.chest).insert(variations[1])
				end
			end
			
			if armorpack[variations[1]] then for _,ins in pairs(armorpack[variations[1]]) do
				
				if ins[1] < 0 then
					entity.get_inventory(defines.inventory.chest).insert({ name=ins[3], count=0-ins[1] })
				
				elseif ins[1] ~= 0 or (ins[1] == 0 and _rnd(rndroll) % 10 ~= 0) then 
					for i=1, math.min(16, math.max(ins[1], _rnd(rndroll) % ins[2])), 1 do
						entity.get_inventory(defines.inventory.chest).insert(ins[3])
					end
				end
				
			end end
			
		elseif entity.prototype.name == "land-mine" and _rnd(rndroll)  > 400 then
			entity.destroy()
		end
	end
	
	,ScriptForAll = function(rndroll, game, surface, force, area, center, namelist, entitylist)
		
		if rndroll < 150 then
			for _,ent in pairs(entitylist) do
				if ent and ent.valid and ent.prototype.name == "land-mine" then ent.destroy() end
			end
		end
	end
	
}

areas['maze'] = {
	
	bp = "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"
	
	,probability = 75
	,remoteness_min = 30
	,random_direction = true
	,minable = false
	
	,ScriptForEach = function(rndroll, game, surface, force, entity, namelist, locstore)
		
		local function _rnd(seed)
			global.adseed = math.max(469827,global.adseed) + seed
			global.generator.re_seed(global.adseed)
			return global.generator(1,1000)
		end
	
		if entity.prototype.name == "iron-chest" then
			
			local variations = {
				{ "science-pack-1",				 2,  6 },
				{ "uranium-ore",				 2,  6 },
				{ "solid-fuel",					 2,  6 },
				{ "plastic-bar",				 4,  8 },
				{ "engine-unit",				 4,  6 },
				{ "science-pack-2",				 2,  4 },
				{ "military-science-pack",		 2,  3 },
				{ "sulfur",						 2, 12 },
				{ "battery",					 2,  3 },
				{ "science-pack-3",				 2,  3 },
				{ "lubricant-barrel",			 6, 12 },
				{ "electric-engine-unit",		 2,  4 },
				{ "electronic-circuit",			 2,  9 },
				{ "advanced-circuit",			 2,  6 },
				{ "production-science-pack",	 2,  2 },
				{ "processing-unit",			 2,  3 },
				{ "high-tech-science-pack",		 1,  2 },
				{ "power-armor-mk2",			-1, 16 },
				{ "space-science-pack",			 1,  2 }
			}
			local armorpack = {
				{-2, 1,	"exoskeleton-equipment" },
				{-1, 1,	"night-vision-equipment" },
				{-1, 1,	"personal-roboport-mk2-equipment" },
				{-4, 1,	"fusion-reactor-equipment" },
				{1, 1,	"energy-shield-mk2-equipment" },
				{1, 1,	"battery-mk2-equipment" },
				{1, 2,	"construction-robot" }
			}
			
			variations = variations[math.max(1,_rnd(rndroll) % #variations)]
			
			if variations[2] < 0 then
				entity.get_inventory(defines.inventory.chest).insert({ name=variations[1], count=1 })
				
			elseif variations[2] ~= 0 or (variations[2] == 0 and _rnd(rndroll) % 10 ~= 0) then 
				for i=1, math.min(16, math.max(variations[2], _rnd(rndroll) % variations[3])), 1 do
					entity.get_inventory(defines.inventory.chest).insert(variations[1])
				end
			end
			if variations[1] == 'power-armor-mk2' then for _,ins in pairs(armorpack) do
				
				if ins[1] < 0 then
					entity.get_inventory(defines.inventory.chest).insert({ name=ins[3], count=0-ins[1] })
				
				elseif ins[1] ~= 0 or (ins[1] == 0 and _rnd(rndroll) % 10 ~= 0) then 
					for i=1, math.min(16, math.max(ins[1], _rnd(rndroll) % ins[2])), 1 do
						entity.get_inventory(defines.inventory.chest).insert(ins[3])
					end
				end
				
			end end
			
		end
		
	end
	
	,ScriptForAll = function(rndroll, game, surface, force, area, center, namelist, entitylist)
	
		for _,entity in pairs(entitylist) do if entity.prototype.name == "iron-chest" then 
			
			if entity and entity.valid and entity.health then
				center = entity.position
			end
			
			global.ZADV.tickevents = global.ZADV.tickevents or {}
			global.ZADV.areadata = global.ZADV.areadata or {}
			global.ZADV.areadata['maze'] = global.ZADV.areadata['maze'] or {}
			global.ZADV.areadata['maze'][center.x] = global.ZADV.areadata['maze'][center.x] or {}
			global.ZADV.areadata['maze'][center.x][center.y] = global.ZADV.areadata['maze'][center.x][center.y] or {}
			local areadata = global.ZADV.areadata['maze'][center.x][center.y] or {}
			
			areadata.entity = entity
			areadata.stored_items = entity.get_inventory(defines.inventory.chest).get_item_count()
			areadata.entitylist = entitylist
			areadata.players = areadata.players or {}
			areadata.area = Area.expand(Area.construct(center.x, center.y, center.x, center.y),15)
			areadata.debuffarea = Area.expand(areadata.area,10)
			
			areadata.save_bonuses = function(storage, player)
			
				storage.stored = true
				storage.left = false
				storage.character_mining_speed_modifier 			= player.character_mining_speed_modifier
				storage.character_running_speed_modifier 			= player.character_running_speed_modifier
				storage.character_build_distance_bonus 				= player.character_build_distance_bonus
				storage.character_reach_distance_bonus  			= player.character_reach_distance_bonus 
				storage.character_resource_reach_distance_bonus		= player.character_resource_reach_distance_bonus
				storage.character_item_pickup_distance_bonus		= player.character_item_pickup_distance_bonus 
				storage.character_loot_pickup_distance_bonus		= player.character_loot_pickup_distance_bonus
				storage.character_maximum_following_robot_count_bonus= player.character_maximum_following_robot_count_bonus
				storage.character_health_bonus		 				= player.character_health_bonus
				
				player.character_mining_speed_modifier				= -0.9
				player.character_build_distance_bonus				= -0.9
				player.character_reach_distance_bonus 				= -0.9
				player.character_resource_reach_distance_bonus		= -0.9
				player.character_item_pickup_distance_bonus			= -0.9
				player.character_loot_pickup_distance_bonus			= -0.9
				player.character_maximum_following_robot_count_bonus= 0
				player.character_health_bonus						= 0
				
			end
			
			areadata.restore_bonuses = function(storage, player)
			
				player.character_mining_speed_modifier 				= storage.character_mining_speed_modifier
				player.character_running_speed_modifier 			= storage.character_running_speed_modifier
				player.character_build_distance_bonus 				= storage.character_build_distance_bonus
				player.character_reach_distance_bonus  				= storage.character_reach_distance_bonus 
				player.character_resource_reach_distance_bonus		= storage.character_resource_reach_distance_bonus
				player.character_item_pickup_distance_bonus			= storage.character_item_pickup_distance_bonus 
				player.character_loot_pickup_distance_bonus			= storage.character_loot_pickup_distance_bonus
				player.character_maximum_following_robot_count_bonus= storage.character_maximum_following_robot_count_bonus
				player.character_health_bonus		 				= storage.character_health_bonus
				
			end
			
			areadata.func_on_tick = function() if game.tick % 10 <= 1 then
			
				for x,xdata in pairs(global.ZADV.areadata['maze']) do for y,areadata in pairs(xdata) do
					
					if  areadata.event
					and areadata.event.tick
					and areadata.event.tick <= game.tick then
						
						areadata.event = {}
						
						if areadata.entity and areadata.entity.valid and areadata.entity.health then
							
							areadata.entity.health = math.max(1, areadata.entity.health - areadata.entity.prototype.max_health / 100)
							if areadata.entity.health <= 1 then
								areadata.entity.die('neutral')
								areadata.event.looted = true
								
							else
								areadata.event.tick = game.tick+60
							end
						else
							areadata.event.looted = true
						end
					end
					
					if not areadata.looted and areadata.stored_items ~= areadata.entity.get_inventory(defines.inventory.chest).get_item_count() then areadata.looted = true end
					
					if areadata.looted then
						if areadata.players then
						
							for _,entity in pairs(areadata.entitylist) do
								if (entity.prototype.name == "stone-wall"
								or entity.prototype.name == "gate")
								and entity and entity.valid then
									entity.die('neutral')
							end end
							
							for name,data in pairs(areadata.players) do
							for _,player in pairs(game.players) do
							if name == player.name then
								areadata.restore_bonuses(data, player)
							end end end
							
							areadata = {}
							areadata.looted = true
							
							global.ZADV.areadata['maze'][center.x][center.y] = areadata
						end 
						break
						return true
					end
					
					for _,player in pairs(game.players) do
						
						if Area.inside(areadata.debuffarea, player.position) then
							
							if not areadata.players[player.name] then
							
								player.print("You found The Maze!")
								areadata.players[player.name] = { stored = false }
							end
							
							if not areadata.players[player.name].stored then areadata.save_bonuses(areadata.players[player.name], player) end
							
						end
						
						if Area.inside(Area.shrink(areadata.area, 7), player.position) then
							
							if not areadata.toclose then
							
								areadata.toclose = true
								player.print("Hey ".. player.name ..", you are so close to the treasure. Hurry up!")
								
							end
							
						elseif Area.inside(areadata.area, player.position) then
						
							local distance = Position.distance(center, player.position)
							player.character_running_speed_modifier = math.min(0, math.max(-0.85, (25 - distance)*-0.037))
							
							if not areadata.entered then
							
								areadata.entered = true
								player.print("You enter the Maze. Don't waste your time!")
								
							end
							
							if areadata.entity and areadata.entity.valid and areadata.entity.health then
								areadata.event = areadata.event or {}
								if not areadata.event.tick then
									areadata.event.tick = game.tick+60
								end
							else
								areadata.looted = true
							end
							
						end
						
					end
					
					for name,data in pairs(areadata.players) do for _,player in pairs(game.players) do
						if player.name == name and not Area.inside(areadata.debuffarea, player.position) then
							
							areadata.restore_bonuses(data, player)
							areadata.players[name].left = true
							areadata.players[name].stored = false
							if not areadata.players[name].left then player.print(player.name .." left the building...") end
							
					end end end
				
			end end end end
			
			areadata.func_on_player_died = function(event)
			
				if event.player_index and game.players[event.player_index] then
					for x,xdata in pairs(global.ZADV.areadata['maze']) do for y,areadata in pairs(xdata) do
						for name,data in pairs(areadata.players) do
							if name == game.players[event.player_index].name then
								
								local player = game.players[event.player_index]
								areadata.restore_bonuses(data, player)
								areadata.players[name].left = true
								areadata.players[name].stored = false
								if not data.left then player.print(player.name .." left the building...") end
								
				end end end end end
				
			end
			
			global.ZADV.areadata['maze'][center.x][center.y] = areadata
			script.on_event(defines.events.on_tick, global.ZADV.areadata['maze'][center.x][center.y].func_on_tick)
			script.on_event(defines.events.on_player_died, global.ZADV.areadata['maze'][center.x][center.y].func_on_player_died)
			script.on_event(defines.events.on_pre_player_left_game, global.ZADV.areadata['maze'][center.x][center.y].func_on_player_died)
			
		
		end end
	
	end
	
	,experemental = true
}

areas['new'] = {
	
	bp = ""
	
	,probability = 100
	,remoteness_min = 10
	,remoteness_max = 0
	,ignore_technologies = true
	,force = "neutral"
	,random_direction = false
	,force_build = true
	,finalize_build = true
	,force_reveal = false
	,ignore_water = false
	,ignore_all_collision = false
	
	,active = true
	,minable = true
	,destructible = true
	,remains = false
	,health = -1
	,operable = true
	,order_deconstruction = false
	,rotatable = true
	
	,ScriptForEach = function(rndroll, game, surface, force, entity, namelist, locstore) end
	,ScriptForAll = function(rndroll, game, surface, force, area, center, namelist, entitylist) end
	
	,messages = {
		{ msg = "", color = {r=0.30, g=0.70, b=1, a=0.8} }
	}
	
}


return areas
