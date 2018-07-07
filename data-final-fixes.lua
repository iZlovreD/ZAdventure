require 'lib/bplib'
require 'defines'

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
		ZADV.Data[modname][bpname].bp =  bpdata.bp
		ZADV.Data[modname][bpname].propability = math.min(100,math.max(1, bpdata.propability)) or 10
		
	end
end


--
-- Store Prepared Data to Control
--
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

