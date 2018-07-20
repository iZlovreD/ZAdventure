require 'stdlib/table'

ZADV = {}
ZADV.Data = {}
ZADV.Settings = {}
ZADV.debug = 2

local format = string.format

function debug ( level, msg, ... )

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
ZADV.Settings['zadv_starting_radiius'] = settings.startup["zadv_starting_radiius"].value


local data = require 'areas' or {}
debug(2, "Requesting [%s] areas", data.ModName)


ZADV.Data[data.ModName] = ZADV.Data[data.ModName] or {}
for name,area in pairs(data.area) do if area.bp:len() > 0 then

	ZADV.Data[data.ModName][name] = area
	
end end


ZADV.Data.Replacements = ZADV.Data.Replacements or {}
if data.replacements then for ori,new in pairs(data.replacements) do

	ZADV.Data.Replacements[ori] = ZADV.Data.Replacements[ori] or {}
	table.insert(ZADV.Data.Replacements[ori], new)
	
end end
