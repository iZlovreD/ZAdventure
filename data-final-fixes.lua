require 'lib/bplib'
local md5 = require("lib/format/md5")

--
-- Prepare all known areas
--
local delete = {}
local replace_data = {}
local counter = 0
local replaced = 0
for modname,list in pairs( ZADV.Data ) do
for bpname,bpdata in pairs(list) do
	
	-- check for empty area
	if bpdata.bp and type(bpdata.bp) == "string" and bpdata.bp:len() > 0
	and ((settings.startup["zadv_experemental"].value and bpdata.experemental) or not bpdata.experemental)
	and ((settings.startup["zadv_dangerous"].value and bpdata.dangerous) or not bpdata.dangerous) then
	
		-- save area name
		ZADV.NamePairList = ZADV.NamePairList or {}
		if not bpdata.update_for then table.insert(ZADV.NamePairList, {modname,bpname} ) end
		
		-- prepare control string
		ZADV.ControlString = (ZADV.ControlString or "") .. modname .. bpname
		
		-- parse blueprint string into readable format
		local _data = BPlib.CalculateAreaData(bpdata.bp)
		
		-- check area size
		local maxsize = 2^6
		if _data.area.size.x <= maxsize and _data.area.size.y <= maxsize then
		
			ZADV.Data[modname] = ZADV.Data[modname] or {}
			
			-- save new area
			ZADV.Data[modname][bpname] = _data
			debug(0,'New Area "%s - %s" [%s:%s] added.', modname, bpname, _data.area.size.x, _data.area.size.y)
			
			-- check additional parametres
			local function _checkvalue(value, _type, default)
				local ret = ""
				if type(value) == _type then ret = value else ret = default end
				ZADV.ControlString = ZADV.ControlString .. tostring(ret)
				return ret
			end
			
			-- blueprint options
			ZADV.Data[modname][bpname].bp 					=  bpdata.bp
			ZADV.Data[modname][bpname].name 				=  modname ..'-'.. bpname
			ZADV.Data[modname][bpname].probability 			=  math.min(1000,math.max(1, bpdata.probability or 10)) or 10
			ZADV.Data[modname][bpname].remoteness_min 		= _checkvalue(bpdata.remoteness_min, 'number', 10)
			ZADV.Data[modname][bpname].remoteness_max 		= _checkvalue(bpdata.remoteness_max, 'number', 0)
			ZADV.Data[modname][bpname].only_once 			= _checkvalue(bpdata.only_once, 'boolean', false)
			ZADV.Data[modname][bpname].max_copies 			= _checkvalue(bpdata.max_copies, 'number', 0)
			ZADV.Data[modname][bpname].ignore_technologies	= _checkvalue(bpdata.ignore_technologies, 'boolean', true)
			ZADV.Data[modname][bpname].force 				= _checkvalue(bpdata.force, 'string', "neutral")
			ZADV.Data[modname][bpname].force_build 			= _checkvalue(bpdata.force_build, 'boolean', true)
			ZADV.Data[modname][bpname].random_direction 	= _checkvalue(bpdata.random_direction, 'boolean', false)
			ZADV.Data[modname][bpname].finalize_build		= _checkvalue(bpdata.finalize_build, 'boolean', true)
			ZADV.Data[modname][bpname].force_reveal			= _checkvalue(bpdata.force_reveal, 'boolean', false)
			ZADV.Data[modname][bpname].ignore_water 		= _checkvalue(bpdata.ignore_water, 'boolean', false)
			ZADV.Data[modname][bpname].ignore_all_collision	= _checkvalue(bpdata.ignore_all_collision, 'boolean', false)
			
			-- additional options
			ZADV.Data[modname][bpname].active 				= _checkvalue(bpdata.active, 'boolean', true)
			ZADV.Data[modname][bpname].minable 				= _checkvalue(bpdata.minable, 'boolean', true)
			ZADV.Data[modname][bpname].destructible 		= _checkvalue(bpdata.destructible, 'boolean', true)
			ZADV.Data[modname][bpname].remains 				= _checkvalue(bpdata.remains, 'string', false)
			ZADV.Data[modname][bpname].health 				= _checkvalue(bpdata.health, 'number', 100)
			ZADV.Data[modname][bpname].operable 			= _checkvalue(bpdata.operable, 'boolean', true)
			ZADV.Data[modname][bpname].order_deconstruction = _checkvalue(bpdata.order_deconstruction, 'boolean', false)
			ZADV.Data[modname][bpname].rotatable 			= _checkvalue(bpdata.rotatable, 'boolean', true)
			
			-- other
			ZADV.Data[modname][bpname].userdata 			= bpdata.userdata and bpdata.userdata or {}
			ZADV.Data[modname][bpname].ScriptForEach 		= (bpdata.ScriptForEach and type(bpdata.ScriptForEach) == 'function') and bpdata.ScriptForEach or function() end
			ZADV.Data[modname][bpname].ScriptForAll 		= (bpdata.ScriptForAll and type(bpdata.ScriptForAll) == 'function') and bpdata.ScriptForAll or function() end
			ZADV.Data[modname][bpname].messages 			= (bpdata.messages and type(bpdata.messages) == 'table') and bpdata.messages or { { msg = "", color = {r=0.31, g=0.70, b=1, a=0.8} } }
			
			ZADV.Data[modname][bpname].remoteness_min 		= ZADV.Settings['zadv_starting_radiius'] + ZADV.Data[modname][bpname].remoteness_min
			ZADV.Data[modname][bpname].remoteness_max 		= ZADV.Data[modname][bpname].remoteness_max == 0 and 0 or ZADV.Settings['zadv_starting_radiius'] + ZADV.Data[modname][bpname].remoteness_max
			ZADV.Data[modname][bpname].max_copies 			= ZADV.Data[modname][bpname].max_copies <= 0 and -1 or ZADV.Data[modname][bpname].max_copies
			
			ZADV.ControlString = ZADV.ControlString .. md5.sumhexa(BPlib.serialize(ZADV.Data[modname][bpname].update_for or " "))
			ZADV.ControlString = ZADV.ControlString .. md5.sumhexa(BPlib.serialize(ZADV.Data[modname][bpname].userdata))
			ZADV.ControlString = ZADV.ControlString .. md5.sumhexa(BPlib.serialize(ZADV.Data[modname][bpname].ScriptForEach))
			ZADV.ControlString = ZADV.ControlString .. md5.sumhexa(BPlib.serialize(ZADV.Data[modname][bpname].ScriptForAll))
			ZADV.ControlString = ZADV.ControlString .. md5.sumhexa(BPlib.serialize(ZADV.Data[modname][bpname].messages))
			ZADV.ControlString = ZADV.ControlString .. md5.sumhexa(BPlib.serialize(ZADV.Data[modname][bpname].names_accordance))
			
			if bpdata.update_for then
				bpdata.update_for.data = {}
				bpdata.update_for.data._mod = modname
				bpdata.update_for.data._area = bpname
				bpdata.update_for.data = ZADV.Data[modname][bpname]
				table.insert(replace_data, bpdata.update_for)
			end
			
			counter = counter+1
			
		else
			table.insert(delete, 'ZADV.Data["'.. modname ..'"]["'.. bpname ..'"] = nil')
			debug(1,'Area "%s-%s" bigger than %s tiles in one of dimension, skiping..', modname, bpname, maxsize)
		end
	
