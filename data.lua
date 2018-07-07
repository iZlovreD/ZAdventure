require 'stdlib/table'

ZADV = ZADV or {}
ZADV.Data = ZADV.Data or {}
ZADV.debug = 3

function debug ( level, msg, ... )
	if ZADV.debug >= tonumber(level) then log("[[ZADV]] ".. string.format(msg,...)) end
end

ZADV.Data["ZADV_Base"] = {}

ZADV.Data["ZADV_Base"] = require('areas') or {}; debug(2, "Requesting [base] areas")

