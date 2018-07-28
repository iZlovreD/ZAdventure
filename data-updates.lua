
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

data:extend({
  {
	type = "virtual-signal",
	name = "signal-ex",
    icon = "__ZAdventure__/graphics/icons/signal/signal_ex.png",
	icon_size = 32,
	subgroup = "virtual-signal-letter",
	order = "c[letters]-[Z]-[ex]"
  }
})
for i=0,9 do
	data:extend({
	  {
		type = "virtual-signal",
		name = "signal-y-"..i,
		icon = "__ZAdventure__/graphics/icons/signal/signal_y_".. i ..".png",
		icon_size = 32,
		subgroup = "virtual-signal-letter",
		order = "c[letters]-[9]-[0".. i .."]"
	  },
	  {
		type = "virtual-signal",
		name = "signal-r-"..i,
		icon = "__ZAdventure__/graphics/icons/signal/signal_r_".. i ..".png",
		icon_size = 32,
		subgroup = "virtual-signal-letter",
		order = "c[letters]-[9]-[1".. i .."]"
	  }
	})
end

data.raw.inserter['stack-inserter'].allow_custom_vectors = true


local spawner = table.deepcopy(data.raw['unit-spawner']['biter-spawner'])
spawner.name = "zadv-biter-spawner"
spawner.flags = {}
data:extend({spawner})

spawner = table.deepcopy(data.raw['unit-spawner']['spitter-spawner'])
spawner.name = "zadv-spitter-spawner"
spawner.flags = {}
data:extend({spawner})

