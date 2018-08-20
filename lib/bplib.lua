local zzlib = require("format/zzlib")
local json = require("format/json")
require "util"

BPlib = {}

local function prepareInput(input)
	if type(input) == 'string' and input:sub(1,1) == '0' then
		return input:sub(2,#input)
	else
		return input
	end
end

function BPlib.ParseToArray(input)
	return json.parse(BPlib.ParseToJson(input))
end

function BPlib.ParseToJson(input)
	return zzlib.inflate(util.decode(prepareInput(input)))
end

function BPlib.CalculateAreaData(input)
	
	local arr = BPlib.ParseToArray(input)
	
	local ret = {}
	local area = {
		left_top 	 = {x=0,y=0},
		right_bottom = {x=1,y=1},
		size 		 = {x=1,y=1},
		dim			 = {x=1,y=1},
		offset 		 = {x=0,y=0}
	} 
	
	if arr["blueprint"] then
		
		local _names = {}
		local _techs = {}
		ret.names = false
		ret.techs = false
		arr = arr["blueprint"]
		
		if arr['entities'] then for _,v in pairs(arr['entities']) do
			area.left_top.x 	= v.position.x < area.left_top.x 	 and v.position.x or area.left_top.x
			area.left_top.y 	= v.position.y > area.left_top.y 	 and v.position.y or area.left_top.y
			area.right_bottom.x = v.position.x > area.right_bottom.x and v.position.x or area.right_bottom.x
			area.right_bottom.y = v.position.y < area.right_bottom.y and v.position.y or area.right_bottom.y
			
			-- store unique names
			_names[v.name] = true
			
		end ret.names = {} end
		
		if arr['tiles'] then for _,v in pairs(arr['tiles']) do
			area.left_top.x 	= v.position.x < area.left_top.x 	 and v.position.x or area.left_top.x
			area.left_top.y 	= v.position.y > area.left_top.y 	 and v.position.y or area.left_top.y
			area.right_bottom.x = v.position.x > area.right_bottom.x and v.position.x or area.right_bottom.x
			area.right_bottom.y = v.position.y < area.right_bottom.y and v.position.y or area.right_bottom.y
		end end
		
		if ret.names then for n in pairs(_names) do
			
			-- save entity names to array
			table.insert(ret.names, n)
			
			local recipes = {}
			for _,r in pairs(data.raw.recipe) do
				if r.result and r.result == n then recipes[r.name]=true end
				if r.results then for _,p in pairs(r.results) do
					if p.name == n then recipes[r.name]=true end end end
				if r.normal or r.expensive then
					if r.normal and r.normal.result and r.normal.result == n then recipes[r.name]=true end
					if r.expensive and r.expensive.result and r.expensive.result == n then recipes[r.name]=true end
					if r.normal and r.normal.results then for _,p in pairs(r.normal.results) do
						if p.name == n then recipes[r.name]=true end end end
					if r.expensive and r.expensive.results then for _,p in pairs(r.expensive.results) do
						if p.name == n then recipes[r.name]=true end end end
				end
			end
			
			for _,t in pairs(data.raw.technology) do
			if t.effects then for _,e in pairs(t.effects) do
				if e.type == "unlock-recipe" then
				for r in pairs(recipes) do
					if e.recipe == r then _techs[t.name]=true end
				end end
			end end end

		end end
		
		-- save needed technology names to array
		for n in pairs(_techs) do
			ret.techs = ret.techs or {}
			table.insert(ret.techs, n)
		end
		
		area.right_bottom.x = area.right_bottom.x < 0 and area.right_bottom.x or math.max(1,area.right_bottom.x)
		area.right_bottom.y = area.right_bottom.y < 0 and area.right_bottom.y or math.max(1,area.right_bottom.y)
		
		area.size.x = math.ceil(math.max(1, math.abs(area.left_top.x - area.right_bottom.x)))
		area.size.y = math.ceil(math.max(1, math.abs(area.right_bottom.y - area.left_top.y)))
		
		area.dim.y = math.max(1, math.ceil(area.size.y / 32))
		area.dim.x = math.max(1, math.ceil(area.size.x / 32))
		
		area.offset.y = math.floor((area.size.y- 32) / 2 + 16)
		area.offset.x = math.floor((area.size.x- 32) / 2 + 16)
		
	end
	
	ret.area = area
	
	return ret
end

function BPlib.serialize(input)
	input = type(input) == 'function' and serpent.block(input) or input
	return json.stringify(input)
end

return BPlib
