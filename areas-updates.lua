
local ret = { ModName = "ZADV_Base_update", area={} }

if mods["5dim_transport"]
or mods["bobassembly"]
or mods["boblogistics"]
or mods["bobelectronics"]
or mods["bobwarfare"]
or mods["bobmodules"]
or mods["angelsrefining"]
or mods["angelspetrochem"]
or mods["angelsinfiniteores"]
or mods["angelssmelting"]
or mods["pyhightech"]
or mods["pycoalprocessing"] then

	local function addDisRec()
		local disrec = {
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
			"loader",
			"sulfur",
			"sulfuric-acid",
		}
		
		if mods["5dim_transport"] then
			table.insert(disrec, "5d-iron-chest-mk2-4")
			table.insert(disrec, "5d-electric-furnace")
			table.insert(disrec, "5d-industrial-furnace")
			table.insert(disrec, "5d-personal-blue-laser-defense-equipment")
			table.insert(disrec, "personal-laser-defense-equipment")
		end
		
		if mods["bobassembly"]
		or mods["boblogistics"]
		or mods["bobelectronics"]
		or mods["bobwarfare"]
		or mods["bobmodules"] then
			table.insert(disrec, "5d-assembling-machine-4")
			table.insert(disrec, "5d-assembling-machine-5")
			table.insert(disrec, "5d-chemical-plant-2")
			table.insert(disrec, "5d-chemical-plant-3")
			table.insert(disrec, "5d-oil-refinery-2")
			table.insert(disrec, "5d-oil-refinery-3")
			table.insert(disrec, "5d-effectivity-module-4")
			table.insert(disrec, "5d-effectivity-module-5")
			table.insert(disrec, "5d-productivity-module-4")
			table.insert(disrec, "5d-productivity-module-5")
			table.insert(disrec, "5d-speed-module-4")
			table.insert(disrec, "5d-speed-module-5")
			table.insert(disrec, "5d-exoskeleton-mk2-equipment")
			table.insert(disrec, "5d-exoskeleton-mk3-equipment")
			table.insert(disrec, "5d-fusion-reactor-mk2-equipment")
			table.insert(disrec, "5d-solar-panel-mk2-equipment")
			table.insert(disrec, "5d-active")
			table.insert(disrec, "5d-requester")
		end
		
		if mods["angelsrefining"]
		or mods["angelspetrochem"]
		or mods["angelsinfiniteores"]
		or mods["angelssmelting"] then
			table.insert(disrec, "advanced-oil-processing")
			table.insert(disrec, "air-pump")
			table.insert(disrec, "air-pump-2")
			table.insert(disrec, "air-pump-3")
			table.insert(disrec, "air-pump-4")
			table.insert(disrec, "alumina")
			table.insert(disrec, "ammonia")
			table.insert(disrec, "angels-copper-nugget-smelting")
			table.insert(disrec, "angels-copper-pebbles")
			table.insert(disrec, "angels-copper-pebbles-smelting")
			table.insert(disrec, "angels-iron-nugget-smelting")
			table.insert(disrec, "angels-iron-pebbles")
			table.insert(disrec, "angels-iron-pebbles-smelting")
			table.insert(disrec, "angels-plate-platinum")
			table.insert(disrec, "angels-wire-coil-platinum-casting")
			table.insert(disrec, "angels-wire-coil-platinum-casting-fast")
			table.insert(disrec, "angels-wire-coil-platinum-converting")
			table.insert(disrec, "angelsore-chunk-mix6-processing")
			table.insert(disrec, "angelsore-pure-mix2-processing")
			table.insert(disrec, "angelsore-pure-mix3-processing")
			table.insert(disrec, "basic-oil-processing")
			table.insert(disrec, "bob-aluminium-plate")
			table.insert(disrec, "bob-gold-plate")
			table.insert(disrec, "bob-lead-plate")
			table.insert(disrec, "bob-liquid-air")
			table.insert(disrec, "bob-nickel-plate")
			table.insert(disrec, "bob-oil-processing")
			table.insert(disrec, "bob-resin-oil")
			table.insert(disrec, "bob-silicon-plate")
			table.insert(disrec, "bob-titanium-plate")
			table.insert(disrec, "bob-tungsten-plate")
			table.insert(disrec, "bob-zinc-plate")
			table.insert(disrec, "brass-alloy")
			table.insert(disrec, "bronze-alloy")
			table.insert(disrec, "carbon")
			table.insert(disrec, "coal-cracking")
			table.insert(disrec, "cobalt-oxide")
			table.insert(disrec, "cobalt-oxide-from-copper")
			table.insert(disrec, "cobalt-plate")
			table.insert(disrec, "cobalt-steel-alloy")
			table.insert(disrec, "dinitrogen-tetroxide")
			table.insert(disrec, "enriched-fuel-from-hydrazine")
			table.insert(disrec, "ferric-chloride-solution")
			table.insert(disrec, "gas-refinery-4")
			table.insert(disrec, "glycerol")
			table.insert(disrec, "green-waste-water-purification")
			table.insert(disrec, "greenyellow-waste-water-purification")
			table.insert(disrec, "gunmetal-alloy")
			table.insert(disrec, "heavy-oil-cracking")
			table.insert(disrec, "hydrazine")
			table.insert(disrec, "hydrogen-chloride")
			table.insert(disrec, "hydrogen-peroxide")
			table.insert(disrec, "invar-alloy")
			table.insert(disrec, "lead-oxide")
			table.insert(disrec, "light-oil-cracking")
			table.insert(disrec, "liquid-hexachloroplatinic-acid-smelting")
			table.insert(disrec, "lubricant")
			table.insert(disrec, "molten-platinum-smelting")
			table.insert(disrec, "nitinol-alloy")
			table.insert(disrec, "nitric-acid")
			table.insert(disrec, "nitric-oxide")
			table.insert(disrec, "nitrogen")
			table.insert(disrec, "nitrogen-dioxide")
			table.insert(disrec, "oil-processing-with-sulfur")
			table.insert(disrec, "oil-processing-with-sulfur-dioxide")
			table.insert(disrec, "oil-processing-with-sulfur-dioxide-2")
			table.insert(disrec, "oil-processing-with-sulfur-dioxide-3")
			table.insert(disrec, "pellet-platinum-smelting")
			table.insert(disrec, "petroleum-gas-cracking")
			table.insert(disrec, "plastic-bar")
			table.insert(disrec, "platinum-ore-processing")
			table.insert(disrec, "platinum-ore-smelting")
			table.insert(disrec, "platinum-processed-processing")
			table.insert(disrec, "powdered-tungsten")
			table.insert(disrec, "processed-platinum-smelting")
			table.insert(disrec, "red-waste-water-purification")
			table.insert(disrec, "salt")
			table.insert(disrec, "salt-water-electrolysis")
			table.insert(disrec, "salt-water-electrolysis-2")
			table.insert(disrec, "silver-from-lead")
			table.insert(disrec, "slag-processing-8")
			table.insert(disrec, "slag-processing-9")
			table.insert(disrec, "solder-alloy")
			table.insert(disrec, "solid-ammonium-chloroplatinate-smelting")
			table.insert(disrec, "solid-fuel-from-heavy-oil")
			table.insert(disrec, "solid-fuel-from-hydrogen")
			table.insert(disrec, "solid-fuel-from-light-oil")
			table.insert(disrec, "solid-fuel-from-petroleum-gas")
			table.insert(disrec, "solid-glas")
			table.insert(disrec, "solid-lithium")
			table.insert(disrec, "sulfur-2")
			table.insert(disrec, "sulfur-dioxide")
			table.insert(disrec, "sulfuric-acid-2")
			table.insert(disrec, "thermal-water-purification")
			table.insert(disrec, "tungsten-oxide")
			table.insert(disrec, "tungstic-acid")
			table.insert(disrec, "void-pump")
			table.insert(disrec, "water-electrolysis")
			table.insert(disrec, "5d-pumpjack-2")
			table.insert(disrec, "alien-egg-blue")
			table.insert(disrec, "alien-egg-green")
			table.insert(disrec, "alien-egg-red")
			table.insert(disrec, "angels-rocket-defense-equipment-vequip")
			table.insert(disrec, "circuit-paper-board")
		end
		
		if mods["pyhightech"] then
			table.insert(disrec, "advanced-processing-unit")
			table.insert(disrec, "ammonia-urea")
			table.insert(disrec, "basic-circuit-board")
			table.insert(disrec, "basic-electronic-components")
			table.insert(disrec, "circuit-board")
			table.insert(disrec, "electronic-components")
			table.insert(disrec, "fibreglass-board")
			table.insert(disrec, "intergrated-electronics")
			table.insert(disrec, "module-processor-board")
			table.insert(disrec, "module-processor-board-2")
			table.insert(disrec, "module-processor-board-3")
			table.insert(disrec, "multi-layer-circuit-board")
			table.insert(disrec, "organic-solvent2")
			table.insert(disrec, "phenolic-board")
			table.insert(disrec, "processing-electronics")
			table.insert(disrec, "superior-circuit-board")
			table.insert(disrec, "wood-board")
			table.insert(disrec, "wooden-board")
			table.insert(disrec, "nitrobenzene")
			table.insert(disrec, "silicon-nitride")
			table.insert(disrec, "silicon-plate2")
		end
		
		if mods["pycoalprocessing"] then
			table.insert(disrec, "alumina2")
			table.insert(disrec, "combustion-mixture2")
			table.insert(disrec, "remud-dirty-water")
		end
		
		if mods["omnilib"] then
			table.insert(disrec, "omniflush-steam")
			table.insert(disrec, "omnirec-distillation-crude-oil-a")
			table.insert(disrec, "omnirec-distillation-crude-oil-b")
			table.insert(disrec, "omnirec-distillation-crude-oil-c")
			table.insert(disrec, "omnirec-distillation-crude-oil-d")
			table.insert(disrec, "omnirec-extraction-coal-a")
			table.insert(disrec, "omnirec-extraction-coal-b")
			table.insert(disrec, "omnirec-extraction-coal-c")
			table.insert(disrec, "omnirec-extraction-coal-d")
			table.insert(disrec, "omnirec-extraction-coal-e")
			table.insert(disrec, "omnirec-extraction-copper-ore-a")
			table.insert(disrec, "omnirec-extraction-copper-ore-b")
			table.insert(disrec, "omnirec-extraction-copper-ore-c")
			table.insert(disrec, "omnirec-extraction-copper-ore-d")
			table.insert(disrec, "omnirec-extraction-copper-ore-e")
			table.insert(disrec, "omnirec-extraction-iron-ore-a")
			table.insert(disrec, "omnirec-extraction-iron-ore-b")
			table.insert(disrec, "omnirec-extraction-iron-ore-c")
			table.insert(disrec, "omnirec-extraction-iron-ore-d")
			table.insert(disrec, "omnirec-extraction-iron-ore-e")
			table.insert(disrec, "omnirec-extraction-stone-a")
			table.insert(disrec, "omnirec-extraction-stone-b")
			table.insert(disrec, "omnirec-extraction-stone-c")
			table.insert(disrec, "omnirec-extraction-stone-d")
			table.insert(disrec, "omnirec-extraction-stone-e")
			table.insert(disrec, "omnirec-extraction-uranium-ore-a")
			table.insert(disrec, "omnirec-extraction-uranium-ore-b")
			table.insert(disrec, "omnirec-extraction-uranium-ore-c")
			table.insert(disrec, "omnirec-extraction-uranium-ore-d")
			table.insert(disrec, "omnirec-extraction-uranium-ore-e")
			table.insert(disrec, "omnirec-focus-1-coal-a")
			table.insert(disrec, "omnirec-focus-1-coal-b")
			table.insert(disrec, "omnirec-focus-1-copper-ore-a")
			table.insert(disrec, "omnirec-focus-1-copper-ore-b")
			table.insert(disrec, "omnirec-focus-1-iron-ore-a")
			table.insert(disrec, "omnirec-focus-1-iron-ore-b")
			table.insert(disrec, "omnirec-focus-1-stone-a")
			table.insert(disrec, "omnirec-focus-1-stone-b")
			table.insert(disrec, "omnirec-focus-1-uranium-ore-a")
			table.insert(disrec, "omnirec-focus-1-uranium-ore-b")
			table.insert(disrec, "omnirec-omnic-acid-a")
			table.insert(disrec, "omnirec-omnic-acid-b")
			table.insert(disrec, "omnirec-omnic-acid-c")
			table.insert(disrec, "omnirec-omnic-acid-d")
			table.insert(disrec, "omnirec-omnic-water-a")
			table.insert(disrec, "omnirec-omnic-water-b")
			table.insert(disrec, "omnirec-omnic-water-c")
			table.insert(disrec, "omnirec-omnic-water-d")
			table.insert(disrec, "omnirec-omnic-water-e")
			table.insert(disrec, "omnirec-omnic-water-f")
			table.insert(disrec, "omnirec-omnic-water-g")
			table.insert(disrec, "omnirec-omnic-water-h")
			table.insert(disrec, "omnirec-omnisludge-a")
			table.insert(disrec, "omnirec-omnisludge-b")
			table.insert(disrec, "omnirec-omnisludge-c")
			table.insert(disrec, "omnirec-omnisludge-d")
			table.insert(disrec, "omnirec-omniston-a")
			table.insert(disrec, "omnirec-omniston-b")
			table.insert(disrec, "omnirec-omniston-c")
			table.insert(disrec, "omnirec-omniston-d")
			table.insert(disrec, "omnirec-pseudoliquid-amorphous-crystal-a")
			table.insert(disrec, "omnirec-pseudoliquid-amorphous-crystal-b")
			table.insert(disrec, "omnirec-pseudoliquid-amorphous-crystal-c")
			table.insert(disrec, "omnirec-pseudoliquid-amorphous-crystal-d")
			table.insert(disrec, "omnirec-water-omnitraction-a")
			table.insert(disrec, "omnirec-water-omnitraction-b")
			table.insert(disrec, "omnirec-water-omnitraction-c")
			table.insert(disrec, "omnirec-water-omnitraction-d")
			table.insert(disrec, "pumpjack")
		end
		
		return disrec
	end


	ret.area['inventive station'] = {
		
		areadata = {
			dissalowed_recipes = addDisRec()
		}
		
		,update_for = { modname="ZADV_Base", areaname="inventive station" }
	}
	ret.area['free recipe'] = {
		
		areadata = {
			dissalowed_recipes = addDisRec()
		}
		
		,update_for = { modname="ZADV_Base", areaname="free recipe" }
	}
