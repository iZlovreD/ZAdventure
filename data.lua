require 'stdlib/table'

ZADV = {}
ZADV.Data = {}
ZADV.Settings = {}
ZADV.debug = 0

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

local ModName = "ZADV_Base"
local areas = require 'areas' or {}

debug(2, "Requesting [%s] areas", ModName)

for name,data in pairs(areas) do if data.bp:len() > 0 then

	ZADV.Data[ModName] = ZADV.Data[ModName] or {}
	ZADV.Data[ModName][name] = data
	
end end
