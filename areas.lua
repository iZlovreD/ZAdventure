
require 'stdlib/area/position'

local ret = { ModName = "ZADV_Base", area={} }

ret.area['template'] = {

	bp=""
	
	,probability = 100
	,remoteness_min = 10
	,remoteness_max = 0
	,only_once = false
	,max_copies = 0	
	,progressive_distance = false
	,ignore_technologies = true
	,force = "neutral"
	,force_build = true
	,random_direction = false
	,finalize_build = true
	,force_reveal = false
	,only_freeplay = false
	,ignore_water = false
	,ignore_all_collision = false
	
	,dangerous = false
	,active = true
	,minable = true
	,destructible = true
	,remains = false
	,health = -1
	,operable = true
	,order_deconstruction = false
	,rotatable = true
	
	,areadata = {}
	
	,ScriptForEach = function(rndroll, game, surface, force, area, center, entity, namelist, locstore, areadata) end
	
	,ScriptForAll = function(rndroll, game, surface, force, area, center, namelist, entitylist, areadata, locstore) end
	
	,Events = {
	
		[defines.events.on_tick] = function(event, ad, game, _UniqueLock_)
			
			
			
		end
		
	}
	
	,messages = {
		{ msg = "", color = {r=0.30, g=0.70, b=1} }
	}
	
	,update_for = { mod="", area="" }
	
	,experemental = false
}

if settings.startup["zadv_area_rail"].value then
ret.area['armored rail junction'] = {

	bp="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"
	
	,probability = 25
	,remoteness_min = 20
	,remoteness_max = 50
	,max_copies = 2
	,nearest_copy = 40
	,destructible = false
	,rotatable = false
}
end

if settings.startup["zadv_area_yellow"].value then
ret.area['yellow belt'] = {
	
	bp="0eNqVlN1ugzAMhV9l8jWRCLSl41WmaQrgFUshQUnarqt496XQ0WoNHdyRHz7bx8c5QyH32BpSDvIzUKmVhfztDJZ2SsjLnju1CDmQwwYiUKK5rKyWwrBWKJTQRUCqwi/IefceASpHjnDA9IvTh9o3BRp/IQiIoNXW/6PVJZ7nxBGcIGdp10UPiGQeIn2CSEcEGa1YWaN1jwT2DLEaEZ/COkbKonH+YJKSeJUqMlgOZ6sAcz0yhbXYFJLUjjWirEkhSybRsSd7LvVd+hbVgTkjlG21caxA6ZiV+giBeJsxXoMV7RuG0qdnqGStlhiIx4dSeEiQ7KbptBZ8TPhOiiRA2440qb0ItfD+qp6oHP9m9i/59WYfhyinmh9fMw0QeDyj1GClmxCNL+z6VNN7K+/QT8Sxxn4qH2PNnJ2rsYLG5+mSEQ4jVvO9MqOjfL2kpUHz8s2SRyVcVDbbFfyvK/yj2b+u+d1jHIEUfnr93ov/PqCxw+VtliRb/hpnSdf9AOcY5d4="
	
	,probability = 100
	,remoteness_max = 20
	,max_copies = 3
	,nearest_copy = 20
	,ignore_technologies = true
	,random_direction = true
	
	,minable = false
	,operable = false
	,rotatable = false
	
	,ScriptForEach = function(rndroll, game, surface, force, area, center, entity, namelist, locstore, areadata)
	
		if entity.prototype.name == "steel-chest" then
			entity.get_inventory(defines.inventory.chest).insert( {name="iron-plate", count=5000} )
			
		elseif entity.prototype.name == "iron-chest" then
			entity.operable = true
			
		elseif entity.prototype.name == "assembling-machine-2" then
			entity.get_inventory(defines.inventory.assembling_machine_modules).insert( {name="effectivity-module-3", count=2} )
			
		end
		
	end
	
}
end

if settings.startup["zadv_area_red"].value then
ret.area['red belts'] = {
	
	bp="0eNqlleFugyAQgF9lud+SCNpqfZVlWdDeWhIEA7Rd1/juo5q5LVJHu3+C+t3xcQcXqOUBOyOUg+oCotHKQvV8ASt2isvrnDt3CBUIhy0koHh7Hb1x64gzXNlOG0dqlA76BITa4jtUtH9JAJUTTuCIGwbnV3VoazT+gwkkjFak2aN1Ht5p63/R6hrWY9IEzlCRdd8nMwKbCFZLbkjHFco5guQjIw8xsonR4lYcWoISG2dEQzotMQBjC7B8gnFrsa2lUDvS8mYvFJLs5uIyb81gIwbHH3x7JAG1xEp9gkDQ1bdHZdE4P3cr0MoH2gofanyVB2jrOKdLSos7lS4ZLZeM0tt7TWdKhyLboV/SaY9+SYFgmwiTX/vPfqtcB3A0vTP5/+ROaUTy4dxZCMfiXaQRKrIlFexWwc5NzI6beag8vh/o3/1AV9Fe0wit67uOLBZqCVo8dmSFYeU9/R5GbB7q9yCLpXHpjPvnTwx/xwyXUvXjDktAcl8dfu7JPx/R2LEuy4Kxkm7Swof+BCx0Tt0="
	
	,probability = 50
	,remoteness_min = 15
	,remoteness_max = 35
	,max_copies = 2
	,nearest_copy = 30
	,random_direction = true
	
	,minable = false
	,operable = false
	,rotatable = false
	
	
	,ScriptForEach = function(rndroll, game, surface, force, area, center, entity, namelist, locstore, areadata)
	
		if entity.prototype.name == "assembling-machine-1" then
			areadata.tosuply = areadata.tosuply or {}
			table.insert(areadata.tosuply, entity)
			
		elseif entity.prototype.name == "assembling-machine-2" then
			entity.get_inventory(defines.inventory.assembling_machine_modules).insert( {name="effectivity-module-3", count=2} )
			areadata.tosuply = areadata.tosuply or {}
			table.insert(areadata.tosuply, entity)
			
		elseif entity.prototype.name == "assembling-machine-3" then
			entity.get_inventory(defines.inventory.assembling_machine_modules).insert( {name="effectivity-module-3", count=3} )
		
		elseif entity.prototype.name == "iron-chest" then
			entity.operable = true
			
		end
	end
	
	,Events = {
		
		[defines.events.on_tick] = function(event, ad, game)
			
			if not ad.total then
				ad.total = 0
			elseif ad.total >= 7500 then
				ad.disabled = true
				
			else
				
				if ad.nextcheck then
					if ad.nextcheck <= event.tick then
					
						for _,e in pairs(ad.tosuply) do
							if e and e.valid then
								
								local inv = e.get_inventory(defines.inventory.furnace_source)
								if inv and inv.valid and inv.can_insert("iron-plate") then
									ad.total = ad.total + inv.insert("iron-plate")
								end
								
							end
						end
						
						ad.nextcheck = event.tick + 600
						
					end
				else ad.nextcheck = event.tick + 600 end
				
			end
			
		end
	}
	
}
end

if settings.startup["zadv_area_blue"].value then
ret.area['blue belts'] = {
	
	bp="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"
	
	,probability = 35
	,remoteness_min = 20
	,remoteness_max = 50
	,max_copies = 1
	,random_direction = false
	
	,minable = false
	,operable = false
	,rotatable = false
	
	,areadata = {
		['basic-oil-processing'] = 'basic-oil-processing'
	}
	
	,ScriptForEach = function(rndroll, game, surface, force, area, center, entity, namelist, locstore, areadata)
		
		if entity.prototype.name == "stone-wall"
		or entity.prototype.name == "pump"
		or entity.prototype.name == "pipe"
		or entity.prototype.name == "pipe-to-ground"
		then
			entity.destructible = false
		
		elseif entity.prototype.name == "oil-refinery" then
			entity.get_inventory(defines.inventory.furnace_modules).insert( {name="effectivity-module-3", count=3} )
			entity.set_recipe(areadata["basic-oil-processing"])
			entity.destructible = false
			
		elseif entity.prototype.name == "chemical-plant" then
			entity.get_inventory(defines.inventory.furnace_modules).insert( {name="effectivity-module-3", count=3} )
			entity.destructible = false
		
		elseif entity.prototype.name == "assembling-machine-1" then
		
		elseif entity.prototype.name == "assembling-machine-2" then
			entity.get_inventory(defines.inventory.assembling_machine_modules).insert( {name="effectivity-module-3", count=2} )
			
		elseif entity.prototype.name == "assembling-machine-3" then
			entity.get_inventory(defines.inventory.assembling_machine_modules).insert( {name="effectivity-module-3", count=4} )
			entity.rotatable = true
			entity.direction = 4
			
		elseif entity.prototype.name == "iron-chest" then
			entity.operable = true
			
		elseif entity.prototype.name == "storage-tank"
			and entity.position.x > center.x+5
			and entity.position.y > center.y+5 then
				entity.fluidbox[1] = { name = "crude-oil", amount = 25000 }
		end
		
	end
	
}
end

if settings.startup["zadv_area_garage"].value then
ret.area['garage'] = {
	
	bp="0eNqV2Ntu4jAUBdB/8XMixZc4l1+p0IiC1VpKHJSYmUGIf6+hD1Tqxj7nCXFbOTjbO8BVvE9nd1p9iGK8Cn9YwibGt6vY/EfYT/fH4uXkxCh8dLOoRNjP93tbXIKr/+2nSdwq4cPR/RejvO0q4UL00btv5XHn8iec53e3pheg91fitGzpLUu4Hy0xdVeJS7rRt1v1i1A0wmYITSPaDGFohMkQLY3QGcLSCJUhOhohM0RPIpqMMJCE3AyyIRG5lZC0cObOh6SFM5cKSQtnLpuSFs7cDpG0cOb2qbSsva6g0bEMCY2eVRh4joFlwDlUw2odOIeSrNrBhmKVBjY0q7uwYTi1gYmWVV7YsJziwETHqS9M9JziwMTAqS9I6IZTHDDlWnIIPIXiNCAmNKe+MGE4BF6LltNeDSRYJYqn6DjdhadgVSie4pnO2R39ea7d5A5x9Yf6tEzuZXdAzPzI6ZxGKVkyQ0keZTKUYkQfC5ohwDNlOKnFAufKjz/FM7Mf++he5kSn3w1Hv6blfjylEMW6/sN9bHoOgb/rs67+cIq2Ka1JS12TVpYoQ6ZUiVJkSpcoTaZMgWrIUlsaSpKpUqjpK9UVJPpMfUGiB2EoSOSTZ59B9+sS6sOn2+KrCoNbxZbyTW4PW4o3ec9ZzvcJ/Kk4xZxaaFd9/98y/vh7phJ/3bo9Xmz7TqleDk2XjvYFgTvM9g=="
	
	,probability = 25
	,remoteness_min = 15
	,max_copies = 3
	,nearest_copy = 40
	,force = "player"
	,unique = true
	,random_direction = false
	
	,minable = false
	,destructible = true
	
	,ScriptForEach = function(rndroll, game, surface, force, area, center, entity, namelist, locstore, areadata)
		
		local function Rnd(max)
			return ZADVRnd(1,max or 1000,rndroll)
		end
		
		locstore.cars = locstore.cars or 1 + (Rnd() > 600 and 1 or 0)
		
		if entity.prototype.name == "stone-wall"
		or entity.prototype.name == "gate" then
			entity.force = 'enemy'
			entity.health = entity.prototype.max_health * (Rnd()/400)
			if Rnd() < 100 then
				entity.die('neutral')
			else
				entity.force = 'neutral'
			end
			
		elseif entity.prototype.name == "medium-electric-pole" then
			
				local pos = entity.position
				
				if Rnd() > 700 then
				
					local ent = surface.create_entity{name="tank", position=pos, force=force}
					
					if ent.valid then
						
						ent.health = ent.prototype.max_health * (Rnd()/900)
						
						local variations = {
							['000'] = { "firearm-magazine" },
							['100'] = { "cannon-shell", "firearm-magazine"},
							['200'] = { "cannon-shell", "firearm-magazine", "flamethrower-ammo" },
							['400'] = { "cannon-shell", "piercing-rounds-magazine", "flamethrower-ammo" },
							['550'] = { "explosive-cannon-shell", "piercing-rounds-magazine"},
							['750'] = { "uranium-cannon-shell", "piercing-rounds-magazine", "flamethrower-ammo" },
							['850'] = { "cannon-shell", "uranium-rounds-magazine", "flamethrower-ammo" },
							['925'] = { "explosive-cannon-shell", "uranium-rounds-magazine" },
							['950'] = { "explosive-uranium-cannon-shell","uranium-rounds-magazine", "flamethrower-ammo" }
						}
						
						local selct = variations['000']
						local lorr = Rnd()
						for chance,variant in pairs(variations) do
							if lorr >= tonumber(chance) then selct = variant end
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
			
			if Rnd() > 400 and locstore.cars > 0 then
			
				local ent = surface.create_entity{name="car", position=pos, force=force}
					
				if ent.valid then
						
					ent.health = ent.prototype.max_health * (Rnd()/600)
					
					local variations = {
						['000'] = "",
						['200'] = "firearm-magazine",
						['450'] = "piercing-rounds-magazine",
						['825'] = "uranium-rounds-magazine"
					}
					
					local selct = variations['000']
					local lorr = Rnd()
					for chance,variant in pairs(variations) do
						if lorr >= tonumber(chance) then selct = variant end
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
			if Rnd() > 850 then
				entity.get_inventory(defines.inventory.chest).insert( {name="nuclear-fuel", count=4} )
			elseif Rnd() > 600 then
				entity.get_inventory(defines.inventory.chest).insert( {name="rocket-fuel", count=20} )
			elseif Rnd() > 400 then
				entity.get_inventory(defines.inventory.chest).insert( {name="solid-fuel", count=100} )
			elseif Rnd() > 200 then
				entity.get_inventory(defines.inventory.chest).insert( {name="coal", count=200} )
			elseif Rnd() > 100 then
				entity.get_inventory(defines.inventory.chest).insert( {name="raw-wood", count=200} )
			end
			
		end
	end
	
}
end

