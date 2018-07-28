
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

if mods["bobassembly"]
or mods["boblogistics"]
or mods["bobelectronics"]
or mods["bobwarfare"]
or mods["bobmodules"] then

	local recipe = table.deepcopy(data.raw.recipe['transport-belt'])
	recipe.name = "zadv-transport-belt"
	recipe.hidden = true
	recipe.enabled = true
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

	recipe = table.deepcopy(data.raw.recipe['fast-transport-belt'])
	recipe.name = "zadv-fast-transport-belt"
	recipe.hidden = true
	recipe.enabled = true
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

	recipe = table.deepcopy(data.raw.recipe['express-transport-belt'])
	recipe.name = "zadv-express-transport-belt"
	recipe.hidden = true
	recipe.enabled = true
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

	ret.area['lone yellow belt'] = {
		
		areadata = {
			['iron-gear-wheel'] = 'iron-gear-wheel',
			['transport-belt'] = 'zadv-transport-belt'
		}
		
		,update_for = { modname="ZADV_Base", areaname="lone yellow belt" }
	}

	ret.area['yellow belts'] = {
		
		areadata = {
			['iron-gear-wheel'] = 'iron-gear-wheel',
			['transport-belt'] = 'zadv-transport-belt'
		}
		
		,update_for = { modname="ZADV_Base", areaname="yellow belts" }
	}

	ret.area['red belts'] = {
		
		areadata = {
			['iron-gear-wheel'] = 'iron-gear-wheel',
			['transport-belt'] = 'zadv-transport-belt',
			['fast-transport-belt'] = 'zadv-fast-transport-belt'
		}
		
		,update_for = { modname="ZADV_Base", areaname="red belts" }
	}

	ret.area['blue belts'] = {
	
		areadata = {
			['basic-oil-processing'] = 'basic-oil-processing',
			['lubricant'] = 'lubricant',
			['transport-belt'] = 'zadv-transport-belt',
			['fast-transport-belt'] = 'zadv-fast-transport-belt',
			['express-transport-belt'] = 'zadv-express-transport-belt'
		}
		
		,update_for = { modname="ZADV_Base", areaname="blue belts" }
	}

end

return ret
