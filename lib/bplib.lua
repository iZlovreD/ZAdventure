local base64 = require("format/base64")
local zzlib = require("format/zzlib")
local json = require("format/json")


BPlib = {}

BPlib.chunkMarker ="0eNqtmt1u4jAQhd/F10GK7fFPeJVVL9jitpZoQCFdbRfl3ReasOrFhsRz5goBms/n2EM8xnNRPw8f6dTltlfbi8rPx/astj8u6pxf293h9ln/eUpqq3Kf3lWl2t377V2XXnKb9pu33Z9dt99cw5671Cc1VCq3+/RbbfXwVKk+H9LIOx3Puc/H9ka8frvRvlKfX6/DEnRzSC/9lfwA4iQghEO0XWZ0+fXtMYQkIA6COInVcRJKSEIJzS/xt9SdDfzfsq6Kw6zbSXXx6GOgNqVxZhqQGah1aZyeBmQG6ro0rp4GrJFsmiCNACMKMIIAwwswnACDBBhWgGEEGBpn1NDzY2RoAYYRYFgBBgkwnADDCzCCACMKMBqE0Qg8TxtcRhSQEXEZQUBGwGV4ARkel+EEZLjZreXhPu9md5M1YZYXZnhhmhVWs6J4Y/GM8WaRt2RQnpJAnhIvT4nlmXDPVsCz5Xm2LM8W92wEPBueZ8PybHDPWuK8w/OsV1fBS/Jx8cTSjsx8wUFziVE48fjpAz971JxZX12OzunWAnPOS3ZWlmnUrxHwy3ugsZ5nBvVrBfzyNi3WnmVRvyTgl1eYEKt+Jlb5TKzqmVjFM3FqZ+KUzsSpnIlTOLNqSEJz0wnkpkNFeAERHhURBEQEVEQUEBFREY2AiGb1f+tLiIgjAo7wOMLhCMIRFkcYHKFhRI3mt0YBBgVYFEAowKEAjwICCogoADmo1Lx7z/uNTmEB8++a1bDiilUa3r31/Ra5VKVd3yEwf+yzvA6B+1W75YUBv6OSxoh524TrcBI63PpGnmUI4RBt4RlB+okKWmdGxFM1Nmhtv/VzVepX6s5fUB+DMVE3dTDD8BfNbptu"

local function prepareInput(input)
	if type(input) == 'string' and input:sub(1,1) == '0' then
		return input:sub(2,#input)
	else
		return input
	end
end

function BPlib.ParseToArray(input)
	return json.parse(zzlib.inflate(base64.decode(prepareInput(input))))
end


function BPlib.CalculateAreaData(input)
	
	local arr = BPlib.ParseToArray(input)
	
	local ret = {}
	local area = {
		left_top 	 = {x=0,y=0},
		right_bottom = {x=0,y=0},
		size 		 = {x=0,y=0},
		dim			 = {x=0,y=0},
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
					if r.normal.result and r.normal.result == n then recipes[r.name]=true end
					if r.expensive.result and r.expensive.result == n then recipes[r.name]=true end
					if r.normal.results then for _,p in pairs(r.normal.results) do
						if p.name == n then recipes[r.name]=true end end end
					if r.expensive.results then for _,p in pairs(r.expensive.results) do
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
		
		for n in pairs(_techs) do
		
			ret.techs = ret.techs or {}
			
			-- save needed technology names to array
			table.insert(ret.techs, n)
			
		end
		
		area.size.x = math.max(1, math.abs(area.left_top.x - area.right_bottom.x))
		area.size.y = math.max(1, math.abs(area.right_bottom.y - area.left_top.y))
		
		area.dim.y = math.max(1, math.ceil(area.size.y / 32))
		area.dim.x = math.max(1, math.ceil(area.size.x / 32))
		
		area.offset.y = math.ceil((area.size.y - 32) / 2)
		area.offset.x = math.ceil((area.size.x - 32) / 2)
		
	end
	
	ret.area = area
	
	return ret
end

function BPlib.serialize(input)
	input = type(input) == 'function' and serpent.block(input) or input
	return json.stringify(input)
end

return BPlib