if settings.startup["zadv_area_chest"].value and settings.startup["zadv_dangerous"].value then
ret.area['danger chest'] = {
	
	bp="0eNqlW+1y4jgQfJUr/wbVaPTNq2xtXZHg3biKmBR4by+X4t3PgMEmkc2091+g3C2Np1szkshH8bT9Vb7tq7opVh9F9byrD8Xq20dxqH7W6+3pu+b9rSxWRdWUr8WiqNevp0/bdb1ZvlZ1WRwXRVVvyn+LlT5+XxRl3VRNVV5Izh/e/65/vT6V+/aBDHxRvO0OLWJXn8ZqWZZRJR2Sj8Etivf2szbKGJdMcMfj4gsnizit0t6S557S2sQ65jmNhJNU4vtZTlFaCaVVnk5xSuJ2orhbjvvAWbkUvGu/yJF6Gaky6Y6Syeg8YZAQBhWiFs4wSgjbqNknZ4akMXIcmWQSyvKWGK1Ij01Qk1CQwZAdyIcUM4+GrUXW0Yq1jdYMSEM8pyrLyTJNkh3qPCnXfc5yGlnCU2cVWfAi87RZYdPHniZlpIX2YdX7MSoKo0LXMuskdfcyo3Jx3Dy6d8+h2dXl8vd6u83Nsos4yyEyzJJU7JRy4QrXZSPLmebE6hW7MGZBlrnGqegN94uFUz7p0XmyyDTt0kAUhpwjhUZkF6+ccefF4cpmnLNjdmGRXZIyFF0vRD9pQbZSaWtrB2ukUaFbM7OsTqhFOrNRlqP3yO/dblPWy+eX8tCMKjpPIjNFnGCQWaJdlGLqF9OTfLNsMjOwGsrCKUuXxSrbfpBssY+mF4VTo4IwWiay0C1vkhmysAxrGgbN48XIGGk/M0xKu0yNrfDGCvNCWodbKfLXpi5L6WQFcxh0VH4qai8rlzYNGsO2Do3RBWGhtHd0OowvzEZoFnv/HlvzXIbIcsosE+5SnW4La7a9lnZdHIIZcNJE+bUaKb/Z6mtZ2FCTG5SgU0edn5HIJO1GpO+tTu301HsTFgutvPGD9Jrr4pMldcJifi+ZtgBNNIFWZJW2oeq91zLSRKG0Mrfw3es0txb7eNrtNtW22+qOFsJPInpbNy/FaTZf2qWuFwYB6ABy/ksJXTIKQEcg8HmUXx5A6DohFACPoEEAgc+j/GgA8jfkLwFbFACPwChAgwACn0f50QDQNyRPwXXrggLgEQwKYBSgQQCBz6P8aADoG0JTIM+x7faeKAAewaIAgwIGSXhZ/7feb5bPu/p5Xzblcl/9fGmmsHo+lsB5Tgy1LX9MjcSzkei7RJOFqkEuN9MdXKEAeASHAiwKMHM0Zr5oe1/+aDvazRLm0OCECXwe5RfENCpr81nWIBJNHqoOVH5yfXN3xIwC4BE8CnAowKKAWQ5itMfgL3bBLcefHXTFTDyt/8APDLYhPNs/DPqHQf8w6B+e5R+5fW63MCAAHiGgAI8CHAqwKMCgAEYBWmgp/dmAV0sJUNgYaAjoO0KTgGYZlRGqU9QIYqcRaDQCfUagzQh0GYEmo4dFcGzRJtBsJK6A0yMK6x9Jy99ovSXMifSo+j0YCEwZqAhQcKCexXZByxJaldCihNYkPdsuWrznesCgsbkS9jjI/idbSD3bMGANA0sYWMHAAoZuhNB9ELoNYrDJ4ofnYmP65YenYtNIwqY45/SNHx2JPUCCbxFMEqgBscTQwyr0rMqAEjNgZ4EeRYEnUeBBlMHaBoMJBzxpAg+a0GN19FTdgpm1YGbBw3OLZdZimQVPycFDcvRaDL0VQy/FwDsx8EoMvBEDL8TQa2H0Vhi8FAbvhMErYfRnBeCvCsAfFUz+rOP74vKfJKvBP54siu36qdy23/3V/v1PuT+cyXwMzFEnCnw8/g9/VPpL"
	
	,probability = 50
	,remoteness_min = 10
	,nearest_copy = 10
	,force = "enemy"
	,random_direction = true
	,progressive_remoteness = 5
	
	,dangerous = true
	
	,areadata = {
		
		variations = {
			{ "coal",						-1, 01 },
			{ "raw-wood",					10, 10 },
			{ "coal",						10, 10 },
			{ "stone",						10, 10 },
			{ "iron-ore",					10, 10 },
			{ "empty-barrel",				-1, 01 },
			{ "copper-cable",				10, 10 },
			{ "copper-ore",					10, 10 },
			{ "crude-oil-barrel",			10, 10 },
			{ "light-armor",				-1, 01 },
			{ "raw-fish",					-1, 01 },
			{ "iron-plate",					10, 10 },
			{ "copper-plate",				10, 10 },
			{ "steel-plate",				 4,  8 },
			{ "heavy-oil-barrel",			 4,  8 },
			{ "heavy-armor",				-1, 01 },
			{ "light-oil-barrel",			 4,  8 },
			{ "firearm-magazine",			 2,  6 },
			{ "piercing-rounds-magazine",	 1,  5 },
			{ "uranium-rounds-magazine",	 1,  3 },
			{ "modular-armor",				-1, 01 },
			{ "power-armor",				-1, 01 },
			{ "iron-gear-wheel",			 4, 10 }
		},
		
		armorpack = {
			["modular-armor"] = {
				{-1, 1,	"night-vision-equipment" },
				{ 1, 4,	"solar-panel-equipment" }
			},
			["power-armor"] = {
				{-1, 1,	"exoskeleton-equipment" },
				{-1, 1,	"night-vision-equipment" },
				{-1, 1,	"personal-roboport-equipment" },
				{ 1, 8,	"solar-panel-equipment" },
				{-1, 1,	"battery-equipment" },
				{ 1,42,	"construction-robot" }
			}
		}
	}
	
	,ScriptForEach = function(rndroll, game, surface, force, area, center, entity, namelist, locstore, areadata)
		
		local function Rnd(max)
			return ZADVRnd(1,max or 1000,rndroll)
		end
	
		if entity.prototype.name == "wooden-chest" then
			entity.force = 'neutral'
			areadata.entity = entity
			
		elseif entity.prototype.name == "stone-wall" then
			if entity and entity.valid then surface.create_entity{name="zadv-land-mine-warn", position=entity.position} end
			entity.destroy()
			
		elseif entity.prototype.name == "land-mine" and Rnd()  > 600 then
			entity.destroy()
		end
	end
	
	
	,ScriptForAll = function(rndroll, game, surface, force, area, center, namelist, entitylist, areadata, locstore)
		
		areadata.area = area
		areadata.surface = surface
		areadata.chestarea = Position.expand_to_area(center, 6)
		areadata.search = {"wooden-chest", "land-mine", "zadv-land-mine-warn"}
		areadata.prize = {}
		
		local function Rnd(max)
			return ZADVRnd(1,max or 1000,rndroll)
		end
		
		local variant = areadata.variations[math.max(1,Rnd() % #areadata.variations)]
		
		if variant[2] < 0 then
			table.insert(areadata.prize, { name=variant[1], count=1 })
			
		elseif variant[2] ~= 0 or (variant[2] == 0 and Rnd() % 10 ~= 0) then 
			for i=1, math.min(16, math.max(variant[2], Rnd() % variant[3])), 1 do
				table.insert(areadata.prize, variant[1])
			end
		end
		
		if areadata.armorpack[ variant[1] ] then for _,ins in pairs(areadata.armorpack[ variant[1] ]) do
			
			if ins[1] < 0 then table.insert(areadata.prize, { name=ins[3], count=0-ins[1] })
			else table.insert(areadata.prize, {name=ins[3], count= Rnd(ins[2])}) end
			
		end end
		
		if rndroll < 150 then
			for _,ent in pairs(entitylist) do
				if ent and ent.valid and ent.prototype.name == "land-mine" then ent.destroy() end
			end
		end
	end
	
	,Events = {
	
		[defines.events.on_tick] = function(event, ad, game)
		
			local next = true
			
			if ad.looted and not ad.destroyed then
				for _,ent in pairs(ad.surface.find_entities_filtered{area=ad.area,name=ad.search}) do
					if ent and ent.valid then ent.die('enemy') end
					if ent and ent.valid then ent.destroy() end
				end
				for _,e in pairs(ad.surface.find_tiles_filtered{area=ad.area, name={'concrete', 'refined-concrete', 'stone-path', 'refined-hazard-concrete-right', 'refined-hazard-concrete-left', 'hazard-concrete-right', 'hazard-concrete-left'}}) do
					if e and e.position then
						ad.surface.set_tiles({{name='red-desert-2', position=e.position}})
					end
				end
				ad.destroyed = true
				next = false
			end
			
			if ad.looted and ad.destroyed then
				ad.disabled = true
				next = false
				return true
			end
			
			if not ad.entity or not ad.entity.valid then
				if not ad.surface then ad.surface = game.surfaces[1] end
				if ad.surface and ad.chestarea then
					for _,ent in pairs(ad.surface.find_entities_filtered{area=ad.chestarea, name="wooden-chest"}) do
						if ent and ent.valid then ad.entity = ent
						else next = false end
					end
				end
			end
			
			if next and ad.lootarea and not ad.looted and ad.stored_items ~= ad.entity.get_inventory(defines.inventory.chest).get_item_count() then
				ad.looted = true
				next = false
			end 
				
			if next then 
			
				for _,player in pairs(game.players) do if player.surface == ad.surface and next then
						
					if Area.inside(ad.chestarea, player.position) and not ad.lootarea then
						
						for _,ins in pairs(ad.prize) do
							if ad.entity and ad.entity.valid then
								ad.entity.get_inventory(defines.inventory.chest).insert(ins)
							else
								ad.looted = true
								next = false
							end
						end
						
						if next then
							ad.stored_items = ad.entity.get_inventory(defines.inventory.chest).get_item_count()
							ad.lootarea = true
							next = false
						end
						
					end
					
				end end
				
			end
		end
		
	}
	
}
end

if settings.startup["zadv_area_maze"].value then
ret.area['maze variant_1'] = {
	
	-- "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"
	bp="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"
	
	,probability = 35
	,remoteness_min = 30
	,nearest_copy = 10
	,progressive_remoteness = 10
	,random_direction = true
	,minable = false
	
	,areadata = {
		walls = 0,
		name = 'stone-wall',
		search = {"iron-chest","gate","stone-wall"},
		-- prize variations
		variations = {
			{ "science-pack-1",				 2,  6 },
			{ "uranium-ore",				 2,  6 },
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
			{ "power-armor-mk2",			-1,  1 },
			{ "assembling-machine-2",		-1,  2 },
			{ "assembling-machine-3",		-1,  1 },
			{ "solar-panel",				-1,  2 },
			{ "fast-underground-belt",		-1,  4 },
			{ "fast-splitter",				-1,  2 },
			{ "zadv_coin",					-1,  2 }
		},
		armorpack = {
			{-2, 1,	"exoskeleton-equipment" },
			{-1, 1,	"night-vision-equipment" },
			{-1, 1,	"personal-roboport-mk2-equipment" },
			{-4, 1,	"fusion-reactor-equipment" },
			{1, 5,	"energy-shield-mk2-equipment" },
			{1, 10,	"battery-mk2-equipment" },
			{1, 100,"construction-robot" }
		}
	}
	
	,ScriptForEach = function(rndroll, game, surface, force, area, center, entity, namelist, locstore, areadata)
		
		if entity.prototype.name == areadata.name then
			areadata.walls = areadata.walls +1
		end
		
	end

	,ScriptForAll = function(rndroll, game, surface, force, area, center, namelist, entitylist, areadata, locstore)
	
		areadata.prize = {}
		areadata.pos = center
		areadata.surface = surface
		areadata.area = Position.expand_to_area(areadata.pos, 22)
		areadata.chestarea = Position.expand_to_area(areadata.pos, 2)
		areadata.debuffarea = Area.expand(areadata.area,12)
		
		for _,entity in pairs(entitylist) do if entity and entity.valid and entity.prototype.name == "iron-chest" then
			
			entity.force = 'neutral'
			areadata.entity = entity
			areadata.entitypos = entity.position
			
			local function Rnd(max)
				return ZADVRnd(1,max or 1000,rndroll)
			end
			
			local variant = areadata.variations[math.max(1,Rnd() % #areadata.variations)]
			
			if variant[2] < 0 then
				table.insert(areadata.prize, { name=variant[1], count=1 })
				
			elseif variant[2] ~= 0 or (variant[2] == 0 and Rnd() % 10 ~= 0) then 
				for i=1, math.min(16, math.max(variant[2], Rnd() % variant[3])), 1 do
					table.insert(areadata.prize, variant[1])
				end
			end
			
			if variant[1] == 'power-armor-mk2' then for _,ins in pairs(areadata.armorpack) do
				
				if ins[1] < 0 then table.insert(areadata.prize, { name=ins[3], count=0-ins[1] })
				else table.insert(areadata.prize, {name=ins[3], count= Rnd(ins[2])}) end
				
			end end
				
		end end
		
	end
	
	,Events = {
	
		[defines.events.on_tick] = function(event, ad, game)
		
			local next = true
			
			if ad.looted and not ad.destroyed then
				for _,ent in pairs(ad.surface.find_entities_filtered{
				area=ad.area,name=ad.search}) do
					if ent and ent.valid then ent.die('neutral') end
				end
				ad.destroyed = true
			end
			
			if ad.looted and ad.destroyed then
				ad.disabled = true
				return true
			end
			
			if not ad.entity or not ad.entity.valid then
				if not ad.surface then ad.surface = game.surfaces[1] end
				if ad.surface and ad.chestarea then
					for _,ent in pairs(ad.surface.find_entities_filtered{area=ad.chestarea, name="iron-chest"}) do
						if ent.valid then ad.entity = ent
						else next = false end
					end
				end
			end
			
			
			if ad.lootarea and not ad.looted and ad.stored_items ~= ad.entity.get_inventory(defines.inventory.chest).get_item_count() then
				ad.looted = true
				next = false
			end 
			
			for _,player in pairs(game.players) do if player.surface == ad.surface and next then
					
				if Area.inside(Area.shrink(ad.area, 16), player.position) and not ad.lootarea then
					
					local smartass = false
					if ad.walls == ad.surface.count_entities_filtered{ area=ad.area, name=ad.name } then
					
						for _,ins in pairs(ad.prize) do
							if ad.entity and ad.entity.valid then
								ad.entity.get_inventory(defines.inventory.chest).insert(ins)
							else
								smartass = true
							end
						end
						
					else smartass = true end
					
					if smartass then
						ad.looted = true
						if ad.entity and ad.entity.valid then
							ad.entity.destroy()
						end
						ad.surface.spill_item_stack(ad.entitypos, {name='coal'}, true)
						player.print("Naughty kids get coal candy!", Color.black)
						next = false
					end
					
					if next then
						ad.stored_items = ad.entity.get_inventory(defines.inventory.chest).get_item_count()
						ad.lootarea = true
						player.print("Take your prize!", Color.blue)
						next = false
					end
					
				elseif Area.inside(Area.shrink(ad.area, 7), player.position) and not ad.inside then
					ad.inside = true; player.print("Hey ".. player.name ..", you are so close to the treasure. Hurry up!", Color.orange)
					
				elseif Area.inside(ad.area, player.position) and not ad.inarea then
					ad.inarea = true; player.print("You enter the Maze. Don't waste your time!", Color.yellow)
					
				elseif Area.inside(ad.debuffarea, player.position) and not ad.visited then
					ad.visited = true; player.print("You found The Maze!", Color.green)
				end
				
			end end
		end
		
	}
	
}
ret.area['maze variant_2'] = {

	bp="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"
	
	,probability = 35
	,remoteness_min = 30
	,nearest_copy = 10
	,progressive_remoteness = 10
	,random_direction = true
	,minable = false
	
	,areadata = {
		walls = 0,
		name = 'stone-wall',
		search = {"iron-chest","gate","stone-wall"},
		-- prize variations
		variations = {
			{ "science-pack-1",				 2,  6 },
			{ "uranium-ore",				 2,  6 },
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
			{ "power-armor-mk2",			-1,  1 },
			{ "assembling-machine-2",		-1,  2 },
			{ "assembling-machine-3",		-1,  1 },
			{ "solar-panel",				-1,  2 },
			{ "fast-underground-belt",		-1,  4 },
			{ "fast-splitter",				-1,  2 },
			{ "zadv_coin",					-1,  2 }
		},
		armorpack = {
			{-2, 1,	"exoskeleton-equipment" },
			{-1, 1,	"night-vision-equipment" },
			{-1, 1,	"personal-roboport-mk2-equipment" },
			{-4, 1,	"fusion-reactor-equipment" },
			{1, 5,	"energy-shield-mk2-equipment" },
			{1, 10,	"battery-mk2-equipment" },
			{1, 100,"construction-robot" }
		}
	}
	
	,ScriptForEach = function(rndroll, game, surface, force, area, center, entity, namelist, locstore, areadata)
		
		if entity.prototype.name == areadata.name then
			areadata.walls = areadata.walls +1
		end
		
	end

	,ScriptForAll = function(rndroll, game, surface, force, area, center, namelist, entitylist, areadata, locstore)
	
		areadata.prize = {}
		areadata.pos = center
		areadata.surface = surface
		areadata.area = Position.expand_to_area(areadata.pos, 22)
		areadata.chestarea = Position.expand_to_area(areadata.pos, 2)
		areadata.debuffarea = Area.expand(areadata.area,12)
		
		for _,entity in pairs(entitylist) do if entity and entity.valid and entity.prototype.name == "iron-chest" then
			
			entity.force = 'neutral'
			areadata.entity = entity
			areadata.entitypos = entity.position
			
			local function Rnd(max)
				return ZADVRnd(1,max or 1000,rndroll)
			end
			
			local variant = areadata.variations[math.max(1,Rnd() % #areadata.variations)]
			
			if variant[2] < 0 then
				table.insert(areadata.prize, { name=variant[1], count=1 })
				
			elseif variant[2] ~= 0 or (variant[2] == 0 and Rnd() % 10 ~= 0) then 
				for i=1, math.min(16, math.max(variant[2], Rnd() % variant[3])), 1 do
					table.insert(areadata.prize, variant[1])
				end
			end
			
			if variant[1] == 'power-armor-mk2' then for _,ins in pairs(areadata.armorpack) do
				
				if ins[1] < 0 then table.insert(areadata.prize, { name=ins[3], count=0-ins[1] })
				else table.insert(areadata.prize, {name=ins[3], count= Rnd(ins[2])}) end
				
			end end
				
		end end
		
	end
	
	,Events = {
	
		[defines.events.on_tick] = function(event, ad, game)
		
			local next = true
			
			if ad.looted and not ad.destroyed then
				for _,ent in pairs(ad.surface.find_entities_filtered{
				area=ad.area,name=ad.search}) do
					if ent and ent.valid then ent.die('neutral') end
				end
				ad.destroyed = true
			end
			
			if ad.looted and ad.destroyed then
				ad.disabled = true
				return true
			end
			
			if not ad.entity or not ad.entity.valid then
				if not ad.surface then ad.surface = game.surfaces[1] end
				if ad.surface and ad.chestarea then
					for _,ent in pairs(ad.surface.find_entities_filtered{area=ad.chestarea, name="iron-chest"}) do
						if ent.valid then ad.entity = ent
						else next = false end
					end
				end
			end
			
			
			if ad.lootarea and not ad.looted and ad.stored_items ~= ad.entity.get_inventory(defines.inventory.chest).get_item_count() then
				ad.looted = true
				next = false
			end 
			
			for _,player in pairs(game.players) do if player.surface == ad.surface and next then
					
				if Area.inside(Area.shrink(ad.area, 16), player.position) and not ad.lootarea then
					
					local smartass = false
					if ad.walls == ad.surface.count_entities_filtered{ area=ad.area, name=ad.name } then
					
						for _,ins in pairs(ad.prize) do
							if ad.entity and ad.entity.valid then
								ad.entity.get_inventory(defines.inventory.chest).insert(ins)
							else
								smartass = true
							end
						end
						
					else smartass = true end
					
					if smartass then
						ad.looted = true
						if ad.entity and ad.entity.valid then
							ad.entity.destroy()
						end
						ad.surface.spill_item_stack(ad.entitypos, {name='coal'}, true)
						player.print("Naughty kids get coal candy!", Color.black)
						next = false
					end
					
					if next then
						ad.stored_items = ad.entity.get_inventory(defines.inventory.chest).get_item_count()
						ad.lootarea = true
						player.print("Take your prize!", Color.blue)
						next = false
					end
					
				elseif Area.inside(Area.shrink(ad.area, 7), player.position) and not ad.inside then
					ad.inside = true; player.print("Hey ".. player.name ..", you are so close to the treasure. Hurry up!", Color.orange)
					
				elseif Area.inside(ad.area, player.position) and not ad.inarea then
					ad.inarea = true; player.print("You enter the Maze. Don't waste your time!", Color.yellow)
					
				elseif Area.inside(ad.debuffarea, player.position) and not ad.visited then
					ad.visited = true; player.print("You found The Maze!", Color.green)
				end
				
			end end
		end
		
	}
	
}
ret.area['maze variant_3'] = {

	bp="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"
	
	,probability = 35
	,remoteness_min = 40
	,nearest_copy = 10
	,progressive_remoteness = 10
	,random_direction = true
	,minable = false
	
	,areadata = {
		walls = 0,
		name = 'stone-wall',
		search = {"iron-chest","gate","stone-wall"},
		-- prize variations
		variations = {
			{ "science-pack-1",				 2,  6 },
			{ "uranium-ore",				 2,  6 },
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
			{ "power-armor-mk2",			-1,  1 },
			{ "assembling-machine-2",		-1,  2 },
			{ "assembling-machine-3",		-1,  1 },
			{ "solar-panel",				-1,  2 },
			{ "fast-underground-belt",		-1,  4 },
			{ "fast-splitter",				-1,  2 },
			{ "zadv_coin",					-1,  2 }
		},
		armorpack = {
			{-2, 1,	"exoskeleton-equipment" },
			{-1, 1,	"night-vision-equipment" },
			{-1, 1,	"personal-roboport-mk2-equipment" },
			{-4, 1,	"fusion-reactor-equipment" },
			{1, 5,	"energy-shield-mk2-equipment" },
			{1, 10,	"battery-mk2-equipment" },
			{1, 100,"construction-robot" }
		}
	}
	
	,ScriptForEach = function(rndroll, game, surface, force, area, center, entity, namelist, locstore, areadata)
		
		if entity.prototype.name == areadata.name then
			areadata.walls = areadata.walls +1
		end
		
	end

	,ScriptForAll = function(rndroll, game, surface, force, area, center, namelist, entitylist, areadata, locstore)
	
		areadata.prize = {}
		areadata.pos = center
		areadata.surface = surface
		areadata.area = Position.expand_to_area(areadata.pos, 22)
		areadata.chestarea = Position.expand_to_area(areadata.pos, 2)
		areadata.debuffarea = Area.expand(areadata.area,12)
		
		for _,entity in pairs(entitylist) do if entity and entity.valid and entity.prototype.name == "iron-chest" then
			
			entity.force = 'neutral'
			areadata.entity = entity
			areadata.entitypos = entity.position
			
			local function Rnd(max)
				return ZADVRnd(1,max or 1000,rndroll)
			end
			
			local variant = areadata.variations[math.max(1,Rnd() % #areadata.variations)]
			
			if variant[2] < 0 then
				table.insert(areadata.prize, { name=variant[1], count=1 })
				
			elseif variant[2] ~= 0 or (variant[2] == 0 and Rnd() % 10 ~= 0) then 
				for i=1, math.min(16, math.max(variant[2], Rnd() % variant[3])), 1 do
					table.insert(areadata.prize, variant[1])
				end
			end
			
			if variant[1] == 'power-armor-mk2' then for _,ins in pairs(areadata.armorpack) do
				
				if ins[1] < 0 then table.insert(areadata.prize, { name=ins[3], count=0-ins[1] })
				else table.insert(areadata.prize, {name=ins[3], count= Rnd(ins[2])}) end
				
			end end
				
		end end
		
	end
	
	,Events = {
	
		[defines.events.on_tick] = function(event, ad, game)
		
			local next = true
			
			if ad.looted and not ad.destroyed then
				for _,ent in pairs(ad.surface.find_entities_filtered{
				area=ad.area,name=ad.search}) do
					if ent and ent.valid then ent.die('neutral') end
				end
				ad.destroyed = true
			end
			
			if ad.looted and ad.destroyed then
				ad.disabled = true
				return true
			end
			
			if not ad.entity or not ad.entity.valid then
				if not ad.surface then ad.surface = game.surfaces[1] end
				if ad.surface and ad.chestarea then
					for _,ent in pairs(ad.surface.find_entities_filtered{area=ad.chestarea, name="iron-chest"}) do
						if ent.valid then ad.entity = ent
						else next = false end
					end
				end
			end
			
			
			if ad.lootarea and not ad.looted and ad.stored_items ~= ad.entity.get_inventory(defines.inventory.chest).get_item_count() then
				ad.looted = true
				next = false
			end 
			
			for _,player in pairs(game.players) do if player.surface == ad.surface and next then
					
				if Area.inside(Area.shrink(ad.area, 16), player.position) and not ad.lootarea then
					
					local smartass = false
					if ad.walls == ad.surface.count_entities_filtered{ area=ad.area, name=ad.name } then
					
						for _,ins in pairs(ad.prize) do
							if ad.entity and ad.entity.valid then
								ad.entity.get_inventory(defines.inventory.chest).insert(ins)
							else
								smartass = true
							end
						end
						
					else smartass = true end
					
					if smartass then
						ad.looted = true
						if ad.entity and ad.entity.valid then
							ad.entity.destroy()
						end
						ad.surface.spill_item_stack(ad.entitypos, {name='coal'}, true)
						player.print("Naughty kids get coal candy!", Color.black)
						next = false
					end
					
					if next then
						ad.stored_items = ad.entity.get_inventory(defines.inventory.chest).get_item_count()
						ad.lootarea = true
						player.print("Take your prize!", Color.blue)
						next = false
					end
					
				elseif Area.inside(Area.shrink(ad.area, 7), player.position) and not ad.inside then
					ad.inside = true; player.print("Hey ".. player.name ..", you are so close to the treasure. Hurry up!", Color.orange)
					
				elseif Area.inside(ad.area, player.position) and not ad.inarea then
					ad.inarea = true; player.print("You enter the Maze. Don't waste your time!", Color.yellow)
					
				elseif Area.inside(ad.debuffarea, player.position) and not ad.visited then
					ad.visited = true; player.print("You found The Maze!", Color.green)
				end
				
			end end
		end
		
	}
	
}
ret.area['maze variant_4'] = {

	bp="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"
	
	,probability = 35
	,remoteness_min = 50
	,nearest_copy = 10
	,progressive_remoteness = 10
	,random_direction = true
	,minable = false
	
	,areadata = {
		walls = 0,
		name = 'stone-wall',
		search = {"iron-chest","gate","stone-wall"},
		-- prize variations
		variations = {
			{ "science-pack-1",				 2,  6 },
			{ "uranium-ore",				 2,  6 },
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
			{ "power-armor-mk2",			-1,  1 },
			{ "assembling-machine-2",		-1,  2 },
			{ "assembling-machine-3",		-1,  1 },
			{ "solar-panel",				-1,  2 },
			{ "fast-underground-belt",		-1,  4 },
			{ "fast-splitter",				-1,  2 },
			{ "zadv_coin",					-1,  2 }
		},
		armorpack = {
			{-2, 1,	"exoskeleton-equipment" },
			{-1, 1,	"night-vision-equipment" },
			{-1, 1,	"personal-roboport-mk2-equipment" },
			{-4, 1,	"fusion-reactor-equipment" },
			{1, 5,	"energy-shield-mk2-equipment" },
			{1, 10,	"battery-mk2-equipment" },
			{1, 100,"construction-robot" }
		}
	}
	
	,ScriptForEach = function(rndroll, game, surface, force, area, center, entity, namelist, locstore, areadata)
		
		if entity.prototype.name == areadata.name then
			areadata.walls = areadata.walls +1
		end
		
	end

	,ScriptForAll = function(rndroll, game, surface, force, area, center, namelist, entitylist, areadata, locstore)
	
		areadata.prize = {}
		areadata.pos = center
		areadata.surface = surface
		areadata.area = Position.expand_to_area(areadata.pos, 22)
		areadata.chestarea = Position.expand_to_area(areadata.pos, 2)
		areadata.debuffarea = Area.expand(areadata.area,12)
		
		for _,entity in pairs(entitylist) do if entity and entity.valid and entity.prototype.name == "iron-chest" then
			
			entity.force = 'neutral'
			areadata.entity = entity
			areadata.entitypos = entity.position
			
			local function Rnd(max)
				return ZADVRnd(1,max or 1000,rndroll)
			end
			
			local variant = areadata.variations[math.max(1,Rnd() % #areadata.variations)]
			
			if variant[2] < 0 then
				table.insert(areadata.prize, { name=variant[1], count=1 })
				
			elseif variant[2] ~= 0 or (variant[2] == 0 and Rnd() % 10 ~= 0) then 
				for i=1, math.min(16, math.max(variant[2], Rnd() % variant[3])), 1 do
					table.insert(areadata.prize, variant[1])
				end
			end
			
			if variant[1] == 'power-armor-mk2' then for _,ins in pairs(areadata.armorpack) do
				
				if ins[1] < 0 then table.insert(areadata.prize, { name=ins[3], count=0-ins[1] })
				else table.insert(areadata.prize, {name=ins[3], count= Rnd(ins[2])}) end
				
			end end
				
		end end
		
	end
	
	,Events = {
	
		[defines.events.on_tick] = function(event, ad, game)
		
			local next = true
			
			if ad.looted and not ad.destroyed then
				for _,ent in pairs(ad.surface.find_entities_filtered{
				area=ad.area,name=ad.search}) do
					if ent and ent.valid then ent.die('neutral') end
				end
				ad.destroyed = true
			end
			
			if ad.looted and ad.destroyed then
				ad.disabled = true
				return true
			end
			
			if not ad.entity or not ad.entity.valid then
				if not ad.surface then ad.surface = game.surfaces[1] end
				if ad.surface and ad.chestarea then
					for _,ent in pairs(ad.surface.find_entities_filtered{area=ad.chestarea, name="iron-chest"}) do
						if ent.valid then ad.entity = ent
						else next = false end
					end
				end
			end
			
			
			if ad.lootarea and not ad.looted and ad.stored_items ~= ad.entity.get_inventory(defines.inventory.chest).get_item_count() then
				ad.looted = true
				next = false
			end 
			
			for _,player in pairs(game.players) do if player.surface == ad.surface and next then
					
				if Area.inside(Area.shrink(ad.area, 16), player.position) and not ad.lootarea then
					
					local smartass = false
					if ad.walls == ad.surface.count_entities_filtered{ area=ad.area, name=ad.name } then
					
						for _,ins in pairs(ad.prize) do
							if ad.entity and ad.entity.valid then
								ad.entity.get_inventory(defines.inventory.chest).insert(ins)
							else
								smartass = true
							end
						end
						
					else smartass = true end
					
					if smartass then
						ad.looted = true
						if ad.entity and ad.entity.valid then
							ad.entity.destroy()
						end
						ad.surface.spill_item_stack(ad.entitypos, {name='coal'}, true)
						player.print("Naughty kids get coal candy!", Color.black)
						next = false
					end
					
					if next then
						ad.stored_items = ad.entity.get_inventory(defines.inventory.chest).get_item_count()
						ad.lootarea = true
						player.print("Take your prize!", Color.blue)
						next = false
					end
					
				elseif Area.inside(Area.shrink(ad.area, 7), player.position) and not ad.inside then
					ad.inside = true; player.print("Hey ".. player.name ..", you are so close to the treasure. Hurry up!", Color.orange)
					
				elseif Area.inside(ad.area, player.position) and not ad.inarea then
					ad.inarea = true; player.print("You enter the Maze. Don't waste your time!", Color.yellow)
					
				elseif Area.inside(ad.debuffarea, player.position) and not ad.visited then
					ad.visited = true; player.print("You found The Maze!", Color.green)
				end
				
			end end
		end
		
	}
	
}
ret.area['maze variant_5'] = {

	bp="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"
	
	,probability = 35
	,remoteness_min = 60
	,nearest_copy = 10
	,progressive_remoteness = 10
	,random_direction = true
	,minable = false
	
	,areadata = {
		walls = 0,
		name = 'stone-wall',
		search = {"iron-chest","gate","stone-wall"},
		-- prize variations
		variations = {
			{ "science-pack-1",				 2,  6 },
			{ "uranium-ore",				 2,  6 },
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
			{ "power-armor-mk2",			-1,  1 },
			{ "assembling-machine-2",		-1,  2 },
			{ "assembling-machine-3",		-1,  1 },
			{ "solar-panel",				-1,  2 },
			{ "fast-underground-belt",		-1,  4 },
			{ "fast-splitter",				-1,  2 },
			{ "zadv_coin",					-1,  2 }
		},
		armorpack = {
			{-2, 1,	"exoskeleton-equipment" },
			{-1, 1,	"night-vision-equipment" },
			{-1, 1,	"personal-roboport-mk2-equipment" },
			{-4, 1,	"fusion-reactor-equipment" },
			{1, 5,	"energy-shield-mk2-equipment" },
			{1, 10,	"battery-mk2-equipment" },
			{1, 100,"construction-robot" }
		}
	}
	
	,ScriptForEach = function(rndroll, game, surface, force, area, center, entity, namelist, locstore, areadata)
		
		if entity.prototype.name == areadata.name then
			areadata.walls = areadata.walls +1
		end
		
	end

	,ScriptForAll = function(rndroll, game, surface, force, area, center, namelist, entitylist, areadata, locstore)
	
		areadata.prize = {}
		areadata.pos = center
		areadata.surface = surface
		areadata.area = Position.expand_to_area(areadata.pos, 22)
		areadata.chestarea = Position.expand_to_area(areadata.pos, 2)
		areadata.debuffarea = Area.expand(areadata.area,12)
		
		for _,entity in pairs(entitylist) do if entity and entity.valid and entity.prototype.name == "iron-chest" then
			
			entity.force = 'neutral'
			areadata.entity = entity
			areadata.entitypos = entity.position
			
			local function Rnd(max)
				return ZADVRnd(1,max or 1000,rndroll)
			end
			
			local variant = areadata.variations[math.max(1,Rnd() % #areadata.variations)]
			
			if variant[2] < 0 then
				table.insert(areadata.prize, { name=variant[1], count=1 })
				
			elseif variant[2] ~= 0 or (variant[2] == 0 and Rnd() % 10 ~= 0) then 
				for i=1, math.min(16, math.max(variant[2], Rnd() % variant[3])), 1 do
					table.insert(areadata.prize, variant[1])
				end
			end
			
			if variant[1] == 'power-armor-mk2' then for _,ins in pairs(areadata.armorpack) do
				
				if ins[1] < 0 then table.insert(areadata.prize, { name=ins[3], count=0-ins[1] })
				else table.insert(areadata.prize, {name=ins[3], count= Rnd(ins[2])}) end
				
			end end
				
		end end
		
	end
	
	,Events = {
	
		[defines.events.on_tick] = function(event, ad, game)
		
			local next = true
			
			if ad.looted and not ad.destroyed then
				for _,ent in pairs(ad.surface.find_entities_filtered{
				area=ad.area,name=ad.search}) do
					if ent and ent.valid then ent.die('neutral') end
				end
				ad.destroyed = true
			end
			
			if ad.looted and ad.destroyed then
				ad.disabled = true
				return true
			end
			
			if not ad.entity or not ad.entity.valid then
				if not ad.surface then ad.surface = game.surfaces[1] end
				if ad.surface and ad.chestarea then
					for _,ent in pairs(ad.surface.find_entities_filtered{area=ad.chestarea, name="iron-chest"}) do
						if ent.valid then ad.entity = ent
						else next = false end
					end
				end
			end
			
			
			if ad.lootarea and not ad.looted and ad.stored_items ~= ad.entity.get_inventory(defines.inventory.chest).get_item_count() then
				ad.looted = true
				next = false
			end 
			
			for _,player in pairs(game.players) do if player.surface == ad.surface and next then
					
				if Area.inside(Area.shrink(ad.area, 16), player.position) and not ad.lootarea then
					
					local smartass = false
					if ad.walls == ad.surface.count_entities_filtered{ area=ad.area, name=ad.name } then
					
						for _,ins in pairs(ad.prize) do
							if ad.entity and ad.entity.valid then
								ad.entity.get_inventory(defines.inventory.chest).insert(ins)
							else
								smartass = true
							end
						end
						
					else smartass = true end
					
					if smartass then
						ad.looted = true
						if ad.entity and ad.entity.valid then
							ad.entity.destroy()
						end
						ad.surface.spill_item_stack(ad.entitypos, {name='coal'}, true)
						player.print("Naughty kids get coal candy!", Color.black)
						next = false
					end
					
					if next then
						ad.stored_items = ad.entity.get_inventory(defines.inventory.chest).get_item_count()
						ad.lootarea = true
						player.print("Take your prize!", Color.blue)
						next = false
					end
					
				elseif Area.inside(Area.shrink(ad.area, 7), player.position) and not ad.inside then
					ad.inside = true; player.print("Hey ".. player.name ..", you are so close to the treasure. Hurry up!", Color.orange)
					
				elseif Area.inside(ad.area, player.position) and not ad.inarea then
					ad.inarea = true; player.print("You enter the Maze. Don't waste your time!", Color.yellow)
					
				elseif Area.inside(ad.debuffarea, player.position) and not ad.visited then
					ad.visited = true; player.print("You found The Maze!", Color.green)
				end
				
			end end
		end
		
	}
	
}
ret.area['maze variant_6'] = {

	bp="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"
	
	,probability = 35
	,remoteness_min = 70
	,nearest_copy = 10
	,progressive_remoteness = 10
	,random_direction = true
	,minable = false
	
	,areadata = {
		walls = 0,
		name = 'stone-wall',
		search = {"iron-chest","gate","stone-wall"},
		-- prize variations
		variations = {
			{ "science-pack-1",				 2,  6 },
			{ "uranium-ore",				 2,  6 },
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
			{ "power-armor-mk2",			-1,  1 },
			{ "assembling-machine-2",		-1,  2 },
			{ "assembling-machine-3",		-1,  1 },
			{ "solar-panel",				-1,  2 },
			{ "fast-underground-belt",		-1,  4 },
			{ "fast-splitter",				-1,  2 },
			{ "zadv_coin",					-1,  2 }
		},
		armorpack = {
			{-2, 1,	"exoskeleton-equipment" },
			{-1, 1,	"night-vision-equipment" },
			{-1, 1,	"personal-roboport-mk2-equipment" },
			{-4, 1,	"fusion-reactor-equipment" },
			{1, 5,	"energy-shield-mk2-equipment" },
			{1, 10,	"battery-mk2-equipment" },
			{1, 100,"construction-robot" }
		}
	}
	
	,ScriptForEach = function(rndroll, game, surface, force, area, center, entity, namelist, locstore, areadata)
		
		if entity.prototype.name == areadata.name then
			areadata.walls = areadata.walls +1
		end
		
	end

	,ScriptForAll = function(rndroll, game, surface, force, area, center, namelist, entitylist, areadata, locstore)
	
		areadata.prize = {}
		areadata.pos = center
		areadata.surface = surface
		areadata.area = Position.expand_to_area(areadata.pos, 22)
		areadata.chestarea = Position.expand_to_area(areadata.pos, 2)
		areadata.debuffarea = Area.expand(areadata.area,12)
		
		for _,entity in pairs(entitylist) do if entity and entity.valid and entity.prototype.name == "iron-chest" then
			
			entity.force = 'neutral'
			areadata.entity = entity
			areadata.entitypos = entity.position
			
			local function Rnd(max)
				return ZADVRnd(1,max or 1000,rndroll)
			end
			
			local variant = areadata.variations[math.max(1,Rnd() % #areadata.variations)]
			
			if variant[2] < 0 then
				table.insert(areadata.prize, { name=variant[1], count=1 })
				
			elseif variant[2] ~= 0 or (variant[2] == 0 and Rnd() % 10 ~= 0) then 
				for i=1, math.min(16, math.max(variant[2], Rnd() % variant[3])), 1 do
					table.insert(areadata.prize, variant[1])
				end
			end
			
			if variant[1] == 'power-armor-mk2' then for _,ins in pairs(areadata.armorpack) do
				
				if ins[1] < 0 then table.insert(areadata.prize, { name=ins[3], count=0-ins[1] })
				else table.insert(areadata.prize, {name=ins[3], count= Rnd(ins[2])}) end
				
			end end
				
		end end
		
	end
	
	,Events = {
	
		[defines.events.on_tick] = function(event, ad, game)
		
			local next = true
			
			if ad.looted and not ad.destroyed then
				for _,ent in pairs(ad.surface.find_entities_filtered{
				area=ad.area,name=ad.search}) do
					if ent and ent.valid then ent.die('neutral') end
				end
				ad.destroyed = true
			end
			
			if ad.looted and ad.destroyed then
				ad.disabled = true
				return true
			end
			
			if not ad.entity or not ad.entity.valid then
				if not ad.surface then ad.surface = game.surfaces[1] end
				if ad.surface and ad.chestarea then
					for _,ent in pairs(ad.surface.find_entities_filtered{area=ad.chestarea, name="iron-chest"}) do
						if ent.valid then ad.entity = ent
						else next = false end
					end
				end
			end
			
			
			if ad.lootarea and not ad.looted and ad.stored_items ~= ad.entity.get_inventory(defines.inventory.chest).get_item_count() then
				ad.looted = true
				next = false
			end 
			
			for _,player in pairs(game.players) do if player.surface == ad.surface and next then
					
				if Area.inside(Area.shrink(ad.area, 16), player.position) and not ad.lootarea then
					
					local smartass = false
					if ad.walls == ad.surface.count_entities_filtered{ area=ad.area, name=ad.name } then
					
						for _,ins in pairs(ad.prize) do
							if ad.entity and ad.entity.valid then
								ad.entity.get_inventory(defines.inventory.chest).insert(ins)
							else
								smartass = true
							end
						end
						
					else smartass = true end
					
					if smartass then
						ad.looted = true
						if ad.entity and ad.entity.valid then
							ad.entity.destroy()
						end
						ad.surface.spill_item_stack(ad.entitypos, {name='coal'}, true)
						player.print("Naughty kids get coal candy!", Color.black)
						next = false
					end
					
					if next then
						ad.stored_items = ad.entity.get_inventory(defines.inventory.chest).get_item_count()
						ad.lootarea = true
						player.print("Take your prize!", Color.blue)
						next = false
					end
					
				elseif Area.inside(Area.shrink(ad.area, 7), player.position) and not ad.inside then
					ad.inside = true; player.print("Hey ".. player.name ..", you are so close to the treasure. Hurry up!", Color.orange)
					
				elseif Area.inside(ad.area, player.position) and not ad.inarea then
					ad.inarea = true; player.print("You enter the Maze. Don't waste your time!", Color.yellow)
					
				elseif Area.inside(ad.debuffarea, player.position) and not ad.visited then
					ad.visited = true; player.print("You found The Maze!", Color.green)
				end
				
			end end
		end
		
	}
	
}
ret.area['maze variant_7'] = {

	bp="0eNqtneGOHreRRd9lfktAF8kmi36VwAhke2IPII8MaZysY+jd147X9mLFS/Ee768gifpONT929+muqls/P3z19sfHH94/Pb88fPHzw9PX754/PHzxt58fPjx9+/zm7a//28tPPzw+fPHw9PL4/cOrh+c33//63z68vHt+fP2vN2/fPnx89fD0/M3jfz18ER+/fPXw+Pzy9PL0+JvKf/7LT39//vH7rx7f//IPVse/evjh3YdfDnn3/Otf+0XmdblePfz063/Gx4+vPhEphyKxE6lnIpE7kXYoMnci96FI34n0Q5GxExmHIm0nkoci905kHoqUnUhchyp1q3K4Z2O7Z+Nw08Z208bhrt1u2jjctdtNG4e7drtp43DXbjdtHO7a7aaNw1273bRxuGu3m7Ycbtrtni1/7tlv37w8fnr4n3v11cM3T+8fv/7t/ysrrdOduw3obOPuV+Zs3+7jONu2271Sznbt/gc627Tbq6ec7dntli1nW3Z7P6lnO3Z7Edezm+z+HlvPdur2vlbPNur+wVMPd+oeUM626v5hXM/26v4JWM826x5Q6tlu3WNBPduun4G2s/26R6V2tmH3INvONuweH9vhrXW72VozmfpaqtyeSsylSjepeh3L8FRELOlxtVCZJhMvz+i+PJV1LHd4aC1UiofWQqV6aC1UmofWQuW2qFiImEC7/p2HJSIiSYuKhci0qHgt0j2gFSLhQehyYbtHsiKSalHoOhCLZEUcFskKDYtkhYZFskLDIlmhMR0KXWuMywFIoREe+y03yCgWhYpIqhWJEGkWQAqR22O/9Zp0S0REMiz2EyJpsZ8QmRb7rUXy8thvubAZloiIxPwoG7lUqabKWKo079uuULlNgFyrmB9mxboM7xuxiMWF2bXK9L4Sr1WmC7NrlTAxdLm604XZdSwuzK5VXJhdq5gwuxbxYFasrQmz60i8r7MiEhNmxzqlYNJsrlXC+lKsYileLELlbN9ee5HmobVQuS0uFmvbLRERybDIWESSloiIZFpsvI7kMBO23/qHibDcixQL04VItThdrEmzPjmrUG4rFCHSPVIXKsNDdbEs6amIWKYH6+tYDnNhe0aIEh7zi1iK9elZxVK9WIRK894dhMrtcb9Yl+6piFiGCf59LZOmzL2WmeYLxFqmXuYbhJAJE/6FTDHpX8hUE/+FTDP5X8jcJrqv903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"
	
	,probability = 35
	,remoteness_min = 80
	,nearest_copy = 10
	,progressive_remoteness = 10
	,random_direction = true
	,minable = false
	
	,areadata = {
		walls = 0,
		name = 'stone-wall',
		search = {"iron-chest","gate","stone-wall"},
		-- prize variations
		variations = {
			{ "science-pack-1",				 2,  6 },
			{ "uranium-ore",				 2,  6 },
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
			{ "power-armor-mk2",			-1,  1 },
			{ "assembling-machine-2",		-1,  2 },
			{ "assembling-machine-3",		-1,  1 },
			{ "solar-panel",				-1,  2 },
			{ "fast-underground-belt",		-1,  4 },
			{ "fast-splitter",				-1,  2 },
			{ "zadv_coin",					-1,  2 }
		},
		armorpack = {
			{-2, 1,	"exoskeleton-equipment" },
			{-1, 1,	"night-vision-equipment" },
			{-1, 1,	"personal-roboport-mk2-equipment" },
			{-4, 1,	"fusion-reactor-equipment" },
			{1, 5,	"energy-shield-mk2-equipment" },
			{1, 10,	"battery-mk2-equipment" },
			{1, 100,"construction-robot" }
		}
	}
	
	,ScriptForEach = function(rndroll, game, surface, force, area, center, entity, namelist, locstore, areadata)
		
		if entity.prototype.name == areadata.name then
			areadata.walls = areadata.walls +1
		end
		
	end

	,ScriptForAll = function(rndroll, game, surface, force, area, center, namelist, entitylist, areadata, locstore)
	
		areadata.prize = {}
		areadata.pos = center
		areadata.surface = surface
		areadata.area = Position.expand_to_area(areadata.pos, 22)
		areadata.chestarea = Position.expand_to_area(areadata.pos, 2)
		areadata.debuffarea = Area.expand(areadata.area,12)
		
		for _,entity in pairs(entitylist) do if entity and entity.valid and entity.prototype.name == "iron-chest" then
			
			entity.force = 'neutral'
			areadata.entity = entity
			areadata.entitypos = entity.position
			
			local function Rnd(max)
				return ZADVRnd(1,max or 1000,rndroll)
			end
			
			local variant = areadata.variations[math.max(1,Rnd() % #areadata.variations)]
			
			if variant[2] < 0 then
				table.insert(areadata.prize, { name=variant[1], count=1 })
				
			elseif variant[2] ~= 0 or (variant[2] == 0 and Rnd() % 10 ~= 0) then 
				for i=1, math.min(16, math.max(variant[2], Rnd() % variant[3])), 1 do
					table.insert(areadata.prize, variant[1])
				end
			end
			
			if variant[1] == 'power-armor-mk2' then for _,ins in pairs(areadata.armorpack) do
				
				if ins[1] < 0 then table.insert(areadata.prize, { name=ins[3], count=0-ins[1] })
				else table.insert(areadata.prize, {name=ins[3], count= Rnd(ins[2])}) end
				
			end end
				
		end end
		
	end
	
	,Events = {
	
		[defines.events.on_tick] = function(event, ad, game)
		
			local next = true
			
			if ad.looted and not ad.destroyed then
				for _,ent in pairs(ad.surface.find_entities_filtered{
				area=ad.area,name=ad.search}) do
					if ent and ent.valid then ent.die('neutral') end
				end
				ad.destroyed = true
			end
			
			if ad.looted and ad.destroyed then
				ad.disabled = true
				return true
			end
			
			if not ad.entity or not ad.entity.valid then
				if not ad.surface then ad.surface = game.surfaces[1] end
				if ad.surface and ad.chestarea then
					for _,ent in pairs(ad.surface.find_entities_filtered{area=ad.chestarea, name="iron-chest"}) do
						if ent.valid then ad.entity = ent
						else next = false end
					end
				end
			end
			
			
			if ad.lootarea and not ad.looted and ad.stored_items ~= ad.entity.get_inventory(defines.inventory.chest).get_item_count() then
				ad.looted = true
				next = false
			end 
			
			for _,player in pairs(game.players) do if player.surface == ad.surface and next then
					
				if Area.inside(Area.shrink(ad.area, 16), player.position) and not ad.lootarea then
					
					local smartass = false
					if ad.walls == ad.surface.count_entities_filtered{ area=ad.area, name=ad.name } then
					
						for _,ins in pairs(ad.prize) do
							if ad.entity and ad.entity.valid then
								ad.entity.get_inventory(defines.inventory.chest).insert(ins)
							else
								smartass = true
							end
						end
						
					else smartass = true end
					
					if smartass then
						ad.looted = true
						if ad.entity and ad.entity.valid then
							ad.entity.destroy()
						end
						ad.surface.spill_item_stack(ad.entitypos, {name='coal'}, true)
						player.print("Naughty kids get coal candy!", Color.black)
						next = false
					end
					
					if next then
						ad.stored_items = ad.entity.get_inventory(defines.inventory.chest).get_item_count()
						ad.lootarea = true
						player.print("Take your prize!", Color.blue)
						next = false
					end
					
				elseif Area.inside(Area.shrink(ad.area, 7), player.position) and not ad.inside then
					ad.inside = true; player.print("Hey ".. player.name ..", you are so close to the treasure. Hurry up!", Color.orange)
					
				elseif Area.inside(ad.area, player.position) and not ad.inarea then
					ad.inarea = true; player.print("You enter the Maze. Don't waste your time!", Color.yellow)
					
				elseif Area.inside(ad.debuffarea, player.position) and not ad.visited then
					ad.visited = true; player.print("You found The Maze!", Color.green)
				end
				
			end end
		end
		
	}
	
}
end

if settings.startup["zadv_area_lab"].value then
ret.area['smart lab'] = {
	
	bp="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"
	
	,probability = 35
	,remoteness_min = 5
	,remoteness_max = 50
	,unique = true
	,force = "player"
	,random_direction = false
	,force_reveal = true
	
	,destructible = false
	,operable = false
	,rotatable = false
	
	,ScriptForEach = function(rndroll, game, surface, force, area, center, entity, namelist, locstore, areadata)
		
		entity.force = force
		entity.operable = false
		entity.rotatable = false
		entity.destructible = false
		
	end
	
	,messages = {
		{ msg = "Let be the light! Or science?.. Or.. Whatever...", color = {r=0.30, g=0.70, b=1, a=0.8} },
		{ msg = "Give me a place to stand and with a lever. I will.. do something.", color = {r=0.30, g=0.70, b=1, a=0.8} },
		{ msg = "Fifteen men on a dead man's chest. Yo ho ho and a bottles of science? o_O", color = {r=0.30, g=0.70, b=1, a=0.8} },
		{ msg = "Nerds attack!", color = {r=0.30, g=0.70, b=1, a=0.8} }
	}
}
end

if settings.startup["zadv_area_atom"].value then
ret.area['unbuilded atom'] = {
	
	bp="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"
	
	,probability = 300
	,remoteness_min = 50
	,force = "player"
	,only_once = true
	,ignore_technologies = false
	,random_direction = true
	,finalize_build = false
}
end

if settings.startup["zadv_area_bp"].value then
ret.area['random bp'] = {
	
	bp="0eNptjs0KwjAQhN9lzhHaHmzNq4hIfxZdaDahSauh5N1N6sWDl4EZZr/ZHcO8kltYAvQOHq146OsOzw/p55KF6AgaHMhAQXpT3MvaieQ0PskHJAWWid7QdbopkAQOTF/OYeJdVjPQkgv/CQrO+nxkpSxmUKUQs6bCO5b1z6MKGy3+KJ+7tmm6+lK1TUofNCJETw=="
	
	,probability = 150
	,remoteness_min = 5
	,max_copies = 10
	,nearest_copy = 10
	
	,areadata = {
		 "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"

	}
	
	,ScriptForEach = function(rndroll, game, surface, force, area, center, entity, namelist, locstore, areadata)
	
		if entity and entity.valid and entity.prototype.name == "wooden-chest" then
			
			local bp = table.deepcopy(areadata[math.max(1,ZADVRnd(1,1000,rndroll)%#areadata)])
			areadata = nil
			entity.get_inventory(defines.inventory.chest).insert({ name='blueprint', count=1 })
			entity.get_inventory(defines.inventory.chest).find_item_stack('blueprint').import_stack(bp)
			surface.create_entity{name = "rock-big", position = entity.position, force = 'neutral'}
			
		end
	end
	
}
end

if settings.startup["zadv_area_base"].value and settings.startup["zadv_dangerous"].value then
ret.area['occupied base'] = {
	
	bp="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"
	
	,probability = 200
	,remoteness_min = 125
	,only_once = true
	,ignore_technologies = true
	,force = "force"
	,random_direction = true
	
	,dangerous = true
		
	,ScriptForEach = function(rndroll, game, surface, force, area, center, entity, namelist, locstore, areadata)
		
		if entity.valid then
			if entity.prototype.name == "wooden-chest" then
				locstore.posa = locstore.posa or {}
				table.insert(locstore.posa, entity.position)
				entity.destroy()
				
			elseif entity.prototype.name == "iron-chest" then
				locstore.posb = locstore.posb or {}
				table.insert(locstore.posb, entity.position)
				entity.destroy()
				
			elseif entity.prototype.name == "logistic-chest-storage" then
				entity.get_inventory(defines.inventory.chest).insert({name="piercing-rounds-magazine", count=1000})
				
			elseif entity.prototype.name == "storage-tank" then
				entity.fluidbox[1] = { name = "heavy-oil", amount = 25000 }
				
			elseif entity.prototype.name == "roboport" then
				locstore.posc = entity.position
				entity.destroy()
				
			end
		end
		
	end
	
	,ScriptForAll = function(rndroll, game, surface, force, area, center, namelist, entitylist, areadata, locstore)
		
		for _,e in pairs(surface.find_entities_filtered{area=Area.expand(area,5), name={"wooden-chest","iron-chest","roboport"}}) do e.destroy() end
		
		locstore.zombie = locstore.zombie or "zadv-medium-zombie"
		locstore.spawner = locstore.spawner or "zadv-beast-spawner"
		
		for _,pos in pairs(locstore.posa) do
			locstore.zombie = locstore.zombie == "zadv-big-zombie" and "zadv-medium-zombie" or "zadv-big-zombie"
			ForceCreateEntity(surface, locstore.zombie, pos, force)
		end
		for _,pos in pairs(locstore.posb) do
			locstore.spawner = locstore.spawner == "zadv-zombie-spawner" and "zadv-beast-spawner" or "zadv-zombie-spawner"
			ForceCreateEntity(surface, locstore.spawner, pos, force)
		end
		
		local ent = ForceCreateEntity(surface, 'zadv-roboport', locstore.posc, force)
		ent.get_inventory(defines.inventory.roboport_robot).insert({name="logistic-robot", count=50})
		ent.get_inventory(defines.inventory.roboport_robot).insert({name="construction-robot", count=50})
		ent.get_inventory(defines.inventory.roboport_material).insert({name="repair-pack", count=500})
		areadata.robopos = ent.position
		local ent = ForceCreateEntity(surface, 'hidden-electric-energy-interface', locstore.posc, force)
		ent.electric_buffer_size = 108283
		ent.power_production = 108283
		ent.power_usage = 100000
		
		
		areadata.force = force
		areadata.surface = surface
		areadata.center = center
		areadata.timestamp1 = game.tick + 600
		areadata.timestamp2 = game.tick + 54000
		
		game.forces[force].friendly_fire = false
		game.forces[force].cancel_charting(surface)
		game.forces[force].set_cease_fire('enemy', false)
		game.forces[force].set_cease_fire('player', false)
		game.forces[force].evolution_factor = math.min(1, game.forces.enemy.evolution_factor + 0.4)
		
		game.forces[force].worker_robots_battery_modifier = 100
		game.forces[force].worker_robots_speed_modifier = 50
		game.forces[force].worker_robots_storage_bonus = 5
		
	end

	,Events = {
	
		[defines.events.on_tick] = function(event, ad, game)
			
			if ad.timestamp1 <= game.tick and ad.timestamp1 ~= 0 then
				ad.surface.set_multi_command{unit_count=20, force=ad.force, unit_search_distance=40,
					command={type=defines.command.build_base, destination=Position.offset(ad.center, 45, 45),	distraction=defines.distraction.none, ignore_planner=true}}
				ad.surface.set_multi_command{unit_count=20, force=ad.force, unit_search_distance=40,
					command={type=defines.command.build_base, destination=Position.offset(ad.center, -45, 45),	distraction=defines.distraction.none, ignore_planner=true}}
				ad.surface.set_multi_command{unit_count=20, force=ad.force, unit_search_distance=40,
					command={type=defines.command.build_base, destination=Position.offset(ad.center, 45, -45),	distraction=defines.distraction.none, ignore_planner=true}}
				ad.surface.set_multi_command{unit_count=20, force=ad.force, unit_search_distance=40,
					command={type=defines.command.build_base, destination=Position.offset(ad.center, -45, -45),distraction=defines.distraction.none, ignore_planner=true}}
				ad.timestamp1 = 0
			end
			
			if ad.timestamp2 <= game.tick and ad.timestamp2 ~= 0 then
				game.forces[ad.force].ai_controllable = true
				ad.timestamp2 = 0
			end
			
		end
	
		,[defines.events.on_biter_base_built] = function(event, ad, game)
			
			if event.entity.valid and event.entity.force.name == ad.force then
				if event.entity.prototype.name:find('bit') and event.entity.prototype.name:find('spawn') then
					ad.surface.create_entity{name = 'zadv-beast-spawner', position = event.entity.position, force=ad.force}
					event.entity.destroy()
				elseif event.entity.prototype.name:find('spit') and event.entity.prototype.name:find('spawn') then
					ad.surface.create_entity{name = 'zadv-zombie-spawner', position = event.entity.position, force=ad.force}
					event.entity.destroy()
				end
			end
			
		end
		
		,[defines.events.on_entity_died] = function(event, ad, game)
			
			if event.entity.force.name == ad.force and event.entity.prototype.name == "zadv-roboport" then
				game.forces[ad.force].ai_controllable = false
				local ent = ad.surface.find_entities_filtered{name='hidden-electric-energy-interface', position=ad.robopos}
				if ent and ent.valid then ent.destroy() end
				game.forces[ad.force].set_cease_fire('player', true)
				ad.disabled = true
			end
			
		end
		
	}
	,messages = {
		{ msg = "BEWARE! New threat on horizont.", color = {r=0.9, g=0.4, b=0} }
	}

}
end

if settings.startup["zadv_area_recipe"].value then
ret.area['free recipe'] = {
	
	bp="0eNptjs0KwjAQhN9lzhHaHmzNq4hIfxZdaDahSauh5N1N6sWDl4EZZr/ZHcO8kltYAvQOHq146OsOzw/p55KF6AgaHMhAQXpT3MvaieQ0PskHJAWWid7QdbopkAQOTF/OYeJdVjPQkgv/CQrO+nxkpSxmUKUQs6bCO5b1z6MKGy3+KJ+7tmm6+lK1TUofNCJETw=="
	
	,probability = 30
	,remoteness_min = 1
	,max_copies = 10
	,nearest_copy = 20
	,progressive_remoteness = 5
	
	,areadata = {
		dissalowed_recipes = {
			"hidden-electric-energy-interface",
			"electric-energy-interface",
			"infinity-chest",
			"player-port",
			"railgun",
			"railgun-dart",
			"small-plane",
			"electric-energy-interface",
			"express-loader",
			"fast-loader",
			"loader"
		}
	}
	
	,ScriptForAll = function(rndroll, game, surface, force, area, center, namelist, entitylist, areadata, locstore)
		
		for _,ent in pairs(entitylist) do
			areadata.center = ent.position
			if ent and ent.valid then ent.destroy() end
		end
		
	end
	
	,Events = {
	
		[defines.events.on_tick] = function(event, ad, game)
				
			for _,player in pairs(game.players) do
				if Area.inside(Position.expand_to_area(ad.center, 32), player.position) then
					
					local possible_recipes = {}
					for _,r in pairs(player.force.recipes) do
						if not r.hidden and not r.enabled and not r.name:find('creative-mode') then
							if ad.dissalowed_recipes then
								local alowed = true
								for _,dr in pairs(ad.dissalowed_recipes) do
									if dr == r.name then alowed = false end
								end
								if alowed then
									table.insert(possible_recipes, r.name)
								end
							else
								table.insert(possible_recipes, r.name)
							end
						end
					end
					
					local rec = 'dummy'
					if #possible_recipes then
						rec = ZADVRnd(1,#possible_recipes,game.tick)
						if possible_recipes and possible_recipes[rec] then
							rec = possible_recipes[rec]
						else ad.disabled = true
						end
					else ad.disabled = true
					end
					
					if not ad.disabled and player.force.recipes[rec] then
						player.force.recipes[rec].enabled = true
						player.print({'message.zadv_hey_recipe',player.force.recipes[rec].prototype.localised_name}, Color.green)
						ad.disabled = true
					end
					
				end
			end
		end
		
	}

}
end

if settings.startup["zadv_area_technology"].value then
ret.area['free technology'] = {
	
	bp = "0eNptjs0KwjAQhN9lzhHaHmzNq4hIfxZdaDahSauh5N1N6sWDl4EZZr/ZHcO8kltYAvQOHq146OsOzw/p55KF6AgaHMhAQXpT3MvaieQ0PskHJAWWid7QdbopkAQOTF/OYeJdVjPQkgv/CQrO+nxkpSxmUKUQs6bCO5b1z6MKGy3+KJ+7tmm6+lK1TUofNCJETw=="
	
	,probability = 20	
	,remoteness_min = 10
	,max_copies = 10
	,nearest_copy = 20
	,progressive_remoteness = 5
	
	,ScriptForAll = function(rndroll, game, surface, force, area, center, namelist, entitylist, areadata, locstore)
		
		for _,ent in pairs(entitylist) do
			areadata.center = ent.position
			if ent and ent.valid then ent.destroy() end
		end
		
	end
	
	,Events = {
	
		[defines.events.on_tick] = function(event, ad, game)
		
			for _,player in pairs(game.players) do
				if Area.inside(Position.expand_to_area(ad.center, 32), player.position) then
					
					local possible_tech = {}
					for _,t in pairs(player.force.technologies) do
						if t.enabled and not t.researched then
							if ad.dissalowed_techs then
								local alowed = true
								for _,dr in pairs(ad.dissalowed_techs) do
									if dr == t.name then alowed = false end
								end
								if alowed then
									table.insert(possible_tech, t.name)
								end
							else
								table.insert(possible_tech, t.name)
							end
						end
					end
					
					local tech = 'dummy'
					if #possible_tech then
						tech = ZADVRnd(1,#possible_tech,game.tick)
						if possible_tech and possible_tech[tech] then
							tech = possible_tech[tech]
						else ad.disabled = true
						end
					else ad.disabled = true
					end
					
					if not ad.disabled and player.force.technologies[tech] then
						player.force.technologies[tech].researched = true
						player.print({'message.zadv_hey_tech', player.force.technologies[tech].prototype.localised_name}, Color.green)
						ad.disabled = true
					end
					
				end
			end
		end
		
	}

}
end

if settings.startup["zadv_area_station"].value then
ret.area['inventive station'] = {
	
	bp = "0eNrVWttu4zYQ/ZVCz1bBm6/onxQLQ5aYhqhMGRSdbTbwvy9lZWPXHqk889aXxLI5h5c5OnORPopDe7an4Hwsdh+FqzvfF7s/P4re/eWrdvguvp9ssStctMdiUfjqOFy11aG4LArnG/tPsZOXb4vC+uiis6P59eJ978/Hgw1pwJdhHztvy+9V2yawU9cnk84P0ySYcrko3tM/c7ksniAUBLGkIPQNomurUJ4qbykMPWJoCsPkLcPMLGOZB6FnIFZ5EGoGYv0vXz7Zipkz2OTNLmdm32ZBiBkEKbIg5hYhZR4h5vgg83g55wmpsyDm+CDzaDnHSplHy7n7S64QCPIul2voNlckxgbCoN26RbZCQiiBQJA7UZhuShJDIYolSAgNiR69DIOoHr0MTDjpZUDKSS/jRtGjbdz5WNrW1jG4ujx1rZ2WYXpBN7IOsTdWPpZ1dzw4X8UuTKuqTNG3cSFNfP0tnW4yj6Fr9wf7Wr25ZJsMXlwbbZiI6G8uxHPV3oL6OKIMthlie92dh6RA3kf569fej7P2A5Yc/gwWd1HfpSu1TaPJDd/uLBc6X9avto+T+xTAjJuJGfXtRmxs7RobZk/4M+iI35cX+lA/Qfbpt8Z9LeuX964ACf9UhSv+rvgjzdGd4+kc9/+RVY3uKp3vbUgfRi+c3vdXV+xfQnfcO59wil0MZ0tvVmJ8+p/QSasp56osOsFs0nJqQg0EfFJAtAEFZE4/9BJJHmiIFQBB72gNpB80wgZJYOhtQCGbhDACiTA0hEQCDA2hkPyaTByMRiDoVdwH7Kr++6ZKE4qpHiSEwlwCaT+9qhWQ9dNHswYQ6DVsAAWgEbbAHUciLO+Zam07pXvjUab8NBXo0bWf1fkjDVa/kvov0B9V81b2bfc91UTxtVyKYljEhJ1h2mmmnWLaSZ6dQM0+JWbFtLtzQwpWdbDRzg032HCNDVfYcAkNF9BoyTtPmC2G6T6Duc9g7jOY+wzmPoO5zzy6L9gX521TZlhhc9xtYJTKwQMz42FN0Uxva8zbGvO2xrytMW/rJ29n+U+zvK4fvQ5YYRti+h4OX4pJGYVRRmGUURhlFEYZxaOMYlFGsSijHikDWGGnBjNGMhkjMcZIjDHyiTFZJyafmIOYSZaZYFnx5uJtjHeKmKvQBF3waCcg1okn0uXsX7C4J1jUEyzmCQ7xBId3gkM7wWGdQEgnWJxjSh2mdJjQ8XSOJ3M8lWOJHEvjWBLHUjhI4Hj6xkzEsDwMS8OwLAxLwng5GCsFY2VgrAQMyr946RezxMMqPKzAw+o7rLzjVXes4o5V20GlHa+y4xV2zMYP1vfB2j5Y1wdr+mA9H1bLB+r4GFa7jtf2YbZosQ4t1qDF+rNYexbrzkLNWV5vlteaZT6nYD6mYD6lYD6kYD6jyHlE8W0xvmewu3vZczG89mfb9N1v6fObDf0Vc7VZK7WRW7FWl8tPSpikDA=="
	
	,probability = 50
	,remoteness_min = 15
	,force = "player"
	,unique = true	
	,random_direction = false
	
	,minable = false
	,operable = false
	,rotatable = false
	
	
	,areadata = {
		dissalowed_recipes = {
			"hidden-electric-energy-interface",
			"electric-energy-interface",
			"infinity-chest",
			"player-port",
			"railgun",
			"railgun-dart",
			"small-plane",
			"electric-energy-interface",
			"express-loader",
			"fast-loader",
			"loader"
		}
	}
	
	,ScriptForEach = function(rndroll, game, surface, force, area, center, entity, namelist, locstore, areadata)
		
		if entity and entity.valid and entity.prototype.name ~= 'steel-chest' then entity.force = 'neutral'
		elseif entity and entity.valid then areadata.player_force = entity.force end
		
		local function _data(ent) return {
			entity=entity,
			position=entity.position,
			direction=entity.direction
		} end
		
		if entity and entity.valid and entity.prototype.name == "steel-chest" then
			entity.operable = true
			areadata.chest_buffer = _data(entity)
		
		elseif entity and entity.valid and entity.prototype.name == "iron-chest" then
			if entity.position.x > center.x then 
				areadata.chest_in = _data(entity)
			else
				areadata.chest_out = _data(entity)
			end
		
		elseif entity and entity.valid and entity.prototype.name == "stack-inserter" then
			areadata.inserter = _data(entity)
			entity.inserter_stack_size_override = 20
			
		elseif entity and entity.valid and entity.prototype.name == "constant-combinator" then
			if entity.position.x > center.x then 
				areadata.const_right = _data(entity)
			else
				areadata.const_left = _data(entity)
			end
			
		elseif entity and entity.valid and entity.prototype.name == "decider-combinator" then
			areadata.decider = _data(entity)
			areadata.decider.conditions = {comparator = "=", output_signal = {type="virtual", name="signal-ex"}}
			
			
		elseif entity and entity.valid and entity.prototype.name == "lab" then
			areadata.lab = _data(entity)
			entity.active = false
			
		end
		
	end
	
	,ScriptForAll = function(rndroll, game, surface, force, area, center, namelist, entitylist, areadata, locstore)
		
		areadata.area = area
		areadata.force = force
		areadata.surface = surface
		
		areadata.inserter.entity.pickup_position = areadata.chest_buffer.entity.position
		areadata.inserter.entity.drop_position = areadata.chest_in.entity.position
		
	end
	
	,Events = {
		
		[defines.events.on_tick] = function(event, ad, game)
			
			if ad.done then
				ad.disabled = true
			end
			
			local function BlowItUp()
				for _,ent in pairs(ad.surface.find_entities_filtered{name={'stone-wall','solar-panel','medium-electric-pole','constant-combinator','iron-chest','decider-combinator','filter-inserter','steel-chest','lab'}, area=Area.shrink(ad.area, 1)}) do
					ent.destroy()
				end
				if ad.tag and ad.tag.valid then ad.tag.destroy() end
				ad.done = true
			end
			
			local function IntegrityCheck(type)
				
				if not type or type == 'const' then
					if not ad.const_right.entity or not ad.const_right.entity.valid then
						ad.const_right.entity = ad.surface.find_entities_filtered{name='constant-combinator', position=ad.const_right.position, limit=1}
						if not ad.const_right.entity or not ad.const_right.entity.valid then
							BlowItUp()
							return false
						end
					end
					if not ad.const_left.entity or not ad.const_left.entity.valid then
						ad.const_left.entity = ad.surface.find_entities_filtered{name='constant-combinator', position=ad.const_left.position, limit=1}
						if not ad.const_left.entity or not ad.const_left.entity.valid then
							BlowItUp()
							return false
						end
					end
				if type and type == 'const' then return true end end
				
				if not type or type == 'chest' then
					if not ad.chest_buffer.entity or not ad.chest_buffer.entity.valid then
						ad.chest_buffer.entity = ad.surface.find_entities_filtered{name='steel-chest', position=ad.chest_buffer.position, limit=1}
						if not ad.chest_buffer.entity or not ad.chest_buffer.entity.valid then
							BlowItUp()
							return false
						end
					end
					if not ad.chest_in.entity or not ad.chest_in.entity.valid then
						ad.chest_in.entity = ad.surface.find_entities_filtered{name='iron-chest', position=ad.chest_in.position, limit=1}
						if not ad.chest_in.entity or not ad.chest_in.entity.valid then
							BlowItUp()
							return false
						end
					end
					if not ad.chest_out.entity or not ad.chest_out.entity.valid then
						ad.chest_out.entity = ad.surface.find_entities_filtered{name='iron-chest', position=ad.chest_out.position, limit=1}
						if not ad.chest_out.entity or not ad.chest_out.entity.valid then
							BlowItUp()
							return false
						end
					end
					if not ad.inserter.entity or not ad.inserter.entity.valid then
						ad.inserter.entity = ad.surface.find_entities_filtered{name='stack-inserter', position=ad.inserter.position, limit=1}
						if not ad.inserter.entity or not ad.inserter.entity.valid then
							BlowItUp()
							return false
						end
					end
				if type and type == 'chest' then return true end end
				
				if not type or type == 'decider' then
					if not ad.decider.entity or not ad.decider.entity.valid then
						ad.decider.entity = ad.surface.find_entities_filtered{name='decider-combinator', position=ad.decider.position, limit=1}
						if not ad.decider.entity or not ad.decider.entity.valid then
							BlowItUp()
							return false
						end
					end
				if type and type == 'decider' then return true end end
				
				if not ad.lab.entity or not ad.lab.entity.valid then
					ad.lab.entity = ad.surface.find_entities_filtered{name='lab', position=ad.lab.position, limit=1}
					if not ad.lab.entity or not ad.lab.entity.valid then
						BlowItUp()
						return false
					end
				end
				
				return true
			end
			
			local function SetBehaviour()
			
				ad.decider.entity.destroy()
				ad.decider.entity = ad.surface.create_entity{
					name='decider-combinator',
					position=ad.decider.position,
					direction=ad.decider.direction,
					force='neutral',
					control_behavior = {
						decider_conditions = ad.decider.conditions
					}
				}
				
				ad.decider.entity.minable = false
				ad.decider.entity.operable = false
				ad.decider.entity.rotatable = false
				
				if not ad.tag then
					ad.tag = game.forces[ad.force].add_chart_tag(ad.surface, {
						icon = ad.decider.conditions.output_signal,
						position = Position.offset(ad.decider.position, 0, 1),
						text = "Inventive station"
					})
					
				elseif ad.tag and ad.tag.valid then
					ad.tag.icon = ad.decider.conditions.output_signal
				end
				
			end
			
			local function SetConCom(left,right)
				
				if IntegrityCheck("const") then
					
					ad.const_left.conditions = {count=1, index=1, signal = {type="virtual", name="signal-".. left}}
					ad.const_right.conditions = {count=1, index=1, signal = {type="virtual", name="signal-".. right}}
					
					ad.const_right.entity.destroy()
					ad.const_right.entity = ad.surface.create_entity{
						name='constant-combinator',
						position=ad.const_right.position,
						direction=ad.const_right.direction,
						force='neutral',
						control_behavior = {
							filters = { ad.const_right.conditions }
						}
					}
					ad.const_right.entity.minable = false
					ad.const_right.entity.operable = false
					ad.const_right.entity.rotatable = false
					
					ad.const_left.entity.destroy()
					ad.const_left.entity = ad.surface.create_entity{
						name='constant-combinator',
						position=ad.const_left.position,
						direction=ad.const_left.direction,
						force='neutral',
						control_behavior = {
							filters = { ad.const_left.conditions }
						}
					}
					ad.const_left.entity.minable = false
					ad.const_left.entity.operable = false
					ad.const_left.entity.rotatable = false
				end
				
			end
			
			local function ChangeBehaviour(recipe)
				
				if IntegrityCheck('decider') then
					
					if recipe == 'none' then
						ad.decider.conditions.first_signal = {}
						ad.decider.conditions.first_signal.name = ''
						ad.decider.conditions.first_signal.type = 'virtual'
						ad.decider.conditions.second_signal = {}
						ad.decider.conditions.second_signal.name = ''
						ad.decider.conditions.second_signal.type = 'virtual'
						ad.decider.conditions.output_signal.name = 'signal-red'
						ad.decider.conditions.output_signal.type = 'virtual'
						
						if ad.tag and ad.tag.valid then ad.tag.destroy() end
						ad.done = true
						SetConCom('red','red')
						
					elseif type(recipe) == 'string' then
						ad.decider.conditions.first_signal = {}
						ad.decider.conditions.first_signal.name = ''
						ad.decider.conditions.first_signal.type = 'virtual'
						ad.decider.conditions.second_signal = {}
						ad.decider.conditions.second_signal.name = ''
						ad.decider.conditions.second_signal.type = 'virtual'
						
						ad.decider.current_recipe = game.recipe_prototypes[recipe]
						if ad.decider.current_recipe then
							ad.decider.conditions.output_signal.name = ad.decider.current_recipe.products[1].name
							ad.decider.conditions.output_signal.type = ad.decider.current_recipe.products[1].type
						else
							ad.decider.current_recipe = false
							ad.decider.conditions.output_signal.name = 'signal-ex'
							ad.decider.conditions.output_signal.type = 'virtual'
						end
						
					end
					SetBehaviour()
				end
			end
			
			local function ChangeRecipe()
				
				if IntegrityCheck('chest') then
				
					SetConCom('red','yellow')
					
					ad.inserter.entity.pickup_position = ad.chest_buffer.entity.position
					ad.inserter.entity.drop_position = ad.chest_in.entity.position
					ad.inserter.entity.inserter_stack_size_override = 20
					
					ad.chest_in.entity.get_inventory(defines.inventory.chest).clear()
					
					local _recipes,next = {},false
					for _,r in pairs(game.forces[ad.force].recipes) do
						local alowed = true
						for _,dr in pairs(ad.dissalowed_recipes) do
							if dr == r.name then alowed = false end
						end
						if alowed and not r.hidden and not r.enabled
						and not r.name:find('barrel')
						and not r.name:find('bottle')
						and not r.name:find('canister')
						and not r.name:find('creative-mode') then
							next = true
							_recipes[r.name] = true
						end
					end
					
					if not next then
						ChangeBehaviour('none')
					else
						
						for _,r in pairs(game.forces[ad.force].recipes) do
							if not r.hidden and _recipes[r.name] and r.enabled then
								_recipes[r.name] = nil
							end
						end
						
						local possible_recipes = {}
						for r in pairs(_recipes) do
							table.insert(possible_recipes,r)
						end
						
						ChangeBehaviour(possible_recipes[ZADVRnd(1,#possible_recipes,game.tick)])
					
					end
					
				end
			end
			
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
			
			local function SearchInRecipe(recipe,name)
				
				if recipe.products then for _,p in pairs(recipe.products) do
					if p.name == name then return true end
				end end
				
				return false
				
			end
			
			local function CheckItems()
				
				if IntegrityCheck() then
				
					if ad.decider.current_recipe then
					
						local buffer = {}
						
						local inv_in = ad.chest_in.entity.get_inventory(defines.inventory.chest)
						
						local coins = inv_in.get_item_count('zadv_coin') or 0
						
						if inv_in.get_item_count() and inv_in.get_item_count() > 0 then
							
							SetConCom('yellow','green')
							
							for _,reagent in pairs(ad.decider.current_recipe.ingredients) do
								
								if reagent.type == 'item' then
									buffer[reagent.name] = math.floor(coins / reagent.amount); coins = coins - buffer[reagent.name]
									buffer[reagent.name] = buffer[reagent.name] + math.floor(inv_in.get_item_count(reagent.name) / reagent.amount)
								else
									local found = false
									for _,r in pairs(game.recipe_prototypes) do
										
										if not found
										and not r.name:find('barrel') and not r.name:find('bottle')
										and not r.name:find('canister') and not r.name:find('creative')
										and not r.hidden and not r.enabled
										and SearchInRecipe(r,reagent.name) then
										
											for _,i in pairs(r.ingredients) do
											
												if i.type == "item" then
													buffer[i.name] = buffer[i.name] and buffer[i.name] + i.amount or i.amount
												
												else for _,_r in pairs(game.recipe_prototypes) do
														
														if
														not found and _r.ingredients
														and (_r.products[1].name:find('barrel')
														or _r.products[1].name:find('bottle')
														or _r.products[1].name:find('canister'))
														and not _r.products[1].name:find('empty')
														then
															
															for _,_i in pairs(_r.ingredients) do
																if not found then
																	local _n = false
																	if _i.name == i.name then _n = _i.name elseif _i == i.name then _n = _i.name end
																	if _n then
																		buffer[_r.products[1].name] = math.floor(coins / (_i.amount or 50) * reagent.amount); coins = coins - buffer[_r.products[1].name]
																		buffer[_r.products[1].name] = buffer[_r.products[1].name] + math.floor(inv_in.get_item_count(_r.products[1].name) / (_i.amount or 50) * reagent.amount)
																		found = true
																	end
																end
															end
															
														end
														
												end end
												
											end
											
											found = true
										end
										
									end
								end
								
							end
							
							local total_amount = false
							for n,a in pairs(buffer) do
								if not total_amount or total_amount > a then
									total_amount = a
								end
							end
							
							if total_amount and total_amount > 0 then
								
								local name = false
								if game.item_prototypes[ad.decider.current_recipe.name] then
									name = game.item_prototypes[ad.decider.current_recipe.name].name
									
								elseif game.fluid_prototypes[ad.decider.current_recipe.name] then
									local found = false
									for _,r in pairs(game.recipe_prototypes) do
										if not found and (r.products[1].name:find('barrel') or r.products[1].name:find('canister')) then
											for _,i in pairs(r.ingredients) do
												if not found then
													local n = false
													if i.name == game.fluid_prototypes[ad.decider.current_recipe.name].name then n = i.name
													elseif i == game.fluid_prototypes[ad.decider.current_recipe.name].name then n = i.name end
													if n then name = r.products[1].name; found = true end
												end
											end
										end
									end
								end
								
								if name then
							
									SetConCom('green','green')
									
									ad.chest_in.entity.get_inventory(defines.inventory.chest).clear()
									local items = {name = name, count=total_amount}
									if ad.chest_out.entity.get_inventory(defines.inventory.chest).can_insert(items) then
									
										ad.chest_out.entity.get_inventory(defines.inventory.chest).insert(items)
										
										ad.inserter.entity.pickup_position = ad.chest_out.entity.position
										ad.inserter.entity.drop_position = ad.chest_buffer.entity.position
										ad.inserter.entity.inserter_stack_size_override = 20
										
										ad.decider.conditions.output_signal.name = 'signal-ex'
										ad.decider.conditions.output_signal.type = 'virtual'
										ChangeBehaviour()
										
										if ad.player_force and ad.player_force.valid
										and ad.player_force.recipes[ad.decider.current_recipe.name] then
											ad.player_force.recipes[ad.decider.current_recipe.name].enabled = true
										end
										
										ad.skip = true
										
										local player = FindNearestPlayer(ad.lab.entity.position)
										if player then player.force.play_sound{path="utility/game_won", position=player.position, volume_modifier=1} end
									end
									
								end
								
							end
						end
					else
						ad.done = true
						SetConCom('red','red')
					end
				end
			end
			
			
			if not ad.done then
			
				if ad.nextchange then
				
					if ad.nextchange < event.tick then
						ad.nextchange = event.tick +36000 -- 36000 = 10min 
						ad.nextcheck = event.tick +300
						ad.skip = false
						ChangeRecipe()
					
					end
					
				else ad.nextchange = event.tick end
				
				if not ad.skip and ad.nextcheck then
				
					if ad.nextcheck < event.tick then
						ad.nextcheck = event.tick +300
						CheckItems()
					end
					
				else ad.nextcheck = event.tick end
				
				if ad.nexttick then
					
					if ad.nexttick < event.tick then
					
						ad.nexttick = event.tick +60
					
						ad.decider.conditions.first_signal = {}
						ad.decider.conditions.first_signal.name = ''
						ad.decider.conditions.first_signal.type = 'virtual'
						
						ad.decider.conditions.second_signal = {}
						ad.decider.conditions.second_signal.name = ''
						ad.decider.conditions.second_signal.type = 'virtual'
						
						local left =  math.floor((ad.nextchange - event.tick)/60)
						if left <= 10 then
							ad.decider.conditions.first_signal.name = 'signal-r-'.. math.floor(left / 10)
							ad.decider.conditions.second_signal.name = 'signal-r-'.. left % 10
							ChangeBehaviour()
							
						elseif left <= 20 then
							ad.decider.conditions.first_signal.name = 'signal-y-'.. math.floor(left / 10)
							ad.decider.conditions.second_signal.name = 'signal-y-'.. left % 10
							ChangeBehaviour()
							
						elseif left <= 30 then
							ad.decider.conditions.first_signal.name = 'signal-'.. math.floor(left / 10)
							ad.decider.conditions.second_signal.name = 'signal-'.. left % 10
							ChangeBehaviour()
							
						end
					
					end
				
				else ad.nexttick = event.tick end
		
			end
			
		end
		
	}

}
end

if settings.startup["zadv_area_post"].value then
local function setExchange(left,right,p,c)
	c = c or 10
	return {left=left, right=right, p1=p, p2=p*0.8, p3=p*0.5, c1=math.floor(c*100), c2=math.floor(c*150), c3=math.floor(c*200), total=0}
end
ret.area['exchange post'] = {

	bp = "0eNqV1cFuhCAQBuBXaebMJsK6ir5K02y0JQ0JolG2XWN494L20KQjYU6KkY+fAMMGvXmoadbWQbuBfh/tAu3rBov+tJ2J39w6KWhBOzUAA9sNsbW40arLd2cMeAbafqgntNy/MVDWaafVoeyN9W4fQ6/m8APWn8E0LqHLaONogblUDNbw4IX37J8h8gyRMq5ZRpIos4jkTG55M5GHITGiyiJSQp0XgheHUWGGzDKSRJMZ43dNSsyIA+TkSBqcFARdVy4oOXDiSoqBT6WkxMCJG2l3oCvLK8ruwImaclLQbc4l4aTgQkMpXie1q6AUrxODE4rXCSEIxSsSoazv5b/9c1swMF2vwg0BL+H9S83L3rOStRCSN0UtvP8B6UITpg=="
	
	,probability = 50
	,remoteness_min = 10
	,max_copies = 10
	,nearest_copy = 50
	,ignore_technologies = true
	,progressive_remoteness = 15
	,force = "neutral"
	,minable = false
	,operable = false
	,rotatable = false
	
	,areadata = {
		areanme = "ZADV_Base-exchange post",
		variations = {
			setExchange('iron-plate',			'copper-plate',				1.0, 20),
			setExchange('copper-plate',			'iron-plate',				1.0, 20),
			setExchange('iron-plate',			'steel-plate',				0.8, 10),
			
			setExchange('transport-belt',		'fast-transport-belt',		1.0),
			setExchange('fast-transport-belt',	'express-transport-belt',	0.8),
			setExchange('transport-belt',		'express-transport-belt',	0.6),
			
			setExchange('burner-inserter',		'inserter',					1.0, 1),
			setExchange('inserter',				'fast-inserter',			0.8, 1),
			setExchange('fast-inserter',		'stack-inserter',			0.6, 1),
			setExchange('filter-inserter',		'stack-filter-inserter',	0.5, 1),
			
			setExchange('speed-module',			'speed-module-2',			1.0, 1),
			setExchange('speed-module',			'speed-module-3',			0.7, 1),
			setExchange('effectivity-module',	'effectivity-module-2',		1.0, 1),
			setExchange('effectivity-module',	'effectivity-module-3',		0.7, 1),
			setExchange('productivity-module',	'productivity-module-2',	1.0, 1),
			setExchange('productivity-module',	'productivity-module-3',	0.7, 1),
			
			setExchange('science-pack-1',		'science-pack-1',			0.8, 1),
			setExchange('science-pack-1',		'science-pack-2',			0.4, 1),
			setExchange('science-pack-2',		'science-pack-3',			0.6, 1),
			setExchange('science-pack-1',		'military-science-pack',	0.8, 1),
			setExchange('science-pack-2',		'production-science-pack',	0.7, 1),
			setExchange('science-pack-3',		'high-tech-science-pack',	0.6, 1),
			setExchange('science-pack-3',		'space-science-pack',		0.4, 0.5),
			
			setExchange('electronic-circuit',	'advanced-circuit',			0.8, 3),
			setExchange('electronic-circuit',	'processing-unit',			0.4, 1),
			setExchange('advanced-circuit',		'processing-unit',			0.5, 2),
			
			setExchange('engine-unit',			'electric-engine-unit',		0.8, 1),
			
			setExchange('water-barrel',			'crude-oil-barrel',			1.0, 3),
			setExchange('water-barrel',			'heavy-oil-barrel',			0.6, 3),
			setExchange('water-barrel',			'light-oil-barrel',			0.6, 3),
			setExchange('water-barrel',			'petroleum-gas-barrel',		0.8, 3),
			setExchange('water-barrel',			'sulfuric-acid-barrel',		0.5, 3),
			setExchange('water-barrel',			'lubricant-barrel',			0.7, 3),
			
			setExchange('firearm-magazine',		'piercing-rounds-magazine',	0.8, 2),
			setExchange('firearm-magazine',		'uranium-rounds-magazine',	0.6, 1)
		}
	}
	
	,ScriptForEach = function(rndroll, game, surface, force, area, center, entity, namelist, locstore, areadata)
		
		if entity and entity.valid and entity.prototype.name == 'stone-wall' then
			local area = Position.expand_to_area(entity.position, 1.5)
			for _,e in pairs(surface.find_entities_filtered{area=area, name={"stone-wall"}, invert=true}) do
				e.destroy()
			end
		end
		
	end
	
	,ScriptForAll = function(rndroll, game, surface, force, area, center, namelist, entitylist, areadata, locstore)
		
		areadata.surface = surface
		areadata.force = force
		areadata.inner_radius = Position.expand_to_area(center, 7)
		areadata.center = center
		areadata.outer_bp = "0eNqV1cFuhCAQBuBXaebMJsK6ir5K02y0JQ0JolG2XWN494L20KQjYU6KkY+fAMMGvXmoadbWQbuBfh/tAu3rBov+tJ2J39w6KWhBOzUAA9sNsbW40arLd2cMeAbafqgntNy/MVDWaafVoeyN9W4fQ6/m8APWn8E0LqHLaONogblUDNbw4IX37J8h8gyRMq5ZRpIos4jkTG55M5GHITGiyiJSQp0XgheHUWGGzDKSRJMZ43dNSsyIA+TkSBqcFARdVy4oOXDiSoqBT6WkxMCJG2l3oCvLK8ruwImaclLQbc4l4aTgQkMpXie1q6AUrxODE4rXCSEIxSsSoazv5b/9c1swMF2vwg0BL+H9S83L3rOStRCSN0UtvP8B6UITpg=="
		areadata.inner_bp = "0eNrNm+tu4zYQhV+l0G+rEElRlwDtixSBodhMloAsGbScNgj87pUsd21kz7A8KLDon1xk6fMZeniGN39mL/3ZHYMfpuzpM/O7cThlT398Zif/NnT9cm36OLrsKXv3YTrPVzbZ0B2WC+sdeZFdNpkf9u6v7EldnjeZGyY/ebdirv98bIfz4cWF+Yb709M4uPzPrl+Ix/E0PzIOy9vNmLzaZB/zL1VcLpsfGDqNYVZGixAmCVHEVJRJiJgIm0SINkWV1hTNymgQoqY+EYho0hB2RdQI0aYhyogKVVB5AWWoxPzUMR2J+aliOqgExTLSEjSqIi1Do41RMd0Eq0jL0GhqNExXw4i0DI3luE5L0Fhn1Yn5qW6ZUUGIplwDM9ISNK9XhoWMkrIerMNSxoEZFeVfOJaaMh/MaCjzwbG0lPlAHaZgzAfKMIoxH6xCM+aDVRjGfLCKkjEfrMIyzoFVVIx/YRU1Yz4YkZafsS5v0tIzal9lYp1Xt9QoIYQ0UgxJNNJ2ZRjIMJQZYx2ckWKGpQwdx8IZKWbUlKHjWBqKgXW0lBlDHZYbkWLGPVHfzkM+nUNwE9Lx661V5z8gRzOmjqUYqrZgRsnIgJ+MtZQMzKiY4oIjqZkShxENg8CBtEnp8W/ZURVMmYPBVIopthihGRWwPSrDFFuMKJliiwOxTKXEKiqmXmMVNVVsMSMtRWMVrkqs+bHOVqfW/FtfURCiqFKrIYMr+VgHN3fCDK7k41i4uRNmcCUfMx7ydOy7kB+7wcl1Ei6E1dwaFG7Te6KGbt8FeUEQLoIVaVFEgmgU43+wLRvNmBdGUBaKESWDwM1JWShGUBaKA6kZ+8MqEot8zLmalprywORqOQuFOlrKQbEMykCxCso/MYKyTxyIZRwHIyjzxIHUzGAYI+4JenB7fz7krne7Kfhdfhx7J7kgZrXEiFbhVfyCcLACIxRhPwJCEwghEEM4mIAoCQcTArGEgwkqKmYAJ8ioGRcUdDSM+2jMaBn7MXiPqGDMA+tI3WiqYzo0Yx8CwzBjQCGWktEhMKixqBBLxSzZCDqodXyB0XBLNmaek2+yvQ+z615fLiH1IXMPs6i87w5H0en1TNyNwxTGfvvivnXvfgzLHTsfdmc/befX9t8fe/XhNG2TN/y74WP65oe3bH2P09QtZweK5Z/DsQvdtLxV9nt2WV8f1rBOC1ktP4LbPx4N8PvFO9Tl+YJ3U++9be92fu9CPr/Pix+u7yMUJ31tUtQAN8a9Aa665DB+y5YLx4/5gfMwbV/DeNj64Xieb33t+pOjgrTL8Yi34NyAG2CT6VgDic9asfHuNvNPiNHWu2WPERrv1feTC+T5kJDbNVPOS/uq72dFzDXg5LZbPphb8i4X9EO41xtUG2mgLw/LycZsOuHe/7gzGumn//9uSudaSS1Fprnew/5uUgL/xPwt/1P+xrqz+ZrbPya/9Bkwxy2E/GWOWwiIhkDgWp64jx0bYiVuY8dGR4aZSAgqNDELEFQYYhYgqCiJWYCgwlJrECWGVNS2qwCpmXmAwGiYMbzAaJkxvMWHtApm7CwwFDN2xrGkbmWXMR2GGTsLjJIZwwsMS+wxCs1xz1MfxiHffXOnSRwuCYx7mr51kxOf/lIGNWQ1REhCq7RJIcUietjPxhGlB2QVMdDCAVlmt1AIiDkgJKhgDggJCOYgsBBIRRQqQQVzQEhQwRwQElRQB4SwjMTN7GihqrjzQRWGUActBYZhCpXAKBlzFxjUcjc+yFtRCzSCDmqBRtDREOYjyGiJbo8RiXvasUASd7RjuVEzC92CCmZ8KqgomW4vMCzT2/Ah79Tt7CrGoE6wCQzqKLDAaJme0uJz8wXRU4Sj98ymtoDQRE8RAjFETxFUMJsxAsIy6YW/8qMSt7Vv+SVBmFm+xGC+VbEwnjeZn9xhvv/+nbNN1ncvrp+v/TL//e7C6fpk1dRaN6ot6nlC+zdG1eTp"
		
		for _,e in pairs(surface.find_entities_filtered{area=areadata.inner_radius, name={"stone-wall"}, invert=true}) do
			e.destroy()
		end
		
		areadata.next_appearance = game.tick + ZADVRnd(300,108000,rndroll) -- 108000
		
	end
	
	,Events = {
		
		[defines.events.on_tick] = function(event, ad, game)
			
			ad.skip = ad.skip or 0
			if ad.skip >= 10 then
				ad.disabled = true
				return true
			end
			
			local function setNextAppearence(ticks)
				ad.next_appearance = event.tick + ZADVRnd(1,ticks or 108000,rndroll) -- 108000
			end
			
			local function BlowItUp()
				for _,ent in pairs(ad.surface.find_entities_filtered{name={'stone-wall','solar-panel','medium-electric-pole','constant-combinator','iron-chest','decider-combinator','gun-turret','gate','radar','small-lamp'}, area=ad.inner_radius}) do
					ent.destroy()
				end
				if ad.tag and ad.tag.valid then ad.tag.destroy() end
				ad.disabled = true
			end
			
			local function IntegrityCheck(type)
				
				if not type or type == 'const' then
					if not ad.const_right.entity or not ad.const_right.entity.valid then
						ad.const_right.entity = ad.surface.find_entities_filtered{name='constant-combinator', position=ad.const_right.position, limit=1}
						if not ad.const_right.entity or not ad.const_right.entity.valid then
							BlowItUp()
							return false
						end
					end
					if not ad.const_left.entity or not ad.const_left.entity.valid then
						ad.const_left.entity = ad.surface.find_entities_filtered{name='constant-combinator', position=ad.const_left.position, limit=1}
						if not ad.const_left.entity or not ad.const_left.entity.valid then
							BlowItUp()
							return false
						end
					end
				if type and type == 'const' then return true end end
				
				if not type or type == 'chest' then
					if not ad.chest_in.entity or not ad.chest_in.entity.valid then
						ad.chest_in.entity = ad.surface.find_entities_filtered{name='iron-chest', position=ad.chest_in.position, limit=1}
						if not ad.chest_in.entity or not ad.chest_in.entity.valid then
							BlowItUp()
							return false
						end
					end
					if not ad.chest_out.entity or not ad.chest_out.entity.valid then
						ad.chest_out.entity = ad.surface.find_entities_filtered{name='iron-chest', position=ad.chest_out.position, limit=1}
						if not ad.chest_out.entity or not ad.chest_out.entity.valid then
							BlowItUp()
							return false
						end
					end
				if type and type == 'chest' then return true end end
				
				if not type or type == 'decider' then
					if not ad.decider.entity or not ad.decider.entity.valid then
						ad.decider.entity = ad.surface.find_entities_filtered{name='decider-combinator', position=ad.decider.position, limit=1}
						if not ad.decider.entity or not ad.decider.entity.valid then
							BlowItUp()
							return false
						end
					end
					if not ad.lamp_left.entity or not ad.lamp_left.entity.valid then
						ad.lamp_left.entity = ad.surface.find_entities_filtered{name='small-lamp', position=ad.lamp_left.position, limit=1}
						if not ad.lamp_left.entity or not ad.lamp_left.entity.valid then
							BlowItUp()
							return false
						end
					end
					if not ad.lamp_right.entity or not ad.lamp_right.entity.valid then
						ad.lamp_right.entity = ad.surface.find_entities_filtered{name='small-lamp', position=ad.lamp_right.position, limit=1}
						if not ad.lamp_right.entity or not ad.lamp_right.entity.valid then
							BlowItUp()
							return false
						end
					end
				if type and type == 'decider' then return true end end
				
				return true
			end
			
			local function buildInner()
				
				if global.ZADV and global.ZADV.blueprint then
						
					global.ZADV.blueprint.clear_blueprint()
					global.ZADV.blueprint.import_stack(ad.inner_bp)
					if global.ZADV.blueprint.is_blueprint_setup() then
						
						for k,v in pairs(global.ZADV.blueprint.build_blueprint{
							surface=ad.surface,
							force=ad.force,
							position=ad.center,
							force_build=true,
							direction=0,
							skip_fog_of_war=false
						}) do if v.valid and not v.revive() then
						
								for _,e in pairs(ad.surface.find_entities_filtered{
									area=v.bounding_box,
									name=v.name,
									invert=true
								}) do e.destroy() end
								v.revive()
								
						end end
						
						local function _data(ent) return {
							entity=ent,
							position=ent.position,
							direction=ent.direction,
							conditions={}
						} end
						
						for _,entity in pairs(ad.surface.find_entities_filtered{area=ad.inner_radius}) do
							
							if entity and entity.valid then
								entity.minable = false
								entity.operable = false
								entity.rotatable = false
							end
						
							if entity and entity.valid and entity.prototype.name == "iron-chest" then
								entity.operable = true
								if entity.position.x < ad.center.x then 
									ad.chest_in = _data(entity)
								else
									ad.chest_out = _data(entity)
								end
								
							elseif entity and entity.valid and entity.prototype.name == "gun-turret" then
								entity.get_inventory(defines.inventory.turret_ammo).insert("uranium-rounds-magazine")
								
							elseif entity and entity.valid and entity.prototype.name == "decider-combinator" then
								ad.decider = _data(entity)
								
							elseif entity and entity.valid and entity.prototype.name == "small-lamp" then
								if entity.position.x > ad.center.x then 
									ad.lamp_right = _data(entity)
								else
									ad.lamp_left = _data(entity)
								end
								
							elseif entity and entity.valid and entity.prototype.name == "constant-combinator" then
								if entity.position.x > ad.center.x then 
									ad.const_right = _data(entity)
								else
									ad.const_left = _data(entity)
								end
								
							end
							
						end
						
						if ad.chest_in and ad.chest_out and ad.decider and ad.const_right and ad.const_left then return true end
						
					else
						ad.disabled = true
						global.ZADV.blueprint.clear_blueprint()
					end
					
				end
				
				return false
			end
			
			local function buildOuter()
			
				if global.ZADV and global.ZADV.blueprint then
						
					global.ZADV.blueprint.clear_blueprint()
					global.ZADV.blueprint.import_stack(ad.outer_bp)
					if global.ZADV.blueprint.is_blueprint_setup() then
						
						for k,v in pairs(global.ZADV.blueprint.build_blueprint{
							surface=ad.surface,
							force=ad.force,
							position=ad.center,
							force_build=true,
							direction=0,
							skip_fog_of_war=false
						}) do if v.valid and not v.revive() then
						
								for _,e in pairs(ad.surface.find_entities_filtered{
									area=v.bounding_box,
									name=v.name,
									invert=true
								}) do e.destroy() end
								v.revive()
								
						end end
						
						return true
						
					else
						ad.disabled = true
						global.ZADV.blueprint.clear_blueprint()
					end
					
				end
				
				return false
				
			end
			
			local function destroyOuter()
				
				for _,ent in pairs(ad.surface.find_entities_filtered{name={'stone-wall'}, area=Area.expand(ad.inner_radius,4)}) do
					ent.destroy()
				end
				
				if buildInner() then return true
				else return false end
				
			end
			
			local function destroyInner()
				
				for _,ent in pairs(ad.surface.find_entities_filtered{name={'stone-wall','solar-panel','medium-electric-pole','constant-combinator','iron-chest','decider-combinator','gun-turret','gate','radar','small-lamp'}, area=Area.expand(ad.inner_radius,5)}) do
					ent.destroy()
				end
				
				if ad.tag and ad.tag.valid then
					ad.tag.destroy()
				end
				
				if buildOuter() then return true
				else return false end
				
			end
			
			local function SetBehaviour()
			
				ad.decider.entity.destroy()
				ad.decider.entity = ad.surface.create_entity{
					name='decider-combinator',
					position=ad.decider.position,
					direction=ad.decider.direction,
					force='neutral',
					control_behavior = {
						decider_conditions = ad.decider.conditions
					}
				}
				
				ad.decider.entity.connect_neighbour({ wire = defines.wire_type.red, target_entity = ad.const_left.entity, source_circuit_id = 2 })
				ad.decider.entity.connect_neighbour({ wire = defines.wire_type.red, target_entity = ad.const_right.entity, source_circuit_id = 1 })
				ad.decider.entity.connect_neighbour({ wire = defines.wire_type.green, target_entity = ad.const_left.entity, source_circuit_id = 1 })
				ad.decider.entity.connect_neighbour({ wire = defines.wire_type.green, target_entity = ad.const_right.entity, source_circuit_id = 2 })
				ad.decider.entity.minable = false
				ad.decider.entity.operable = false
				ad.decider.entity.rotatable = false
				
				local icon = ad.decider.conditions.output_signal or {name='signal-ex',type='virtual'}
				if not ad.tag or (ad.tag and not ad.tag.valid) then
					ad.tag = game.forces['player'].add_chart_tag(ad.surface, {
						icon = icon,
						position = Position.offset(ad.decider.position, 0, 1),
						text = "Exchange post"
					})
					
				elseif ad.tag and ad.tag.valid then
					ad.tag.icon = icon
				end
				
			end
			
			local function SetConCom(left,right)
				
				if IntegrityCheck("const") then
				
					right = { type = 'virtual', name = right }
					right.type = game.item_prototypes[right.name] and 'item' or right.type
					right.type = game.fluid_prototypes[right.name] and 'fluid' or right.type
					
					ad.const_right.conditions = {count=1, index=1, signal = right}
					
					ad.const_right.entity.destroy()
					ad.const_right.entity = ad.surface.create_entity{
						name='constant-combinator',
						position=ad.const_right.position,
						direction=ad.const_right.direction,
						force='neutral',
						control_behavior = {
							filters = { ad.const_right.conditions }
						},
						connections
					}
					
					ad.const_right.entity.connect_neighbour({ wire = defines.wire_type.green, target_entity = ad.lamp_right.entity})
					ad.const_right.entity.connect_neighbour({ wire = defines.wire_type.red, target_entity = ad.decider.entity, target_circuit_id = 2 })
					ad.const_right.entity.connect_neighbour({ wire = defines.wire_type.red, target_entity = ad.decider.entity, target_circuit_id = 1 })
					ad.const_right.entity.minable = false
					ad.const_right.entity.operable = false
					ad.const_right.entity.rotatable = false
					
					
					left = { type = 'virtual', name = left }
					left.type = game.item_prototypes[left.name] and 'item' or left.type
					left.type = game.fluid_prototypes[left.name] and 'fluid' or left.type
					
					ad.const_left.conditions = {count=1, index=1, signal = left}
					
					ad.const_left.entity.destroy()
					ad.const_left.entity = ad.surface.create_entity{
						name='constant-combinator',
						position=ad.const_left.position,
						direction=ad.const_left.direction,
						force='neutral',
						control_behavior = {
							filters = { ad.const_left.conditions }
						}
					}
					
					ad.const_left.entity.connect_neighbour({ wire = defines.wire_type.red, target_entity = ad.lamp_left.entity})
					ad.const_left.entity.connect_neighbour({ wire = defines.wire_type.green, target_entity = ad.decider.entity, target_circuit_id = 1 })
					ad.const_left.entity.connect_neighbour({ wire = defines.wire_type.red, target_entity = ad.decider.entity, target_circuit_id = 2 })
					ad.const_left.entity.minable = false
					ad.const_left.entity.operable = false
					ad.const_left.entity.rotatable = false
				end
				
			end
			
			local function UpdatePrice()
				
				ad.decider.conditions.output_signal = {}
				ad.decider.conditions.output_signal.type = 'virtual'
				ad.decider.conditions.output_signal.name = ''
				
				if ad.current_price.total >= ad.current_price.c3 then
					ad.current_price.price = 0
					ad.decider.conditions.output_signal.name = 'signal-red'
					
				elseif ad.current_price.total >= ad.current_price.c2 then
					ad.current_price.price = ad.current_price.p3
					ad.decider.conditions.output_signal.name = 'signal-yellow'
				
				elseif ad.current_price.total >= ad.current_price.c1 then
					ad.current_price.price = ad.current_price.p2
					ad.decider.conditions.output_signal.name = 'signal-green'
					
				else
					ad.current_price.price = ad.current_price.p1
					ad.decider.conditions.output_signal.name = 'signal-cyan'
					
				end
				
				SetBehaviour()
				
			end
			
			local function CheckItems()
				
				if IntegrityCheck('chest') then

					local inv_in = ad.chest_in.entity.get_inventory(defines.inventory.chest)
					
					if inv_in.get_item_count() and inv_in.get_item_count() > 0 then
						
						local content = inv_in.get_contents()
						
						if content then
							
							local playsound = false
							local function _do(cur)
								if content[cur] and content[cur] * ad.current_price.price >= 1 then
							
									local amount = math.floor(content[cur] * ad.current_price.price)
									inv_in.remove({name = cur, count = amount * (2-ad.current_price.price)})
									
									local inv_out = ad.chest_out.entity.get_inventory(defines.inventory.chest)
									inv_out.insert({name = ad.current_price.right, count = amount})
									
									ad.current_price.total = ad.current_price.total + amount
									UpdatePrice()
									playsound = true
									
								end
							end
							
							_do('zadv_coin'); _do(ad.current_price.left)
							
							if playsound then
								game.forces['player'].play_sound{path="utility/new_objective", position=ad.decider.position, volume_modifier=1}
							end
							
						end
						
					end
				end
				
			end
			
			
			if ad.working and global.ZADV.exchangelock == ad.exchangelock then
				
				if ad.working_end then
					
					if ad.working_end > event.tick then
						
						if not ad.current_price then
							
							ad.current_price = ad.variations[ZADVRnd(1,1000,rndroll) % #ad.variations + 1]
							SetConCom(ad.current_price.left,ad.current_price.right)
							UpdatePrice()
							
						end
						
						if ad.nextcheck then
				
							if ad.nextcheck < event.tick then
								ad.nextcheck = event.tick +60
								CheckItems()
							end
							
						else ad.nextcheck = event.tick end
						
						if ad.nexttick then
							
							if ad.nexttick < event.tick then
					
								ad.nexttick = event.tick +60
							
								ad.decider.conditions.first_signal = {}
								ad.decider.conditions.first_signal.name = ''
								ad.decider.conditions.first_signal.type = 'virtual'
								
								ad.decider.conditions.second_signal = {}
								ad.decider.conditions.second_signal.name = ''
								ad.decider.conditions.second_signal.type = 'virtual'
								
								local left =  math.floor((ad.working_end - event.tick)/60)
								if left <= 10 then
									ad.decider.conditions.first_signal.name = 'signal-r-'.. math.floor(left / 10)
									ad.decider.conditions.second_signal.name = 'signal-r-'.. left % 10
									game.forces['player'].play_sound{path="utility/alert_construction", position=ad.decider.position, volume_modifier= (1-(left/20)) }
									SetBehaviour()
									
								elseif left <= 20 then
									ad.decider.conditions.first_signal.name = 'signal-y-'.. math.floor(left / 10)
									ad.decider.conditions.second_signal.name = 'signal-y-'.. left % 10
									game.forces['player'].play_sound{path="utility/alert_construction", position=ad.decider.position, volume_modifier= (1-(left/20)) }
									SetBehaviour()
									
								elseif left <= 30 then
									ad.decider.conditions.first_signal.name = 'signal-'.. math.floor(left / 10)
									ad.decider.conditions.second_signal.name = 'signal-'.. left % 10
									SetBehaviour()
									
								end
							
							end
							
						else ad.nexttick = event.tick end
						
					else
						ad.working = false
						ad.nexttick = false
						ad.nextcheck = false
						ad.working_end = false
						ad.current_price = false
						global.ZADV.exchangelock = false
						destroyInner()
						setNextAppearence()
					end
					
				else ad.working_end = event.tick + 36000 end -- 36000
				
			elseif ad.next_appearance then
				
				if ad.next_appearance < event.tick and not global.ZADV.exchangelock then
				
					local allowed = true
					local cnt = ad.surface.count_entities_filtered{area=ad.inner_radius, name={"stone-wall"}, invert=true}
					if cnt and cnt > 0
					then allowed = false end
					if 22 > ad.surface.count_entities_filtered{area=Area.expand(ad.inner_radius,6), name={"stone-wall"}}
					then
						allowed = false
						ad.skip = ad.skip + 9
					end
					
					if allowed and destroyOuter() then
						global.ZADV.exchangelock = event.tick
						ad.exchangelock = event.tick
						ad.working = true
					else
						ad.skip = ad.skip + 1
						setNextAppearence(1800)
					end
				
				else
					setNextAppearence()
				end
			
			else setNextAppearence() end
			
			
		end
		
	}
}
end

if settings.startup["zadv_area_race"].value then
ret.area['Autodrome'] = {

	bp = "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"
	
	,probability = 50
	,remoteness_min = 10
	,remoteness_max = 50
	,max_copies = 1
	,ignore_technologies = true
	,force = "player"
	,only_freeplay = true
	
	,areadata = {
		cones = {{-22,-62},{-20,-62},{-18,-62},{-16,-62},{-14,-62},{-12,-62},{14,-62},{16,-63},{18,-63},{20,-63},{22,-63},{24,-63},{26,-63},{28,-63},{30,-63},{32,-63},{34,-63},{36,-63},{38,-63},{40,-63},{42,-63},{44,-63},{46,-63},{48,-63},{50,-63},{52,-63},{54,-63},{56,-63},{58,-63},{60,-63},{62,-63},{64,-63},{66,-63},{68,-63},{70,-63},{72,-63},{74,-63},{76,-62},{-26,-60},{-24,-61},{-10,-61},{-8,-60},{10,-60},{12,-61},{78,-61},{80,-60},{-30,-58},{-28,-59},{-7,-59},{-6,-58},{8,-58},{9,-59},{82,-59},{84,-58},{-34,-56},{-32,-57},{-5,-56},{6,-56},{7,-57},{85,-57},{86,-56},{-74,-54},{-72,-54},{-70,-54},{-68,-54},{-66,-54},{-64,-54},{-62,-54},{-60,-54},{-58,-54},{-56,-54},{-54,-54},{-52,-54},{-50,-54},{-48,-54},{-46,-54},{-44,-54},{-42,-54},{-40,-54},{-38,-54},{-36,-55},{-4,-54},{5,-55},{87,-55},{88,-54},{-78,-52},{-76,-53},{-3,-52},{4,-53},{89,-52},{-82,-50},{-80,-51},{-2,-50},{3,-51},{29,-50},{31,-51},{33,-51},{35,-51},{37,-51},{39,-51},{41,-51},{43,-51},{45,-51},{47,-51},{49,-51},{51,-51},{53,-51},{55,-51},{57,-51},{59,-51},{61,-51},{63,-51},{65,-50},{90,-50},{-83,-49},{-84,-48},{-2,-48},{2,-49},{25,-48},{27,-49},{67,-49},{69,-48},{91,-48},{-86,-46},{-85,-47},{-24,-46},{-22,-47},{-20,-47},{-18,-47},{-16,-46},{-2,-46},{1,-47},{23,-46},{24,-47},{70,-47},{71,-46},{92,-46},{-88,-44},{-87,-45},{-64,-44},{-62,-44},{-60,-44},{-58,-44},{-56,-44},{-54,-44},{-52,-44},{-50,-44},{-48,-44},{-46,-44},{-44,-44},{-42,-44},{-40,-44},{-38,-44},{-36,-44},{-34,-44},{-32,-44},{-30,-44},{-28,-44},{-26,-45},{-15,-45},{-2,-44},{1,-45},{22,-45},{72,-45},{73,-44},{93,-44},{-90,-42},{-89,-43},{-68,-42},{-66,-43},{-14,-43},{-2,-42},{1,-43},{21,-43},{74,-43},{75,-42},{94,-42},{-91,-41},{-72,-40},{-70,-41},{-14,-41},{-2,-40},{1,-41},{20,-41},{76,-41},{94,-40},{-92,-39},{-74,-38},{-73,-39},{-14,-39},{-2,-38},{1,-39},{20,-39},{77,-39},{94,-38},{-93,-37},{-76,-36},{-75,-37},{-66,-36},{-64,-36},{-62,-36},{-60,-36},{-58,-36},{-56,-36},{-54,-36},{-52,-36},{-50,-36},{-48,-36},{-46,-36},{-44,-36},{-42,-36},{-40,-36},{-38,-36},{-36,-36},{-34,-36},{-32,-36},{-30,-36},{-28,-36},{-14,-37},{-2,-36},{1,-37},{20,-37},{78,-37},{94,-36},{-94,-35},{-77,-34},{-70,-34},{-68,-35},{-26,-35},{-24,-34},{-16,-34},{-15,-35},{-2,-34},{1,-35},{21,-35},{79,-35},{94,-34},{-95,-33},{-78,-32},{-71,-33},{-72,-32},{-22,-33},{-20,-33},{-18,-33},{-2,-32},{1,-33},{22,-33},{23,-32},{58,-32},{60,-32},{62,-32},{64,-32},{66,-32},{79,-33},{94,-32},{-95,-31},{-79,-30},{-74,-30},{-73,-31},{-2,-30},{1,-31},{24,-31},{26,-30},{54,-30},{56,-31},{68,-31},{70,-30},{79,-31},{94,-30},{-95,-29},{-80,-28},{-75,-29},{-3,-28},{2,-29},{28,-29},{30,-29},{32,-29},{34,-29},{36,-29},{38,-29},{40,-29},{42,-29},{44,-29},{46,-29},{48,-29},{50,-29},{52,-29},{71,-29},{72,-28},{79,-29},{94,-28},{-95,-27},{-80,-26},{-76,-27},{-4,-26},{3,-27},{4,-26},{73,-27},{74,-26},{79,-27},{94,-26},{-95,-25},{-80,-24},{-77,-25},{-54,-24},{-52,-24},{-50,-24},{-48,-24},{-46,-24},{-44,-24},{-42,-24},{-40,-24},{-38,-24},{-36,-24},{-34,-24},{-32,-24},{-5,-24},{5,-25},{6,-24},{75,-24},{79,-25},{94,-24},{-95,-23},{-80,-22},{-77,-23},{-57,-22},{-56,-23},{-30,-23},{-28,-22},{-7,-22},{-6,-23},{7,-23},{8,-22},{76,-22},{79,-23},{94,-22},{-95,-21},{-80,-20},{-77,-21},{-58,-20},{-26,-21},{-24,-20},{-22,-20},{-20,-20},{-18,-20},{-16,-20},{-14,-20},{-12,-20},{-10,-20},{-8,-21},{-3,-20},{-1,-20},{1,-20},{9,-21},{10,-20},{77,-20},{79,-21},{94,-20},{-95,-19},{-80,-18},{-77,-19},{-58,-18},{-7,-18},{-5,-19},{3,-19},{5,-18},{11,-19},{13,-18},{55,-18},{57,-19},{59,-19},{61,-19},{62,-18},{77,-18},{79,-19},{94,-18},{-95,-17},{-80,-16},{-77,-17},{-57,-16},{-10,-16},{-9,-17},{6,-17},{7,-16},{15,-17},{17,-17},{19,-17},{21,-17},{23,-17},{25,-17},{27,-17},{29,-17},{31,-17},{33,-17},{35,-17},{37,-17},{39,-17},{41,-17},{43,-17},{45,-17},{47,-17},{49,-17},{51,-17},{53,-17},{63,-17},{77,-16},{79,-17},{94,-16},{-95,-15},{-80,-14},{-76,-15},{-56,-15},{-54,-14},{-52,-14},{-50,-14},{-48,-14},{-46,-14},{-44,-14},{-42,-14},{-40,-14},{-38,-14},{-36,-14},{-34,-14},{-32,-14},{-30,-14},{-12,-14},{-11,-15},{9,-15},{11,-14},{64,-15},{77,-14},{79,-15},{94,-14},{-95,-13},{-80,-12},{-75,-13},{-28,-13},{-26,-12},{-14,-12},{-13,-13},{13,-13},{15,-12},{64,-13},{77,-12},{79,-13},{94,-12},{-95,-11},{-80,-10},{-74,-11},{-73,-10},{-24,-11},{-22,-10},{-20,-10},{-18,-10},{-16,-11},{17,-11},{19,-11},{21,-11},{23,-11},{25,-11},{27,-11},{29,-11},{31,-11},{33,-11},{35,-11},{37,-11},{39,-11},{41,-11},{43,-11},{45,-11},{47,-11},{49,-11},{51,-11},{53,-11},{55,-11},{57,-10},{59,-10},{61,-10},{63,-11},{77,-10},{79,-11},{94,-10},{-95,-9},{-80,-8},{-72,-9},{-71,-8},{-3,-8},{-1,-8},{1,-8},{77,-8},{79,-9},{94,-8},{-95,-7},{-80,-6},{-70,-7},{-69,-6},{-6,-6},{-5,-7},{3,-7},{4,-6},{77,-6},{79,-7},{94,-6},{-95,-5},{-80,-4},{-67,-5},{-65,-4},{-63,-4},{-61,-4},{-59,-4},{-57,-4},{-55,-4},{-53,-4},{-51,-4},{-49,-4},{-47,-4},{-45,-4},{-43,-4},{-41,-4},{-39,-4},{-37,-4},{-35,-4},{-33,-4},{-31,-4},{-8,-4},{-7,-5},{5,-5},{6,-4},{76,-4},{79,-5},{94,-4},{-95,-3},{-80,-2},{-68,-2},{-66,-2},{-64,-2},{-62,-2},{-60,-2},{-58,-2},{-56,-2},{-54,-2},{-52,-2},{-50,-2},{-48,-2},{-46,-2},{-44,-2},{-42,-2},{-40,-2},{-38,-2},{-36,-2},{-34,-2},{-29,-3},{-27,-2},{-11,-2},{-9,-3},{7,-3},{9,-2},{75,-2},{79,-3},{94,-2},{-95,-1},{-80,0},{-72,0},{-70,-1},{-32,-1},{-30,0},{-25,-1},{-23,0},{-21,0},{-19,0},{-17,0},{-15,0},{-13,-1},{11,-1},{13,0},{15,0},{17,0},{19,0},{73,0},{74,-1},{79,-1},{94,0},{-95,1},{-80,2},{-74,2},{-73,1},{-28,1},{-26,2},{21,1},{23,1},{25,1},{27,1},{29,1},{31,2},{33,2},{35,2},{37,2},{39,2},{41,2},{43,2},{45,2},{47,2},{49,2},{51,2},{53,2},{55,2},{57,2},{59,2},{61,2},{63,2},{65,2},{67,2},{69,2},{71,1},{79,1},{94,2},{-95,3},{-80,4},{-75,3},{-24,3},{-22,3},{-20,3},{-18,3},{-16,3},{-14,3},{-12,3},{10,3},{12,3},{14,3},{16,4},{18,4},{20,4},{22,4},{24,4},{79,3},{94,4},{-95,5},{-80,6},{-76,5},{26,5},{28,5},{30,5},{32,5},{34,5},{36,5},{38,5},{40,5},{42,5},{44,5},{46,5},{48,5},{50,5},{52,5},{54,5},{56,5},{58,5},{60,5},{62,5},{64,5},{66,6},{79,5},{94,6},{-95,7},{-80,8},{-77,7},{68,7},{69,8},{79,7},{94,8},{-95,9},{-80,10},{-78,9},{-61,10},{-59,10},{70,9},{71,10},{79,9},{94,10},{-95,11},{-80,12},{-78,11},{-64,12},{-63,11},{-57,11},{-56,12},{72,11},{73,12},{79,11},{94,12},{-95,13},{-80,14},{-78,13},{-65,14},{-55,13},{-54,14},{74,14},{79,13},{94,14},{-95,15},{-80,16},{-78,15},{-65,16},{-52,15},{-50,16},{-48,16},{-46,16},{-44,16},{-42,16},{-40,16},{-38,16},{-36,16},{-34,16},{-32,16},{-30,16},{-28,16},{-26,16},{-24,16},{-22,16},{-20,16},{-18,16},{-16,16},{16,16},{18,16},{20,16},{22,16},{24,16},{26,15},{28,15},{30,15},{32,15},{34,15},{36,15},{38,15},{40,15},{42,15},{44,15},{46,15},{48,15},{50,15},{52,15},{54,15},{55,16},{75,16},{79,15},{94,16},{-95,17},{-80,18},{-78,17},{-64,18},{-53,18},{-51,18},{-49,18},{-47,18},{-45,18},{-43,18},{-41,18},{-39,18},{-37,18},{-35,18},{-33,18},{-31,18},{-29,18},{-27,18},{-25,18},{-23,18},{-21,18},{-19,18},{-17,18},{-14,17},{-12,17},{10,17},{12,17},{14,17},{56,17},{76,18},{79,17},{94,18},{-95,19},{-80,20},{-78,19},{-63,19},{-61,20},{-59,20},{-57,20},{-55,19},{-15,19},{-13,20},{57,19},{76,20},{79,19},{94,20},{-95,21},{-80,22},{-78,21},{-11,21},{-10,22},{8,22},{10,21},{12,21},{14,21},{16,21},{18,21},{20,21},{22,22},{57,21},{76,22},{79,21},{94,22},{-95,23},{-80,24},{-77,23},{-9,23},{-8,24},{5,24},{6,23},{24,23},{26,24},{55,24},{56,23},{76,24},{79,23},{94,24},{-95,25},{-80,26},{-76,25},{-7,25},{-6,26},{4,25},{28,25},{30,26},{32,26},{34,26},{36,26},{38,26},{40,26},{42,26},{44,26},{46,26},{48,26},{50,26},{52,26},{54,25},{76,26},{79,25},{94,26},{-95,27},{-80,28},{-75,27},{-74,28},{-5,27},{-4,28},{3,27},{75,28},{79,27},{94,28},{-95,29},{-80,30},{-73,29},{-72,30},{-54,30},{-52,30},{-50,30},{-48,30},{-46,30},{-44,30},{-42,30},{-40,30},{-38,30},{-36,30},{-34,30},{-32,30},{-30,30},{-3,30},{2,29},{74,30},{79,29},{94,30},{-95,31},{-80,32},{-70,31},{-68,32},{-58,32},{-56,31},{-28,31},{-26,32},{-2,32},{1,31},{72,32},{73,31},{78,31},{94,32},{-95,33},{-80,34},{-66,33},{-64,33},{-62,33},{-60,33},{-24,33},{-23,34},{-2,34},{1,33},{17,34},{19,34},{21,34},{70,34},{71,33},{77,33},{94,34},{-95,35},{-80,36},{-22,36},{-2,36},{1,35},{14,36},{15,35},{23,35},{25,36},{67,36},{69,35},{76,35},{93,36},{-95,37},{-79,38},{-21,38},{-2,38},{1,37},{13,38},{27,37},{29,38},{31,38},{33,38},{35,38},{37,38},{39,38},{41,38},{43,38},{45,38},{47,38},{49,38},{51,38},{53,38},{55,38},{57,38},{59,38},{61,38},{63,38},{65,37},{74,38},{75,37},{92,38},{-95,39},{-78,40},{-21,40},{-2,40},{1,39},{13,40},{72,40},{73,39},{91,40},{-95,41},{-77,42},{-21,42},{-2,42},{1,41},{13,42},{70,42},{71,41},{90,42},{-95,43},{-76,43},{-75,44},{-22,44},{-2,44},{1,43},{13,44},{67,44},{69,43},{88,44},{89,43},{-94,45},{-74,45},{-73,46},{-23,46},{-2,46},{1,45},{14,46},{25,46},{27,45},{29,45},{31,45},{33,45},{35,45},{37,45},{39,45},{41,45},{43,45},{45,45},{47,45},{49,45},{51,45},{53,45},{55,45},{57,45},{59,45},{61,45},{63,45},{65,45},{86,46},{87,45},{-93,47},{-72,47},{-71,48},{-25,48},{-24,47},{-2,48},{1,47},{15,47},{17,48},{19,48},{21,48},{23,47},{84,48},{85,47},{-92,49},{-69,49},{-67,50},{-29,50},{-27,49},{-3,50},{1,49},{82,50},{83,49},{-91,51},{-65,51},{-63,52},{-61,52},{-59,52},{-57,52},{-55,52},{-53,52},{-51,52},{-49,52},{-47,52},{-45,52},{-43,52},{-41,52},{-39,52},{-37,52},{-35,52},{-33,52},{-31,51},{-4,52},{1,51},{79,52},{81,51},{-90,53},{-5,54},{2,53},{75,54},{77,53},{-89,55},{-88,56},{-6,56},{3,55},{35,56},{37,55},{39,55},{41,55},{43,55},{45,55},{47,55},{49,55},{51,55},{53,55},{55,55},{57,55},{59,55},{61,55},{63,55},{65,55},{67,55},{69,55},{71,55},{73,55},{-87,57},{-86,58},{-8,58},{-7,57},{4,57},{31,58},{33,57},{-84,59},{-82,60},{-10,60},{-9,59},{5,59},{6,60},{27,60},{29,59},{-80,61},{-78,62},{-12,62},{-11,61},{7,61},{9,62},{23,62},{25,61},{-76,63},{-74,63},{-72,63},{-70,63},{-68,63},{-66,63},{-64,63},{-62,63},{-60,63},{-58,63},{-56,63},{-54,63},{-52,63},{-50,63},{-48,63},{-46,63},{-44,63},{-42,63},{-40,63},{-38,63},{-36,63},{-34,63},{-32,63},{-30,63},{-28,63},{-26,63},{-24,63},{-22,63},{-20,63},{-18,63},{-16,63},{-14,63},{11,63},{13,63},{15,63},{17,63},{19,63},{21,63}},
		decals = {{28,-60},{41,-58},{59,-58},{68,-58},{-17,-57},{33,-56},{49,-57},{56,-56},{16,-55},{26,-54},{78,-55},{-9,-53},{13,-53},{71,-52},{-53,-51},{-35,-51},{-29,-50},{-22,-51},{82,-50},{-67,-49},{-60,-48},{-43,-48},{20,-49},{-12,-46},{7,-47},{-78,-44},{79,-45},{-84,-40},{-76,-41},{11,-41},{-7,-39},{16,-39},{8,-37},{-82,-32},{-38,-32},{-7,-33},{90,-32},{-59,-31},{-48,-31},{8,-31},{20,-30},{86,-30},{-31,-28},{-23,-29},{-67,-27},{-58,-27},{-9,-27},{67,-26},{-89,-24},{-19,-25},{15,-25},{30,-24},{54,-24},{27,-22},{36,-23},{42,-23},{47,-22},{53,-22},{89,-23},{88,-23},{-89,-20},{-85,-21},{-63,-21},{64,-21},{71,-20},{85,-20},{-71,-19},{83,-16},{-86,-14},{-1,-14},{68,-15},{-67,-13},{-58,-12},{89,-13},{-36,-11},{-7,-10},{7,-11},{71,-10},{-90,-8},{-54,-8},{-43,-9},{-31,-9},{-13,-6},{11,-7},{24,-6},{45,-6},{61,-6},{85,-7},{-24,-5},{30,-4},{38,-4},{54,-4},{69,-4},{-84,-2},{88,-3},{46,-1},{-90,2},{-52,1},{84,2},{-66,3},{-45,3},{-84,6},{-70,6},{-58,5},{-38,6},{87,6},{-50,8},{-34,8},{-19,8},{12,7},{17,8},{36,8},{89,7},{-91,10},{-24,9},{-12,9},{22,10},{30,9},{-67,12},{-42,11},{-16,12},{14,12},{37,11},{45,12},{64,11},{84,12},{-30,13},{11,13},{19,13},{-84,15},{-73,16},{62,17},{90,18},{-85,22},{-70,22},{-26,22},{68,21},{87,21},{-57,23},{-45,23},{-70,26},{-52,26},{-37,26},{-18,26},{71,25},{-62,28},{-26,28},{-12,27},{23,28},{85,27},{9,30},{45,30},{52,29},{63,29},{89,30},{-85,32},{19,31},{59,31},{65,31},{-90,34},{-18,33},{29,33},{40,33},{81,34},{9,37},{85,38},{-18,39},{-9,39},{6,40},{-81,41},{-87,44},{-9,43},{-16,45},{10,45},{75,46},{46,48},{76,48},{-74,50},{10,50},{28,50},{36,49},{65,49},{-84,52},{-79,52},{-10,51},{17,52},{44,52},{50,51},{57,51},{-30,53},{-18,53},{-62,56},{-40,56},{26,55},{-73,57},{-52,57},{-15,57},{-63,60},{-44,59},{-35,59}},
		bp = {
			[1] = {
				 [1] = "0eNqdnetuGzsShF9lod8WMM078yqLILAd4awARwlkJdhs4Hdf6Wgk+9iU1PX9SuJMF29dxRmySP9ZPDz9XP3Yrje7xac/i/Xj983z4tO//yye139t7p8OP9v9/rFafFr8Wm93P/c/uVts7r8dfnB8YmmLl7vFevN19d/FJ3u5g5Hh5fPdYrXZrXfr1bECf//j95fNz28Pq+0e+hy93n7fLB//s3re7RF/fH/eh3zfHIrbwyyt3C1+//3ny6Eu70CCC8TyNYx4xvjf/ddfy+3942q577XVR5y5KnWEktwo7QpKdqPYdAWm+GHCFZjqh0lXYJobZq5MHqF0N8pcl+FgH7rtA8zD6mm3T95L4z2sjpkA1K4BBQHoNOpjpKggXetrSwpSuobkz+jlXKM4xPGn9NxFaQhThYbFE9Dd4ut6u3o8/lcZwTYBNl1rZheAsrt+YdLrN+y/YDp9xkBBBxr2WIg6D8c1SjrQuEYZEHpcpQKQxnWqQBrGdWoAaVynDkRmWKc4+UVmJnUY4pgfZ66PDXGU5J5OFbrJ4ijpux9WSfzgh8261Hpgiy5lHtiqC68HtukyN04phSzVXb8EXoc8sODlaNjspDCp++sHJo2hYqQEFHqMJLwoHQdi3GH+96TlMY2nIYxCh/nFbXL0u0KHpblhX8nx1/1udUkM7Z9IYfT9NcnK7ahfNlm4PajhRquDu9XxBlJ0I+lziael+lTiQS03Wp3cra43kLIbSf+Q8LRU/6pwoBZ97vCgmjzReVCDLPgeVP/S0fIIOnwRLv61o+WxxcMZpCgsmd+DHXNlUV645tdiD2zVpwIPbNMnLg9slxXcgVr12caDarJaelCDrOwe1Cgrkwc1ySrqQc2y3nlQi/49Hf8Jm0awVf+4Dg5Y/1rucn7dHS4LVv9q7vL4Wj/88G8KgebXZsdyWVMYNL9Ge2CDrqQe2Kjrvgc26Urqgc267ntgiyylHtQqy74HtclS6kHtsuw7UPukf+Cm2zrSTd2hGu8JBXWHaigjXXiPs+MwDzeXukSZOgPdHgOJMs0NW3SV88BWXZM9sE1XOQ9s1zXZAWvTpMucC9d0VXbh6kvWLlh9ydoFq+621/FesLzdfmFPWVh0m+WsjYG0j6JphnJ0mMSe7sftujR5cKVt+llJXbimi5MLN+ha6sKNujy5cJOupi7crMuTC7focurCraL5p4+9IP7PonqF/iZ8Fdm8JjuNPSXa9GMnrNs9JjkAZiXxAQegfT7kW8vbszCZY4HW3tgELoBVASzrMudrctF12Qd8a6n7tDnlan67BZYFsK5LsKvJESwy+IBNF3cfcNDV3QccRROe2dio5n9/y9dkLmb1++9ShZQ3uBkpjJG0V7hwwnJ0fiOa7kLuRHo9yJK/4DRbuIANCJwLOABJdgFHICMu4ASEzwWcgT65gP1sm8VpbJZMVf1+uwQkmdrOdXK0tKvrXBdkRTImzH53Vw01b0ISgIMgqXOFx57dN/YEz1EBu2BElmhyGmSP+TdnIswu5EImExdyBcLsAm5kLnEhd6DMHmDJyHCaS1zAYLXBBwyWG3zAUTyrcYFsgqWhX6N+yeJC36X6ACf1HsrRYdIOkQnAwGd9qRM7gPLUUfIvnBTVBUwmpQsHPgKActUxghn5A/Dnu8Vu/TSfkLs8LZ6L2uf+43a1/1Y+VOnS89n7fHr9vFaeD+LzUXz+TXsPXfvl0LVfDt10NSprUW8+e111ix/6SigloKiIohKKEnsvzNsqzs57XekVHu/a42+H0t8EdUADGtCABjSgAQ1oQF8331xdbu/H319GI0GdBKkZYSgjDGWEoYwwlBGGMuJk33JmxPQ+gfxlVBLUSFAnQWoaTSiNJpRGE0qjCaXRRNKony1Bnizq73POXUIBMRXENBDTQYyYdJ3kXCcp10nGdZJwneRbOztkPfnW3menuwRSqwJiKohpIKaDGDFHG8nRRnK0kRxtJEcbydF6tlt7crS+z2h3CQnEkJYUEFNBTAMxHcSIeV1JXleS15XkdSV5XUlel/MxN09el/cscJcQQUwCMaT1BcRUENNATCejOZEgI0EkFYzkgpFkELnweozSw4X8njnuEgKIiSAmgRjSYwXEVBDTQEwHMSJ/MuFPJvzJhD+Z8CcT/pzvV/ERKL2nm7sIAzEBxEQQk0AM6eYCYiqIaSCmkzFFiUAywUgqGMkFI8kgku7NNTwe0sUPHHWXMYEYUk4AMRHEJBBDxqaAmApiGojpZExRIpBMMJIKRnLBSDKITD1frOZjavhAbH8ZBoImEEPKIQ2KICaBGDKgBcRUENNATCdjihKBZIKRVDCSC0aSQd180+hthN5G6G2A3gbobYDeBuhtgN4G6G1kd5RsjpK9UbI1inZG0cYo2hdF26JoVxTQe3q9uNfB7umDFrhLCCDG9JhJDwGlgMaAPkt6CBj7oodUPaTpIR0MJRl+MP4GEsBABhhIAY3/drow3cV/+6AW7hIiiAkgxvSYSQ8BpYDGgD4DQwPypeghVQ9pekgHQ0mGH4y/gQQwkAEGUkDTjCBpRgCaEYBmkHUFsqwAVhXAogJYUwBLCmBFASwogPUEsJwAVhPAYgJZSyBLCWQlgSwkkHWEIB3tiJJaRKAWEahFBGpB9hjAFgPYYQAbDGB/AWwvgN0FsLkA9hbA1gLYWSAbC2RfIUqHoaJ0FCpKB7/Ov/BKeVrKjwQUIgGFSEAhElAIYBcAbgFgFgBeAWAVAE4BYBQAPgFgEwAuAWIS0I5K5tOvw1Oeljo3AxZnwOIMWJwBizNgcdZZDIx2wGcHbHbAZQdMdsBjByx2wGEHDHZZOsBbJEYWwMgCGFkAIwtgZAGMLICRRWdk0RkJnOPAOA5848A2DlzjwDQOPONFOYNdJXZVwK4K2FUBuypgVwXsqoBdVWdX1dlVdXaBI0rghBI4oATOJ4HjSVW53aBJVGmAKg1QpQGqNECVBqjSAFWaTpWmU6XpVGk6VcAhVXBGFRxRbcolIE1awOwSSzpgSQcs6YAlHbCkA5Z0wJKus6TrLOk6S7rOkq6zBNw2AC4b6ApLurTwR07In34LqbNCp8cLKQNVLJGgSIICCTIQNIEYUg5pEOk5MkQkF4qUo97FdXT9Cbr9ZL55x801I1wzwjVkKkKuImQrQr4iYiwiziJiLSLeImIuMuXSpsElVJ7HSY1E3gSNN4HwJhDeEGONEWeNEWuNEW+NAXONAXeNAXuNAX+NAYONBYk3Qdr6Rbf/ocv/0N1/8w2QbrJFQrZIyEZ8KUaMKUacKUasKQa8KQbMKQbcKQbsKQb8KRYlskVp5xXduIouXEX3raLrVucbbt0MTYShxBZixBdixBhixBlixBpiwBtiwBxiwB1iwB5iSbmBUbwS2sgtCEZuQUB3Q6OroU0zbxhxbxixbxjxbxgxcBhxcBixcBjwcBgwcRhwcVhW7pK0rDGHXNpj5NIeI5f22O1Lez7fLda71bf9/zw8/Vz92K43h1/K8nT/sHra/+xf+7//Wm2fj/fctxpCsz7V8PLyf6xp9Qc="
				,[2] = "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"
				,[3] = "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"
				,[4] = "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"
				,[5] = "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"
				,[6] = "0eNqdnd1uG8cShF/lgNcSMD3/61cJDEOyiRwCsmxItHF8DL17KItyErG57Pqukig7xR5uV23vTPXw5+b27tv268Pufr9593Oz+/jl/nHz7o+fm8fdn/c3d89/2//4ut2823zfPey/Hf5ytbm/+fz8h5crrvvm6Wqzu/+0/d/mnT1dCSPtHyPz0/urzfZ+v9vvti8B/PqPHx/uv32+3T4coH+P/v/Np+/XDzcft9eHYLcH1K9fHg/Dvtw/f+QB6tr61ebHr38+PcfzBigLQHUNqAhAeQ2oCkBpDajFgeYaTo/jrH7VI47z+k03D2f+xtk9fLm//vjf7eP+FMPaWiyLE8vt9m5/yELna36Fqh7U800AWMXFMgmrrMaVEZYfV5GwbDWuirD8uJqCtayG1QmUH9VQoMZqVJNA+VFJOb+apjnFqZzXppfjOp5WA8qIg9nFKgjLXKyKOOjH1RCWH1dHHPTjGgjLj2sSEvphLQTKjaokQkI3qmIEyo8qEz77URUC5UclZfxqwpdGoPyotHxfjWoQKD+qGVa/vBrSEsapa/FUVskkF4tVMj4WqmQWF4oVMn5YqJDxw0J1jB8VqWP8oFAZ4wdFyhg/KFTFuEG1BKDcoJoRpfKDygDKD6oAofKRKpE8f3pKoq8jdR3Jn52S5qtfeFzO1/MyLud9JZyeiDxNF8qApvhIGSANF6kASfFjqgDJj6kBRfFj6gDJj+nv9P7zZr+y2OLHMYOj/c9egJi5cYwEkNyYhgEx82PKAMmPqeha5odUdSA/IiWT82tEV5tPu4ftx5f/lT3YrmutP1Eg2v5Elcqkxica1/A1aZrxhZa5MslppLBv/55m94AzkE53QXaSV1AfqQIkf6G5BcXPj6MHR/ufPYDg+XFMgOTHtADB85ffE0ByY1qU1E6vIV3k75J1IfVnCqTdn2jVFTky0aYLqT9RIO3+RJXMb/GJAqGPwCqc6GFYS3HlX1a+TEvKTunx2/S3DxJahamXHyKWtDfVLCCjJZoSQSal/pn9ww4E+gwUeWqcud3SY8O/J35mk6eIP10jj5EzG6/gORKZrYEHyZnJgifJmbmCR0loruBZcmau4GFyZq5Dl/3QXKf+lArhgudJBDcrVBkCbvz58upW8W9UVpw4x1uefSTFivO6xugjaY+P9BrV5cdHJntbOXI/OpDtEDDZ9zpzgyZZT/ahFl22I7OVtnxXJyvt+K7OVdrwFe6stPu7yjxp87eszrXp8hqaa9cfByHcoctrCHfqj4MQrsKbGcet8deWdemtJtsgkw8kPFde3qTOBCS9pMxjRJefBBVsrqXInWiyMoZg9W23M/dlyEBnbsyUZTE00UXWMn+i0jZzWZmotMvcwhOVdpxrHLbIihiCrbIghmAVtixx2C7LbAg2bqU+rpacyaipWsT9576wY33cBPDfAbQt636M6LLGdr0Gizzsul6QhWD1esy/LV0vx87cF70aC01UL8ZCsHotFoLVS7EQ7CIrTwRW2jCfcViJSSmOG6/SbC1TR1GbVfwFqCF04bwkvL/8Lu2jHzcEIwvbYCM9spoz9L2XEKy+9xKCXS7ssL7emctQU18ei0Qobbz3OGy+MPERn3i5ANXjUFVWstBkm6xkIdhL2/MzPnHpVcbiIU5dbEO48XLt2PPoi9uS1I6+7uOYvmbZAyIpbeI3D9b9+hb9zSYEq7/ZhGD1N5sQrP5mE4IFVArhAiqFcJXqzXIUNwvb/0eKDr9RT1hGeykTpo8DvI7zMkWztPWf4rBVpuiM3BWdSyFYnUshWMClEC7gUggXcCmCazKXFr9X1dSuV9/fnyVPQHpFupz1wCEQw9X9AjFcnU6WIje864kfAx565seAp576MWC51DvTmKu0fB+/Ub8tN+trcRZY48tZX4yL4eqrcTHcCpI0sJSSJWvBa5KGgDtI0hDwkJP0zCkAUz4Wxj9iJOdFPhfmDFLRieMflQCMBBZYSsrAVhDDBcQJ4VZ5MSmG2wAhA6/buRDehIB13hxy9P3VZr+7Ox6rtHJY0m/sA+LHh+1+u3mO4eyA9vSvYD48B/Ph+YPWh1U2rLBhmQ0zNiyhYQsaNdGogUZ1NIolSNXy8J9puH59UxO9sURvLNEbS/TGEr2xRG8s0RtK9IYSvaFEbyjRG0r0dpLowqiiZW+cHlWlR2X0qIweldGjMnpURo/K6FERPSqiR0X0qIgeFdGjInrUE3oIo7KW83FSFZVUhZGqMFIVRqrCSFUYqQojVUGkKohUBZGqIFIVRKqCSFUQqYpIqiKSKqukyoxUmZEqM1JlRqrMSJUZqTIiVUakyohUGZEqI1JlRKqMSJVFUplKEmMkMUYSYyQxRhJjJDFGEkMkMUQSQyQxRBJDJDFEEkMksROSKLc5ypSkUisxaiVGrcSolRi1EqNWYtRKiFoJUSshaiVErYSolRC1EqJWQtRKJ9SKj0pBei0iHRfExgWRcUFcXBAVF8TEBRFxITxcCA0XwsKFkHAhHFwIBRfCwIUQcCH8W97SLzwm+gidImUnouxElJ2IshNRdiLKTkTZSSg7CWUnoewklJ2EspNQdhLKTkLZSSg7AWXnW8qGx0RfQodI84FoPhDNB6L5QDQfiOYD0XwQmg9C80FoPgjNB6H5IDQfhOaD0HwQmg9A8wFoPt7SPDwmuj2puk6Y6YR5TpjlhDlOmOGE+U2Q3QS5TZDZBHlNkNWkE2noRBo6kYZOpKEDaehAGjqQhv5WGsJjomYg1dvDrD3M2cOMPczXw2w9zNWDTD3I04MsPcjRgww9yM/TiJw0IieNyEkDctKAnDQgJw3ISXsrJ+Ex0W1pxw4Vul6LidmgmAuKmaCYBwpZoJADChmgkP8J2Z+Q+wmZnyoRk0rEpAIxqUBMKhCTCsSkAjGpb8UkPCZa0zgesND12tyZ94tZv5jzCxm/kO8L2b6Q6wuZvpDnC1m+CpGSQqSkACkpQEoKkJICpKQAKSlASspbKQmPGZKcTOnqJXh1FqWNWfCYA48Z8Jj/DtnvkPsOme+Q9w5Z75DzDhnvMpG2TKQtA2nLQNoykLYMpC0DactA2jKQtvxW2sJjCI0IXy1qfzFRG6HzkrnDmDmMecOQNQw5w5AxDPnCkC0MucKQKQx5wpAlDGijAW00oI0GtNGANhrQRgPaaEAbDWijAW20E22MDzJJIC1rlxftck2to4uKjvU3crmU78jwi+y+xOxLrL7E6EtsvsTkSyy+xOBL7L3E3Jt0IU+6jiddxpOu4kkX8aRreNIlPOkKnnQBT7p+JyDf6US9w2NAAhjIAAMpoO08O9X3mq6jshtV3aToJjU3KblJxU0KblJvk3KbVNuk2Aa1Nii1QaUNCm1QZ4MyG1TZoMgGNTYosUmFbUCiDUi0AYk2INEGJDprEo1WjdGiMVkzJkvGZMWYLBiT9WKyXExWi8liMVkrBkvFYKUYLBSDdWKwTAxWicEiMVgjBkvEYIU4A4nOQKIzkOgMJDoDic5Aoosm0cizgCwLxLFADAvEr0DsCsStQMwKxKtArArEqQCMCsCnAGwKwKUATArAowAsCkWX6KJLdNElugCJLkCiC5DoAiS6AIkuQKIdy+maRCOvKbGaEqcpMZoSnymxmRKXKTGZEo8psZgChykwmAJ/KbCXAncpMJdWXW2rrrZVV9uqq20FaluB2lagthWobQVqW4HaOn0/a2pLGn5Ivw9p9yHdPqTZh/T6kFYf0ulDGn1Anw9o8wFdPqDJB/T4NF04my6cTRfOpgtn04WzAeFsQDgbEM4GhLMB4WxAOE87qdd0k7RQkw5q0kBN+qdJ+zTpnibN06R3GrROg85p0DgN+qa7roFd18Cua2DXNbDrGth1DexAAzvQwA40sAMN7EADO9DA0zNj1jSQHBZDzoohR8WQk2LIQTHknBhyTAw4JQYcEgPOiBm6ng1dz4auZ0PXs6Hr2dD1bOh6NoCeDaBnA+jZAHo2gJ4NoGenp9at6Rk5ro6cVkcOqyNn1ZGj6shJdeCgOnBO3dS1aeraNHVtmro2TV2bpq5NU9emqWvTBNo0gTZNoE0TaNME2jSBNp2eZ7umTacH2QaurtLVBUSfwRjTxyR9CPgUMBnwnVV9CMirrg8Z+pCpD1nArSS3H9x/AwlgIAMMpIDoLU/SD8uhg+DROfAGekUMNIsY6BYx0C5ioF/EQMOIgY4RAy0jBnpGDDSNGOkaMdI2YqRvxEjjiJHOEUOtIyb9cJD4Yyhmyk81GOkTII0CpFOAtAqQXgHSLEC6BUi7AOkXQA0DqGMAtQygngHUNEC6Biwrv5tgwJFtwJJtwJNtwJRtwJVtwJZtwJdtwJhtxJltxJptxJttxJxtxJ1txJ5tRflxASvKeeNWlOOEDbhXDdhXDfhXDRhYDThYjVhYjXhYjZhYjbhYjdhYjfhYrSpnx5p00KNV5Vw2q8q5bFaVc9msSkcVWZUO4rAqHcRhVTqIw6p0EMfqLz+/v9rs9tvPh7/d3n3bfn3Y3e83V5u7m9vt3eFv/zn8+/ftw+MvsD5HztOWNPLT01/Rpo8d"
			},
			[2] = {
				 [1] = "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"
				,[2] = "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"
				,[3] = "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"
				,[4] = "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"
				,[5] = "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"
				,[6] = "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"
			},
			[3] = {
				 [1] = "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"
				,[2] = "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"
				,[3] = "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"
				,[4] = "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"
				,[5] = "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"
				,[6] = "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"
			},
			[4] = {
				 [1] = "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"
				,[2] = "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"
				,[3] = "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"
				,[4] = "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"
				,[5] = "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"
				,[6] = "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"
			}
		}
	}
	
	,ScriptForAll = function(rndroll, game, surface, force, area, center, namelist, entitylist, areadata, locstore)
		
		areadata.area = Area.to_table(area)
		areadata.force = force
		areadata.center = center
		areadata.surface = surface
		
		areadata.carmark = '1.04398046510'
		
		areadata.entnamelist = {"gate", "stone-wall", "constant-combinator", "zadv-race-trophy", "zadv-race-car-red", "zadv-race-car-green", "zadv-race-car-yellow", "zadv-race-belt-1", "zadv-race-belt-2", "zadv-race-belt-3", "zadv-race-cone"}
		
		areadata.build = {x=1,y=1}
		areadata.build.pos = {x=center.x-80,y=center.y-47}
		areadata.build.f = function(surface, force, bp, pos)
			
			global.ZADV.blueprint.clear_blueprint()
			global.ZADV.blueprint.import_stack(bp)
			if global.ZADV.blueprint.is_blueprint_setup() then
				
				for k,v in pairs(global.ZADV.blueprint.build_blueprint{
					surface=surface,
					force=game.forces[force],
					position=pos,
					force_build=true,
					direction=0,
					skip_fog_of_war=false
				}) do if v.valid and not v.revive() then
						for _,e in pairs(surface.find_entities_filtered{
							area=v.bounding_box,
							name=v.name,
							invert=true
						}) do e.destroy() end
						v.revive()
					end
				end
			end
		end
		
		areadata.prizes = {
			green = {
				cheat = { {name = 'iron-ore', count = 1} },
				normal = {
					{name = 'fast-inserter', count = 1},
					{name = 'electronic-circuit', count = 2},
					{name = 'plastic-bar', count = 10},
					{name = 'battery', count = 2},
					{name = 'solid-fuel', count = 1},
					{name = 'sulfur', count = 10},
				},
				good = {
					{name = 'speed-module', count = 1},
					{name = 'electronic-circuit', count = 1},
					{name = 'night-vision-equipment', count = 1},
					{name = 'filter-inserter', count = 1},
					{name = 'solar-panel', count = 1},
					{name = 'fast-transport-belt', count = 10},
					{name = 'science-pack-1', count = 10},
					{name = 'electronic-circuit', count = 6},
					{name = 'uranium-ore', count = 10},
				},
				extra = {
					['coin'] = {name = 'zadv_coin', count = 1},
					{name = 'productivity-module', count = 1},
					{name = 'effectivity-module', count = 1},
					{name = 'personal-roboport-equipment', count = 1},
					{name = 'gun-turret', count = 1},
					{name = 'filter-inserter', count = 2},
					{name = 'fast-transport-belt', count = 20},
					{name = 'assembling-machine-2', count = 1},
					{name = 'zadv-race-car-green', count = 1},
					{name = 'science-pack-2', count = 10},
					{name = 'electronic-circuit', count = 10},
					{name = 'electric-furnace', count = 1},
					{name = 'uranium-ore', count = 20},
					{name = 'uranium-238', count = 5},
					{name = 'heat-pipe', count = 5},
				}
			},
			yellow = {
				cheat = { {name = 'copper-ore', count = 1} },
				normal = {
					{name = 'battery-equipment', count = 1},
					{name = 'fast-transport-belt', count = 20},
					{name = 'filter-inserter', count = 2},
					{name = 'solar-panel', count = 1},
					{name = 'science-pack-2', count = 10},
					{name = 'advanced-circuit', count = 2},
					{name = 'engine-unit', count = 2},
					{name = 'rocket-fuel', count = 1},
				},
				good = {
					['coin'] = {name = 'zadv_coin', count = 2},
					{name = 'speed-module-2', count = 1},
					{name = 'solar-panel-equipment', count = 1},
					{name = 'flamethrower-turret', count = 1},
					{name = 'assembling-machine-2', count = 1},
					{name = 'military-science-pack', count = 10},
					{name = 'fast-underground-belt', count = 2},
					{name = 'fast-splitter', count = 1},
					{name = 'advanced-circuit', count = 3},
					{name = 'construction-robot', count = 2},
					{name = 'electric-furnace', count = 1},
					{name = 'uranium-238', count = 10},
				},
				extra = {
					['coin'] = {name = 'zadv_coin', count = 4},
					{name = 'productivity-module-2', count = 1},
					{name = 'effectivity-module-2', count = 1},
					{name = 'energy-shield-equipment', count = 1},
					{name = 'exoskeleton-equipment', count = 1},
					{name = 'stack-inserter', count = 1},
					{name = 'assembling-machine-3', count = 1},
					{name = 'car', count = 1},
					{name = 'zadv-race-car-yellow', count = 1},
					{name = 'science-pack-3', count = 5},
					{name = 'fast-splitter', count = 1},
					{name = 'advanced-circuit', count = 10},
					{name = 'personal-roboport-mk2-equipment', count = 1},
					{name = 'construction-robot', count = 3},
					{name = 'uranium-235', count = 1},
					{name = 'heat-exchanger', count = 1},
					{name = 'steam-turbine', count = 1},
				}
			},
			red = {
				cheat = { {name = 'coal', count = 1} },
				normal = {
					['coin'] = {name = 'zadv_coin', count = 1},
					{name = 'fast-underground-belt', count = 2},
					{name = 'express-transport-belt', count = 5},
					{name = 'stack-inserter', count = 2},
					{name = 'science-pack-3', count = 1},
					{name = 'military-science-pack', count = 10},
					{name = 'fast-splitter', count = 1},
					{name = 'processing-unit', count = 1},
					{name = 'electric-engine-unit', count = 1},
					{name = 'nuclear-fuel', count = 1},
				},
				good = {
					['coin'] = {name = 'zadv_coin', count = 3},
					{name = 'speed-module-3', count = 1},
					{name = 'battery-mk2-equipment', count = 1},
					{name = 'express-transport-belt', count = 10},
					{name = 'express-underground-belt', count = 2},
					{name = 'belt-immunity-equipment', count = 1},
					{name = 'laser-turret', count = 1},
					{name = 'stack-inserter', count = 4},
					{name = 'assembling-machine-3', count = 1},
					{name = 'production-science-pack', count = 5},
					{name = 'science-pack-3', count = 4},
					{name = 'express-splitter', count = 1},
					{name = 'processing-unit', count = 2},
					{name = 'substation', count = 1},
					{name = 'uranium-235', count = 1},
					{name = 'uranium-fuel-cell', count = 1},
					{name = 'centrifuge', count = 1},
				},
				extra = {
					['coin'] = {name = 'zadv_coin', count = 10},
					{name = 'productivity-module-3', count = 1},
					{name = 'effectivity-module-3', count = 1},
					{name = 'energy-shield-mk2-equipment', count = 1},
					{name = 'fusion-reactor-equipment', count = 1},
					{name = 'personal-laser-defense-equipment', count = 1},
					{name = 'artillery-turret', count = 1},
					{name = 'stack-filter-inserter', count = 2},
					{name = 'tank', count = 1},
					{name = 'zadv-race-car-red', count = 1},
					{name = 'production-science-pack', count = 10},
					{name = 'space-science-pack', count = 10},
					{name = 'processing-unit', count = 4},
					{name = 'uranium-fuel-cell', count = 3},
					{name = 'nuclear-reactor', count = 1},
				}
			}
		}
		
	end
	
	,Events = {
		
		[defines.events.on_tick] = function(event, ad, game)
			
			if not ad.builded and ad.buildnext then
				
				local bp = ad.bp[ad.build.y][ad.build.x]
				local barea = Position.expand_to_area(ad.build.pos,16)
				
				for _,p in pairs(game.players) do
					if Area.inside(barea, p.position) then p.teleport(Position.offset(ad.center, 0, 32)) end
				end
				
				ad.build.f(ad.surface, ad.force, bp, ad.build.pos)
				
				for _,entity in pairs(ad.surface.find_entities(barea)) do
					
					if entity and entity.valid and entity.prototype.name == "wooden-chest" then
		
						local pos = Position.offset(entity.position, 0, -1)
						
						ad.cars = ad.cars or {}
						local name = "zadv-race-car-green"
						if #ad.cars == 1 then name = "zadv-race-car-yellow" end
						if #ad.cars == 2 then name = "zadv-race-car-red" end
						local ent = ad.surface.create_entity{name=name, position=pos, direction=2, force=ad.force}
						ent.minable = false
						ent.operable = false
						ent.rotatable = false
						ent.get_inventory(defines.inventory.fuel).insert("nuclear-fuel")
						ent.effectivity_modifier = tonumber(ad.carmark .. (#ad.cars+1))
						ad.cars[#ad.cars+1] = {id = #ad.cars+1, ent = ent, pos = pos}
						
						entity.destroy()
						
					elseif entity and entity.valid and entity.prototype.name == "pipe" then
					
						local pos = entity.position
						local ent = ad.surface.create_entity{name="gate", position=pos, direction=0, force='enemy'}
						ent.minable = false
						ent.operable = false
						ent.rotatable = false
						ent.destructible = false
						
						ad.gates = ad.gates or {}
						ad.gates.left = ad.gates.left or {}
						ad.gates.right = ad.gates.right or {}
						if pos.x > ad.center.x then
							table.insert(ad.gates.right, ent)
						else
							table.insert(ad.gates.left, ent)
						end
						
						entity.destroy()
						
					elseif entity and entity.valid and entity.prototype.name == "small-electric-pole" then
						ad.podcenter = entity.position
						ad.podentrance = Position.offset(entity.position, 0.5, 9)
						ad.podarea = Position.expand_to_area(entity.position, 9)
						entity.destroy()
						
					elseif entity and entity.valid and entity.prototype.name == "pipe-to-ground" then
						local ent = ad.surface.create_entity{name="gate", position=entity.position, direction=2, force=ad.force}
						ent.minable = false
						ent.operable = false
						ent.rotatable = false
						ent.destructible = false
						entity.destroy()
						
					elseif entity and entity.valid and entity.prototype.name == "steel-chest" then
						local ent = ad.surface.create_entity{name="zadv-race-trophy", position=entity.position, force=ad.force}
						ent.minable = false
						ent.rotatable = false
						ent.destructible = false
						ad.prizepos = entity.position
						ad.prizechest = ent
						entity.destroy()
						
					elseif entity and entity.valid and entity.prototype.name == "zadv-race-belt-1" then
						ad.belts = ad.belts or {}
						table.insert(ad.belts, {pos=entity.position, dir=entity.direction})
						entity.destroy()
						
					elseif entity and entity.valid and entity.prototype.name == "gate" then
						ad.gates = ad.gates or {}
						ad.gates.race = ad.gates.race or {}
						table.insert(ad.gates.race, {pos=entity.position, dir=entity.direction})
						entity.destroy()
						
					elseif entity and entity.valid and entity.prototype.name == "constant-combinator" then
						ad.combinator = entity
						
					elseif entity and entity.valid and entity.prototype.name == "iron-chest" then
						entity.destroy()
						
					elseif entity and entity.valid and ( entity.prototype.name == "zadv-race-cone" or entity.prototype.name == "stone-wall" ) then
						entity.minable = false
						entity.operable = false
						entity.rotatable = false
						entity.destructible = false
					
					end
					
				end
				
				ad.build.x = ad.build.x +1
				ad.build.pos.x = ad.build.pos.x + 32
				
				if ad.build.y == 4 and ad.build.x > 6 then
					ad.builded = true
					ad.bp = nil
					ad.build = nil
					ad.buildnext = nil
					
					for _,e in pairs(ad.surface.find_entities_filtered{name='stone-wall', area=Area.expand(ad.area,5)}) do
						if e and e.valid and not Area.inside(Position.expand_to_area(ad.center, 25), e.position) then e.destroy() end
					end
					
					local dec = {}
					for _,d in pairs(ad.decals) do
						table.insert(dec, {name="zadv_race_tile-decal", position=Position.offset(ad.center, d[1], d[2]), amount=1})
					end
					ad.surface.create_decoratives{decoratives=dec, check_collision=false}
					ad.decals = nil
				
				elseif ad.build.x > 6 then
					ad.build.x = 1
					ad.build.y = ad.build.y +1
					ad.build.pos.x = ad.build.pos.x - 192
					ad.build.pos.y = ad.build.pos.y + 32
					
				end
				
				ad.buildnext = event.tick + 10
				return true
				
			elseif not ad.builded then
				
				ad.cars = {}
				ad.belts = {}
				ad.gates = {}
				ad.gates.left = {}
				ad.gates.right = {}
				
				ad.buildnext = event.tick + 10
				return true
			
			end
			
			local function step(e,i)
				
				if not ad.builded or ad.disabled then return false end
				
				ad.nextcheck = ad.nextcheck or {}
				if ad.nextcheck[e] then
					if ad.nextcheck[e] <= event.tick then
						ad.nextcheck[e] = event.tick + i
						return true
					end
				else
					ad.nextcheck[e] = event.tick + i
					return true
				end
				return false
			end
			
			local function IntegrityCheck()
				
				if ad.surface.count_entities_filtered{area=ad.area, name=ad.entnamelist, invert=true} > 0 then
					for _,e in pairs(ad.surface.find_entities_filtered{area = ad.area, name = ad.entnamelist, invert = true}) do
						if e.valid and e.minable and not e.prototype.name:find('player') then e.destroy() end
					end
				end
				
				if ad.surface.count_entities_filtered{area=ad.area, name='zadv-race-cone'} < #ad.cones then
					if not ad.cones[1].name then
						local _c = {}
						for _,v in pairs(ad.cones) do table.insert(_c,{name='concrete',position=Position.offset(ad.center, v[1], v[2])}) end
						ad.cones = table.deepcopy(_c)
					end
					ad.surface.set_tiles(ad.cones,true)
					for _,p in pairs(ad.cones) do
						local ent = ad.surface.create_entity{position=p.position, name='zadv-race-cone', force='neutral'}
						if ent and ent.valid then
							ent.minable = false
							ent.operable = false
							ent.rotatable = false
							ent.destructible = false
						end
					end
				end
				
			end
			
			local function UpdateRecords(index)
				
				if ad.race_records then
				
						if ad.race_records.best and (ad.race_records.best.green or ad.race_records.best.yellow or ad.race_records.best.red ) then
							
							ad.gui[index]['footer_head_1'].caption = 'Best laps:'
							ad.gui[index]['footer_b1'].caption = ''
							ad.gui[index]['footer_b2'].caption = ''
							ad.gui[index]['footer_b3'].caption = ''
							
							if ad.race_records.best.red		then ad.gui[index]['footer_b1'].caption = string.format('%1d:%02d.%1d - %s', ad.race_records.best.red.m, ad.race_records.best.red.s, ad.race_records.best.red.ss, ad.race_records.best.red.name) end
							if ad.race_records.best.yellow	then ad.gui[index]['footer_b2'].caption = string.format('%1d:%02d.%1d - %s', ad.race_records.best.yellow.m, ad.race_records.best.yellow.s, ad.race_records.best.yellow.ss, ad.race_records.best.yellow.name) end
							if ad.race_records.best.green	then ad.gui[index]['footer_b3'].caption = string.format('%1d:%02d.%1d - %s', ad.race_records.best.green.m, ad.race_records.best.green.s, ad.race_records.best.green.ss, ad.race_records.best.green.name) end
							
						else
							ad.gui[index]['footer_head_1'].caption = ''
							ad.gui[index]['footer_b1'].caption = ''
							ad.gui[index]['footer_b2'].caption = ''
							ad.gui[index]['footer_b3'].caption = ''
							
						end
						
						if ad.race_records.last and (ad.race_records.last.green or ad.race_records.last.yellow or ad.race_records.last.red ) then
							
							ad.gui[index]['footer_head_2'].caption = 'Last laps:'
							
							if ad.race_records.last.red		then ad.gui[index]['footer_l1'].caption = string.format('%1d:%02d.%1d - %s', ad.race_records.last.red.m, ad.race_records.last.red.s, ad.race_records.last.red.ss, ad.race_records.last.red.name) end
							if ad.race_records.last.yellow	then ad.gui[index]['footer_l2'].caption = string.format('%1d:%02d.%1d - %s', ad.race_records.last.yellow.m, ad.race_records.last.yellow.s, ad.race_records.last.yellow.ss, ad.race_records.last.yellow.name) end
							if ad.race_records.last.green	then ad.gui[index]['footer_l3'].caption = string.format('%1d:%02d.%1d - %s', ad.race_records.last.green.m, ad.race_records.last.green.s, ad.race_records.last.green.ss, ad.race_records.last.green.name) end
							
						else
							ad.gui[index]['footer_head_2'].caption = ''
							ad.gui[index]['footer_l1'].caption = ''
							ad.gui[index]['footer_l2'].caption = ''
							ad.gui[index]['footer_l3'].caption = ''
						end
					
				else
					ad.gui[index]['footer_head_1'].caption = ''
					ad.gui[index]['footer_head_2'].caption = ''
					ad.gui[index]['footer_b1'].caption = ''
					ad.gui[index]['footer_b2'].caption = ''
					ad.gui[index]['footer_b3'].caption = ''
					ad.gui[index]['footer_l1'].caption = ''
					ad.gui[index]['footer_l2'].caption = ''
					ad.gui[index]['footer_l3'].caption = ''
				end
				
			end
			
			local function switchGUI(state, index, erase)
			
				ad.gui = ad.gui or {}
				if not state and not index and erase then
					for i,g in pairs(ad.gui) do
						ad.gui[i].destroy()
						ad.gui[i] = nil
					end
					
				elseif not state and ad.gui[index] then
					ad.gui[index].destroy()
					ad.gui[index] = nil
				
				elseif state and not ad.gui[index] then
					ad.gui[index] = game.players[index].gui.left.add{type='frame', name='ZADV_autodrome', direction='vertical'}
					ad.gui[index].add{type='label', name='header', direction='vertical', style='large_caption_label'}
					ad.gui[index].add{type='label', name='info_1', direction='horizontal', style='zadv_lable_info'}
					ad.gui[index].add{type='label', name='info_2', direction='horizontal', style='zadv_lable_race_info_white'}
					ad.gui[index].add{type='label', name='footer_head_1', direction='vertical', style='zadv_lable_race_head'}
					ad.gui[index].add{type='label', name='footer_b1', direction='vertical', style='zadv_lable_record_red'}
					ad.gui[index].add{type='label', name='footer_b2', direction='vertical', style='zadv_lable_record_yellow'}
					ad.gui[index].add{type='label', name='footer_b3', direction='vertical', style='zadv_lable_record_green'}
					ad.gui[index].add{type='label', name='footer_head_2', direction='vertical', style='zadv_lable_race_head'}
					ad.gui[index].add{type='label', name='footer_l1', direction='vertical', style='zadv_lable_record_red'}
					ad.gui[index].add{type='label', name='footer_l2', direction='vertical', style='zadv_lable_record_yellow'}
					ad.gui[index].add{type='label', name='footer_l3', direction='vertical', style='zadv_lable_record_green'}
					ad.gui[index]['header'].caption = 'Autodrome'
					ad.gui[index]['info_1'].caption = 'Choose a car and make your best lap.\nOr destroy the combinator and\nforget about the prizes.'
					
				end
				
			end
			
			local function CheckPlayersPositionForGUI()
				
				ad.players = ad.players or {}
				for i,p in pairs(game.players) do
					
					if Area.inside(ad.area, p.position) then
						ad.players[i] = true
						switchGUI(true, i)
						
					elseif ad.players[i] then
						ad.players[i] = false
						switchGUI(false, i)
					
					end
				end
				
			end
			
			local function RemoveObstacles()
				
				for _,e in pairs(ad.surface.find_entities_filtered{area=ad.area, name={'gate', 'zadv-race-belt-1', 'zadv-race-belt-2', 'zadv-race-belt-3'}}) do
					
					if e and e.valid then
						if not Area.inside(ad.podarea, e.position) then e.destroy() end
					end
					
				end
				
			end
			
			ad.ResetRace = function ()
				
				ad.player_in_car = false
				ad.rebuild_cars = true
				ad.race_in_progress = false
				ad.current_car_index = false
				ad.open_left_gates = false
				ad.left_gates_opened = false
				ad.race_start_time = false
				ad.prestart_step = 0
				ad.nextprestart = 0
				
				RemoveObstacles()
				
				for _,g in pairs(ad.gates.left) do
					if g and g.valid then g.request_to_close(g.force); g.force = 'enemy'  end
				end
				for _,g in pairs(ad.gates.right) do
					if g and g.valid then g.request_to_close(g.force); g.force = 'enemy'  end
				end
				
				for _,gui in pairs(ad.gui) do
					gui['info_1'].style = 'zadv_lable_info'
					gui['info_1'].caption = 'Choose a car and make your best lap.\nOr destroy the combinator and\nforget about the prizes.'
					gui['info_2'].style = 'zadv_lable_race_info_white'
					gui['info_2'].caption = ''
					if gui['footer_head_1'].caption == 'Rewards:' then
						gui['footer_head_1'].caption = ''
						gui['footer_b1'].caption = ''
						gui['footer_b2'].caption = ''
						gui['footer_b3'].caption = ''
					end
				end
				
			end
			
			local function CheckCarPosition()
				
				for _,c in pairs(ad.cars) do
					
					if c.ent and c.ent.valid and not Area.inside(ad.area, c.ent.position) then
						c.ent.die()
						ad.ResetRace()
					end
					
				end
				
			end
			
			local function RebuildCars()
				
				if not ad.rebuild_cars then return end
				
				for _,c in pairs(ad.cars) do
					
					if c.ent and c.ent.valid then c.ent.destroy() end
					
					local name = "zadv-race-car-green"
					if c.id == 2 then name = "zadv-race-car-yellow" end
					if c.id == 3 then name = "zadv-race-car-red" end
					c.ent = ad.surface.create_entity{name=name, position=c.pos, direction=2, force=ad.force}
					c.ent.minable = false
					c.ent.operable = false
					c.ent.rotatable = false
					c.ent.get_inventory(defines.inventory.fuel).insert("nuclear-fuel")
					c.ent.effectivity_modifier = tonumber(ad.carmark .. c.id)
					
				end
				
				ad.rebuild_cars = false
				
			end
			
			local function CheckCombinator()
				
				if not ad.combinator or not ad.combinator.valid or ad.blowItAll then
					
					for _,e in pairs(ad.surface.find_entities_filtered{area=ad.area, name={"zadv-race-car-yellow","zadv-race-car-green","zadv-race-car-red" }}) do
						if e and e.valid then e.die() end
					end
					for _,e in pairs(ad.surface.find_entities_filtered{area=ad.area, name=ad.entnamelist}) do
						if e and e.valid then e.destroy() end
					end
					for _,e in pairs(ad.surface.find_tiles_filtered{area=ad.area, name={'zadv_race_tile', 'concrete', 'refined-concrete', 'stone-path'}}) do
						if e and e.position then
							ad.surface.set_tiles({{name='red-desert-2', position=e.position}})
						end
					end
					
					switchGUI(false, nil, true)
					ad.disabled = true
					
				end
				
			end
			
			local function formatTime(m,s,ss)
				
				return string.format('  %1d:%02d.%1d',m,s,ss)
				
			end
			
			local function PlaceObstacles(id,type)
				
				local obs = type == 'belts' and ad.belts or ad.gates.race
				local name = type == 'belts' and 'zadv-race-belt-1' or 'gate'
				local force = 'neutral'
				
				if id == 2 then
					name = type == 'belts' and 'zadv-race-belt-2' or 'gate'
				elseif id == 3 then 
					name = type == 'belts' and 'zadv-race-belt-3' or 'gate'
					force = 'enemy'
				end
				
				for _,o in pairs(obs) do
					local ent = ad.surface.create_entity{name=name, position=o.pos, direction=o.dir, force=force}
					if ent and ent.valid then
						ent.destructible = false
						ent.operable = false
						ent.rotatable = false
						ent.minable = false
					end
				end
				
			end
			
			local function CheckRaceBegining()
				
				if not ad.race_in_progress and ad.player_in_car and ad.current_car_index then
					
					local car = ad.cars[ad.current_car_index]
					if Area.inside(ad.podarea, car.ent.position) then
						
						if ad.nextprestart then
							if ad.nextprestart <= event.tick then
								
								if ad.prestart_step == 0 then
									ad.gui[ad.player_in_car]['info_1'].style = 'zadv_lable_race_info'
									ad.gui[ad.player_in_car]['info_1'].caption = 'Prepare to start!'
									
									ad.gui[ad.player_in_car]['footer_head_1'].caption = 'Rewards:'
									
									local rt = 70 * ( 1 + (0.042 * (car.id - 1)) )
									local et = 50 * ( 1 + (0.042 * (car.id - 1)) )
									
									ad.gui[ad.player_in_car]['footer_b1'].caption = string.format('    Extra:  <<  %2d sec.',math.floor(et))
									ad.gui[ad.player_in_car]['footer_b2'].caption = string.format('    Good:  <<  %2d sec.',math.floor(rt))
									ad.gui[ad.player_in_car]['footer_b3'].caption = string.format('Normal:  >>  %2d sec.',math.floor(rt))
									
								elseif ad.prestart_step == 1 then
									ad.gui[ad.player_in_car]['info_2'].style = 'zadv_lable_race_info_red'
									ad.gui[ad.player_in_car]['info_2'].caption = '       ...READY...'
									
									PlaceObstacles(car.id,'belts')
									
								elseif ad.prestart_step == 2 then
									ad.gui[ad.player_in_car]['info_2'].style = 'zadv_lable_race_info_yellow'
									ad.gui[ad.player_in_car]['info_2'].caption = '       ..STEADY..'
									
									if car.id >= 2 then PlaceObstacles(car.id,'gates') end
									
								elseif ad.prestart_step == 3 then
									ad.gui[ad.player_in_car]['info_2'].style = 'zadv_lable_race_info_green'
									ad.gui[ad.player_in_car]['info_2'].caption = '          !! GO !!'
									
									for _,g in pairs(ad.gates.right) do
										if g and g.valid then g.force = ad.force; g.request_to_open(ad.force, 600) end
									end
									ad.race_start_time = event.tick
									
								elseif ad.prestart_step == 4 then
									
								end
								
								ad.prestart_step = ad.prestart_step + 1
								ad.nextprestart = event.tick + 60
							end
							
						else
							ad.nextprestart = event.tick
							ad.prestart_step = 0
							
						end
					end
				end
			end
			
			local function AddPrize(id, race_result, damage)
				
				local time = race_result.total
				local diff = {}
				local prizes = {}
				
				local function setPrize(have, new)
					
					local _new = table.deepcopy(new)
					local ret = table.deepcopy(have)
					
					if _new['coin'] then
						table.insert(ret, _new['coin'])
						_new['coin'] = nil
					end
					
					table.insert(ret, _new[ZADVRnd(1,#_new,id)])
					
					return ret
				end
				
				time = math.floor( (time * ( 1 - (0.042 * (id - 1)) )) / (0.5 + (damage / 2)) )
				
				if time > 1200 then
					
					ad.race_records = ad.race_records or {}
					ad.race_records.last = ad.race_records.last or {}
					ad.race_records.best = ad.race_records.best or {}
					
					if id == 1 then
						ad.race_records.last.green = table.deepcopy(race_result)
						
						if not ad.race_records.best.green 
						or (ad.race_records.best.green 
						and ad.race_records.best.green.total >= time)
						then
							ad.race_records.best.green = table.deepcopy(race_result)
						end
					
					elseif id == 2 then
						ad.race_records.last.yellow = table.deepcopy(race_result)
						
						if not ad.race_records.best.yellow 
						or (ad.race_records.best.yellow 
						and ad.race_records.best.yellow.total >= time)
						then
							ad.race_records.best.yellow = table.deepcopy(race_result)
						end
					
					elseif id == 3 then
						ad.race_records.last.red = table.deepcopy(race_result)
						
						if not ad.race_records.best.red 
						or (ad.race_records.best.red 
						and ad.race_records.best.red.total >= time)
						then
							ad.race_records.best.red = table.deepcopy(race_result)
						end
					
					end
					
				end
				
				if id == 1 then diff = ad.prizes.green
				elseif id == 2 then diff = ad.prizes.yellow
				elseif id == 3 then diff = ad.prizes.red
				end
				
				-- 20 1200, 50 3000, 70 4200, 150 9000
				if time <= 1200 then prizes = setPrize(prizes, diff.cheat)
				else
					if time <= 3000 then prizes = setPrize(prizes, diff.extra)  end
					if time <= 4200 then prizes = setPrize(prizes, diff.good)   end
					if time <= 9000 then prizes = setPrize(prizes, diff.normal) end
				end
				
				if prizes and ad.prizechest then
					
					if not ad.prizechest.valid then
						ad.prizechest = ad.surface.create_entity{name="zadv-race-trophy", position=ad.prizepos, force='neutral'}
					end
					
					if ad.prizechest and ad.prizechest.valid then
					
						ad.prizechest.minable = false
						ad.prizechest.rotatable = false
						ad.prizechest.destructible = false
						
						for _,item in pairs(prizes) do
							if game.item_prototypes[item.name] then ad.prizechest.get_inventory(defines.inventory.chest).insert(item) end
						end
					else
						ad.blowItAll = true
					end
					
				else
					ad.blowItAll = true
				end
				
			end
			
			local function CheckRaceProgress()
			
				local car = ad.cars[ad.current_car_index]
				
				if car and (not car.ent or not car.ent.valid) then
					ad.ResetRace()
					return
				end
				
				local race_time = {total = event.tick - (ad.race_start_time or 0)}
				race_time.m = math.floor(race_time.total / 3600)
				race_time.s = math.floor(race_time.total % 3600)/60
				race_time.ss = math.floor(race_time.total % 60)/10
				
				if not ad.race_in_progress and ad.prestart_step and ad.prestart_step >= 4 and not Area.inside(Area.expand(ad.podarea, 2), car.ent.position) then
					
					for _,g in pairs(ad.gates.right) do
						if g and g.valid then g.request_to_close(g.force); g.force = 'enemy' end
					end
					
					ad.race_in_progress = true
					
				end
				
				if ad.race_start_time and ad.prestart_step and ad.prestart_step > 4 then
					ad.gui[ad.player_in_car]['info_1'].style = 'zadv_lable_race_info'
					ad.gui[ad.player_in_car]['info_1'].caption = 'Lap time:'
					ad.gui[ad.player_in_car]['info_2'].style = 'zadv_lable_race_info_white'
					ad.gui[ad.player_in_car]['info_2'].caption = formatTime(race_time.m, race_time.s, race_time.ss)
					
				end
				
				if ad.race_in_progress then
					
					if not ad.open_left_gates then
						for _,g in pairs(ad.gates.right) do
							if g and g.valid and g.is_closed() then
								ad.open_left_gates = true
							end
						end
						
					elseif not ad.left_gates_opened then
						for _,g in pairs(ad.gates.left) do
							if g and g.valid then
								g.force = ad.force
								g.request_to_open(ad.force, 36000)
								ad.left_gates_opened = true
							end
						end
					end
					
					if car.id == 3 then
						local g = ad.surface.find_entities_filtered{name='gate', position=ad.gates.race[ZADVRnd(1,#ad.gates.race,event.tick)].pos, limit=1}
						if g and g[1] and g[1].valid then g[1].request_to_open('enemy', 300) end
					end
					
					if Area.inside(Area.shrink(ad.podarea, 2), car.ent.position) then
						
						race_time.name = game.players[ad.player_in_car].name
						
						AddPrize(car.id, race_time, car.ent.health / car.ent.prototype.max_health)
						
						UpdateRecords(ad.player_in_car)
						
						ad.ResetRace()
						
					end
					
				end
				
			end
			
			
			if step('cc', 10)	then CheckCombinator() end
			if step('ic', 10)	then IntegrityCheck() end
			if step('cp', 10)	then CheckCarPosition() end
			if step('rp', 10)	then CheckRaceProgress() end
			if step('rc', 30)	then RebuildCars() end
			if step('rb', 30)	then CheckRaceBegining() end
			if step('pp', 60)	then CheckPlayersPositionForGUI() end
			
		end
		
		
		,[defines.events.on_player_driving_changed_state] = function(event, ad, game)
			
			if event.entity and event.entity.valid
			and tostring(event.entity.effectivity_modifier):find(ad.carmark) then
				
				if event.entity.get_driver() then
				
					local car_num = tonumber(tostring(event.entity.effectivity_modifier):sub(14))
					local car = {}
					
					for _,c in pairs(ad.cars) do
						if c.id == car_num then
							car = c
							ad.current_car_index = c.id
						else
							c.ent.destroy()
							c.ent = nil
						end
					end
					
					car.ent.teleport(ad.podcenter)
					ad.player_in_car = event.player_index
				
				else
				
					if Area.inside(ad.podarea, game.players[event.player_index].position) then
						game.players[event.player_index].teleport(ad.podentrance)
					end
					
					ad.ResetRace()
					
				end
				
			end
			
			
		end
		
		,[defines.events.on_entity_died] = function(event, ad, game)
			
			if event.entity and event.entity.prototype.name:find("zadv-race-car") then
				ad.ResetRace()
			end
			
		end
		
		,[defines.events.on_player_mined_tile] = function(event, ad, game)
			game.print(string.format('tile %s:%s  %s',event.surface_index,game.surfaces[event.surface_index].name
			,event.tiles[1].old_tile.name))
			
			if game.surfaces[event.surface_index].name == ad.surface.name then
				for k,v in pairs(event.tiles) do
					if Area.inside(ad.area, v.position) and v.old_tile.name == "zadv_race_tile" then
						ad.surface.set_tiles({{name="zadv_race_tile", position=v.position}})
					end
				end
			end
			
		end
		
	}
	
	
}
end



return ret
