require 'lib/bplib'

--
-- Prepare all known areas
--
for modname,list in pairs( ZADV.Data ) do	ZADV.Data[modname] = {}
	for bpname,bpdata in pairs(list) do	ZADV.Data[modname][bpname] = {}
		
		-- parse blueprint string into readable format
		local _data = BPlib.CalculateAreaData(bpdata.bp)
		
		-- save new area
		ZADV.Data[modname][bpname] = _data
		debug(2,"New Area (%s)\"%s\" [ %s x %s ] added.", modname, bpname, _data.area.size.x, _data.area.size.y)
		
		-- save additional parametres
		local function _checkvalue(value, _type, default)
			return (value and type(value) == _type) and value or default
		end
		
		-- blueprint options
		ZADV.Data[modname][bpname].bp 					=  bpdata.bp
		ZADV.Data[modname][bpname].probability 			=  math.min(100,math.max(1, bpdata.probability)) or 10
		ZADV.Data[modname][bpname].force 				= _checkvalue(bpdata.force, 'string', "neutral")
		ZADV.Data[modname][bpname].force_build 			= _checkvalue(bpdata.force_build, 'boolean', true)
		ZADV.Data[modname][bpname].finalize_build		= _checkvalue(bpdata.finalize_build, 'boolean', true)
		ZADV.Data[modname][bpname].direction 			= _checkvalue(bpdata.direction, 'number', defines.direction.north)
		ZADV.Data[modname][bpname].ignore_water 		= _checkvalue(bpdata.ignore_water, 'boolean', false)
		ZADV.Data[modname][bpname].ignore_all_collision	= _checkvalue(bpdata.ignore_all_collision, 'boolean', false)
		-- additional options
		ZADV.Data[modname][bpname].active 				= _checkvalue(bpdata.active, 'boolean', true)
		ZADV.Data[modname][bpname].armed 				= _checkvalue(bpdata.armed, 'boolean', true)
		ZADV.Data[modname][bpname].consumption_modifier	= _checkvalue(bpdata.consumption_modifier, 'number', 1.0)
		ZADV.Data[modname][bpname].destructible 		= _checkvalue(bpdata.destructible, 'boolean', true)
		ZADV.Data[modname][bpname].remains 				= _checkvalue(bpdata.remains, 'string', false)
		ZADV.Data[modname][bpname].energy_stored 		= _checkvalue(bpdata.energy_stored, 'number', 0.0)
		ZADV.Data[modname][bpname].health 				= _checkvalue(bpdata.health, 'integer', 100)
		ZADV.Data[modname][bpname].operable 			= _checkvalue(bpdata.operable, 'boolean', true)
		ZADV.Data[modname][bpname].order_deconstruction = _checkvalue(bpdata.order_deconstruction, 'boolean', false)
		ZADV.Data[modname][bpname].rotatable 			= _checkvalue(bpdata.rotatable, 'boolean', true)
		-- events
		ZADV.Data[modname][bpname].message 				= _checkvalue(bpdata.message, 'string', "")
		ZADV.Data[modname][bpname].script 				= _checkvalue(bpdata.script, 'function', function(self) local data = self; end)
		
	end
end


--
-- Store Prepared Data to Control
--
debug(2,'\n'.. serpent.block(ZADV))
local dump = serpent.dump(ZADV.Data)
local chunks = math.floor(#dump / 199) + 1

	-- remember number of chunks
	data:extend({
	{
		type = "flying-text",
		name = "ZADV_DATA_C",
		time_to_live = 0,
		speed = 1,
		order = "".. chunks+1
	}})
	
	-- remember debug level
	data:extend({
	{
		type = "flying-text",
		name = "ZADV_DATA_D",
		time_to_live = 0,
		speed = 1,
		order = "".. ZADV.debug
	}})

-- write data chunks
for i=0, chunks do

	local name = "ZADV_DATA_"..i
	
	data:extend({
	{
		type = "flying-text",
		name = name,
		time_to_live = 0,
		speed = 1,
		order = dump:sub(i*199, (i+1)*199-1)
	}})
	
end