end

if settings.startup["zadv_area_yellow"].value
or settings.startup["zadv_area_red"].value
or settings.startup["zadv_area_blue"].value then
	local recipe = table.deepcopy(data.raw.recipe['iron-gear-wheel'])
	recipe.name = "zadv-iron-gear-wheel"
	recipe.hidden = true
	recipe.enabled = true
	recipe.hidden_from_flow_stats = true
	recipe.flags = {'hidden'}
	recipe.normal = nil
	recipe.expensive = nil
	recipe.ingredients = { {"iron-plate", 2} }
	recipe.result = "iron-gear-wheel"
	data:extend({recipe})
	
	recipe = table.deepcopy(data.raw.recipe['transport-belt'])
	recipe.name = "zadv-transport-belt"
	recipe.hidden = true
	recipe.enabled = true
	recipe.hidden_from_flow_stats = true
	recipe.flags = {'hidden'}
	recipe.normal = nil
	recipe.expensive = nil
	recipe.ingredients =
		{
			{"iron-plate", 1},
			{"iron-gear-wheel", 1}
		}
	recipe.result = "transport-belt"
	data:extend({recipe})

	recipe = table.deepcopy(data.raw.recipe['transport-belt'])
	recipe.name = "zadv-transport-belt-slow"
	recipe.hidden = true
	recipe.enabled = true
	recipe.energy_required = 6
	recipe.hidden_from_flow_stats = true
	recipe.flags = {'hidden'}
	recipe.normal = nil
	recipe.expensive = nil
	recipe.ingredients =
		{
			{"iron-plate", 1},
			{"iron-gear-wheel", 1}
		}
	recipe.result = "transport-belt"
	data:extend({recipe})