end end end

-- last preparations
ZADV.ControlString = md5.sumhexa(ZADV.ControlString:gsub("[_- ]",''))
for _,com in pairs(delete) do local _=loadstring(com); _() end

for _,rep in pairs(replace_data) do
	if  ( rep.mod and type(rep.mod) == 'string' and rep.mod ~= "" )
	and ( rep.area and type(rep.area) == 'string' and rep.area ~= "" )
	and ZADV.Data[rep.mod][rep.area] then
		
		ZADV.Data[rep.mod][rep.area] = nil
		ZADV.Data[rep.mod][rep.area] = rep.data
		ZADV.Data[rep._mod][rep._area] = nil
		
		replaced = replaced+1
		
	end
end

debug(0,'-------------------------------------')
debug(0,' %s Areas added and %s replaced.', counter, replaced)


--
-- Store Prepared Data to Control
--
debug(0,ZADV)
local dump = serpent.dump(ZADV.Data)
local chunks = math.floor(#dump / 199) + 1
local sdump = serpent.dump(ZADV.Settings)
local schunks = math.floor(#sdump / 199) + 1
local ndump = serpent.dump(ZADV.NamePairList)
local nchunks = math.floor(#ndump / 199) + 1

	-- remember number of chunks
	data:extend({
	{
		type = "flying-text",
		name = "ZADV_DATA_C",
		time_to_live = 0,
		speed = 1,
		order = "".. chunks+1
	},
	{
		type = "flying-text",
		name = "ZADV_SDATA_C",
		time_to_live = 0,
		speed = 1,
		order = "".. schunks+1
	},
	{
		type = "flying-text",
		name = "ZADV_NDATA_C",
		time_to_live = 0,
		speed = 1,
		order = "".. nchunks+1
	},
	-- remember ControlString
	{
		type = "flying-text",
		name = "ZADV_DATA_MD",
		time_to_live = 0,
		speed = 1,
		order = "".. ZADV.ControlString
	},
	-- remember debug level
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
		order = "".. dump:sub(i*199, (i+1)*199-1)
	}})
end
for i=0, schunks do
	local name = "ZADV_SDATA_"..i
	data:extend({
	{
		type = "flying-text",
		name = name,
		time_to_live = 0,
		speed = 1,
		order = "".. sdump:sub(i*199, (i+1)*199-1)
	}})
end
for i=0, nchunks do
	local name = "ZADV_NDATA_"..i
	data:extend({
	{
		type = "flying-text",
		name = name,
		time_to_live = 0,
		speed = 1,
		order = "".. ndump:sub(i*199, (i+1)*199-1)
	}})
end

local slow_path = table.deepcopy(data.raw.tile['stone-path'])
slow_path.name = "zadv-slow-path-30"
slow_path.walking_speed_modifier = 0.7
slow_path.decorative_removal_probability = 0
slow_path.vehicle_friction_modifier = nil
data:extend({slow_path})

local slow_path2 = table.deepcopy(slow_path)
slow_path2.name = "zadv-slow-path-50"
slow_path2.walking_speed_modifier = 0.5
data:extend({slow_path2})

local slow_path3 = table.deepcopy(slow_path)
slow_path3.name = "zadv-slow-path-70"
slow_path3.walking_speed_modifier = 0.3
data:extend({slow_path3})


local slow_brick = table.deepcopy(data.raw.item['stone-brick'])
slow_brick.name = "zadv-slow-brick-30"
slow_brick.flags = {}
slow_brick.stack_size = 9999
slow_brick.place_as_tile.result = "zadv-slow-path-30"
data:extend({slow_brick})

local slow_brick2 = table.deepcopy(slow_brick)
slow_brick2.name = "zadv-slow-brick-50"
slow_brick2.place_as_tile.result = "zadv-slow-path-50"
data:extend({slow_brick2})

local slow_brick3 = table.deepcopy(slow_brick)
slow_brick3.name = "zadv-slow-brick-70"
slow_brick3.place_as_tile.result = "zadv-slow-path-70"
data:extend({slow_brick3})



