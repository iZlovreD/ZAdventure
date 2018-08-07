
ZADV = {}
ZADV.Data = {}
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