end

if settings.startup["zadv_area_red"].value
or settings.startup["zadv_area_blue"].value then
	local recipe = table.deepcopy(data.raw.recipe['fast-transport-belt'])
	recipe.name = "zadv-fast-transport-belt"
	recipe.hidden = true
	recipe.enabled = true
	recipe.hidden_from_flow_stats = true
	recipe.flags = {'hidden'}
	recipe.normal = nil
	recipe.expensive = nil
	recipe.ingredients =
		{
			{"iron-gear-wheel", 2},
			{"transport-belt", 1}
		}
	recipe.result = "fast-transport-belt"
	data:extend({recipe})

	recipe = table.deepcopy(data.raw.recipe['fast-transport-belt'])
	recipe.name = "zadv-fast-transport-belt-slow"
	recipe.hidden = true
	recipe.enabled = true
	recipe.energy_required = 12
	recipe.hidden_from_flow_stats = true
	recipe.flags = {'hidden'}
	recipe.normal = nil
	recipe.expensive = nil
	recipe.ingredients =
		{
			{"iron-gear-wheel", 2},
			{"transport-belt", 1}
		}
	recipe.result = "fast-transport-belt"
	data:extend({recipe})
end

if settings.startup["zadv_area_blue"].value then
	
	local recipe = table.deepcopy(data.raw.recipe['express-transport-belt'])
	recipe.name = "zadv-express-transport-belt-slow"
	recipe.hidden = true
	recipe.enabled = true
	recipe.energy_required = 19
	recipe.hidden_from_flow_stats = true
	recipe.flags = {'hidden'}
	recipe.normal = nil
	recipe.expensive = nil
	recipe.ingredients =
		{
			{"iron-gear-wheel", 5},
			{"fast-transport-belt", 1},
			{type="fluid", name="lubricant", amount=20}
		}
	recipe.result = "express-transport-belt"
	data:extend({recipe})
	
