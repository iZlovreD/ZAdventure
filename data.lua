
ZADV = {}
ZADV.Data = {}
ZADV.backup = {}
ZADV.Settings = {}
ZADV.debug = 0

local format = string.format

local function debug ( level, msg, ... )

	if ZADV.debug >= tonumber(level) then
	
		if type(msg) == 'table' then
			log("\n[[ZADV]] ".. serpent.block(msg))
		
		else
			if type(msg) ~= 'string' then
				msg = tostring(msg)
			end
			log("[[ZADV]] ".. format(msg,...))
		end
		
	end
end


ZADV.Settings['zadv_global_frequency'] = settings.startup["zadv_global_frequency"].value
ZADV.Settings['zadv_starting_radius'] = settings.startup["zadv_starting_radius"].value
ZADV.Settings['zadv_disable_in_pvp'] = settings.startup["zadv_disable_in_pvp"].value


local areas = require 'areas' or {}
debug(2, "Requesting [%s] areas", areas.ModName)
ZADV.Data[areas.ModName] = ZADV.Data[areas.ModName] or {}
for name,area in pairs(areas.area) do if area.bp:len() > 0 then
	ZADV.Data[areas.ModName][name] = area
end end

areas = require 'areas-updates' or {}
ZADV.Data[areas.ModName] = ZADV.Data[areas.ModName] or {}
for name,area in pairs(areas.area) do
	ZADV.Data[areas.ModName][name] = area
end

ZADV.backup['piercing-rounds-magazine'] 	= table.deepcopy(data.raw.ammo['piercing-rounds-magazine'])
ZADV.backup['cannon-shell'] 				= table.deepcopy(data.raw.ammo['cannon-shell'])
ZADV.backup['flamethrower-ammo'] 			= table.deepcopy(data.raw.ammo['flamethrower-ammo'])
ZADV.backup['panimations'] 					= table.deepcopy(data.raw.player.player.animations)
ZADV.backup['medium-biter-corpse'] 			= table.deepcopy(data.raw['corpse']['medium-biter-corpse'])
ZADV.backup['medium-biter'] 				= table.deepcopy(data.raw['unit']['medium-biter'])
ZADV.backup['behemoth-biter'] 				= table.deepcopy(data.raw['unit']['behemoth-spitter'])
ZADV.backup['spitter-spawner']				= table.deepcopy(data.raw['unit-spawner']['spitter-spawner'])
ZADV.backup['biter-spawner'] 				= table.deepcopy(data.raw['unit-spawner']['biter-spawner'])
ZADV.backup['submachine-gun'] 				= table.deepcopy(data.raw['gun']['submachine-gun'])
ZADV.backup['tank-machine-gun'] 			= table.deepcopy(data.raw['gun']['tank-machine-gun'])
ZADV.backup['flamethrower'] 				= table.deepcopy(data.raw['gun']['flamethrower'])
ZADV.backup['roboport'] 					= table.deepcopy(data.raw['roboport']['roboport'])
ZADV.backup['ent-transport-belt']			= table.deepcopy(data.raw['transport-belt']['transport-belt'])
ZADV.backup['ent-fast-transport-belt']		= table.deepcopy(data.raw['transport-belt']['fast-transport-belt'])
ZADV.backup['ent-express-transport-belt']	= table.deepcopy(data.raw['transport-belt']['express-transport-belt'])
ZADV.backup['wall-stone-wall'] 				= table.deepcopy(data.raw['wall']['stone-wall'])
ZADV.backup['car']							= table.deepcopy(data.raw['car']['car'])
ZADV.backup['iron-chest'] 					= table.deepcopy(data.raw['container']['iron-chest'])
ZADV.backup['simple-entity-with-force']		= table.deepcopy(data.raw['simple-entity-with-force']['simple-entity-with-force'])
ZADV.backup['item-car']						= table.deepcopy(data.raw['item-with-entity-data']['car'])
ZADV.backup['iron-gear-wheel'] 				= table.deepcopy(data.raw.recipe['iron-gear-wheel'])
ZADV.backup['recipe-transport-belt']		= table.deepcopy(data.raw.recipe['transport-belt'])
ZADV.backup['recipe-fast-transport-belt']	= table.deepcopy(data.raw.recipe['fast-transport-belt'])
ZADV.backup['recipe-express-transport-belt']= table.deepcopy(data.raw.recipe['express-transport-belt'])
ZADV.backup['recipe-lubricant']				= table.deepcopy(data.raw.recipe['lubricant'])
ZADV.backup['stone-brick'] 					= table.deepcopy(data.raw.item['stone-brick'])
ZADV.backup['item-stone-wall'] 				= table.deepcopy(data.raw.item['stone-wall'])
ZADV.backup['item-transport-belt']			= table.deepcopy(data.raw.item['transport-belt'])
ZADV.backup['item-fast-transport-belt']		= table.deepcopy(data.raw.item['fast-transport-belt'])
ZADV.backup['item-express-transport-belt']	= table.deepcopy(data.raw.item['express-transport-belt'])
ZADV.backup['coin'] 						= table.deepcopy(data.raw.item['coin'])
ZADV.backup['lubricant'] 					= table.deepcopy(data.raw.fluid['lubricant'])
ZADV.backup['concrete'] 					= table.deepcopy(data.raw.tile['concrete'])
ZADV.backup['stone-path'] 					= table.deepcopy(data.raw.tile['stone-path'])