end

if settings.startup["zadv_area_yellow"].value then
ret.area['yellow belts'] = {
	
	areadata = {
		['iron-gear-wheel'] = 'zadv-iron-gear-wheel',
		['transport-belt'] = 'zadv-transport-belt-slow'
	}
	
	,update_for = { modname="ZADV_Base", areaname="yellow belts" }
}
end

if settings.startup["zadv_area_red"].value then
ret.area['red belts'] = {
	
	areadata = {
		['iron-gear-wheel'] = 'zadv-iron-gear-wheel',
		['transport-belt'] = 'zadv-transport-belt',
		['fast-transport-belt'] = 'zadv-fast-transport-belt-slow'
	}
	
	,update_for = { modname="ZADV_Base", areaname="red belts" }
}
end

if settings.startup["zadv_area_blue"].value then
	if mods["omnimatter_fluid"] then
		ret.area['blue belts'] = {
			bp = ""
			,update_for = { modname="ZADV_Base", areaname="blue belts" }
		}
	else
		ret.area['blue belts'] = {
			areadata = {
				['basic-oil-processing'] = 'basic-oil-processing',
				['lubricant'] = 'lubricant',
				['transport-belt'] = 'zadv-transport-belt',
				['fast-transport-belt'] = 'zadv-fast-transport-belt',
				['express-transport-belt'] = 'zadv-express-transport-belt-slow'
			}
			,update_for = { modname="ZADV_Base", areaname="blue belts" }
		}
		if mods["omnimatter"] then
			ret.area['blue belts_bp'] = {
				bp = "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"
				,update_for = { modname="ZADV_Base", areaname="blue belts" }
			}
		end
		if mods["omnimatter_permutation"] then
			ret.area['blue belts_rec'] = {
				areadata = {
					['basic-oil-processing'] = 'basic-oil-processing-omniperm-1-1',
					['lubricant'] = 'lubricant',
					['transport-belt'] = 'zadv-transport-belt',
					['fast-transport-belt'] = 'zadv-fast-transport-belt',
					['express-transport-belt'] = 'zadv-express-transport-belt-slow'
				}
				,update_for = { modname="ZADV_Base", areaname="blue belts" }
			}
		end
	end
end

if settings.startup["zadv_area_base"].value then
	if mods["omnimatter_fluid"] then
		ret.area['occupied base'] = {
			bp = "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"
			,ScriptForEach = function(rndroll, game, surface, force, area, center, entity, namelist, locstore, areadata)
		
				locstore.spitter = locstore.spitter or "medium-spitter"
				locstore.spawner = locstore.spawner or "zadv-biter-spawner"
				
				if entity.valid then
					if entity.prototype.name == "wooden-chest" then
						local pos = entity.position
						entity.destroy()
						locstore.spitter = locstore.spitter == "big-spitter" and "medium-spitter" or "big-spitter"
						surface.create_entity{name=locstore.spitter, position=pos, force=force}
						
					elseif entity.prototype.name == "iron-chest" then
						local pos = entity.position
						for _,ent in pairs(surface.find_entities_filtered{area=Position.expand_to_area(pos, 2)}) do
							ent.destroy()
						end
						locstore.spawner = locstore.spawner == "zadv-spitter-spawner" and "zadv-biter-spawner" or "zadv-spitter-spawner"
						surface.create_entity{name=locstore.spawner, position=pos, force=force}
						
					elseif entity.prototype.name == "logistic-chest-storage" then
						entity.get_inventory(defines.inventory.chest).insert({name="piercing-rounds-magazine", count=1000})
						
					elseif entity.prototype.name == "logistic-chest-passive-provider" then
						entity.get_inventory(defines.inventory.chest).insert({name="uranium-rounds-magazine", count=1000})
						
					elseif entity.prototype.name == "roboport" then
						entity.get_inventory(defines.inventory.roboport_robot).insert({name="logistic-robot", count=50})
						entity.get_inventory(defines.inventory.roboport_robot).insert({name="construction-robot", count=50})
						entity.get_inventory(defines.inventory.roboport_material).insert({name="repair-pack", count=200})
						
					end
				end
				
			end			
			,update_for = { modname="ZADV_Base", areaname="occupied base" }
		}
	end
end




return ret
