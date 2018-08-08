
local recipe = table.deepcopy(data.raw.recipe['iron-gear-wheel'])
recipe.name = "zadv-iron-gear-wheel"
recipe.enabled = true
recipe.hidden = true
recipe.flags = {'hidden'}
recipe.hidden_from_flow_stats = true
recipe.normal = nil
recipe.expensive = nil
recipe.ingredients = { {"iron-plate", 2} }
recipe.result = "iron-gear-wheel"
data:extend({recipe})

recipe = table.deepcopy(data.raw.recipe['transport-belt'])
recipe.name = "zadv-transport-belt"
recipe.enabled = true
recipe.hidden = true
recipe.flags = {'hidden'}
recipe.hidden_from_flow_stats = true
recipe.normal = nil
recipe.expensive = nil
recipe.ingredients =
	{
		{"iron-plate", 1},
		{"iron-gear-wheel", 1}
	}
recipe.result = "transport-belt"
data:extend({recipe})

recipe = table.deepcopy(data.raw.recipe['fast-transport-belt'])
recipe.name = "zadv-fast-transport-belt"
recipe.enabled = true
recipe.hidden = true
recipe.flags = {'hidden'}
recipe.hidden_from_flow_stats = true
recipe.normal = nil
recipe.expensive = nil
recipe.ingredients =
	{
		{"iron-gear-wheel", 2},
		{"transport-belt", 1}
	}
recipe.result = "fast-transport-belt"
data:extend({recipe})

recipe = table.deepcopy(data.raw.recipe['transport-belt'])
recipe.name = "zadv-transport-belt-slow"
recipe.enabled = true
recipe.hidden = true
recipe.flags = {'hidden'}
recipe.energy_required = 8
recipe.hidden_from_flow_stats = true
recipe.normal = nil
recipe.expensive = nil
recipe.ingredients =
	{
		{"iron-plate", 1},
		{"iron-gear-wheel", 1}
	}
recipe.result = "transport-belt"
data:extend({recipe})

recipe = table.deepcopy(data.raw.recipe['fast-transport-belt'])
recipe.name = "zadv-fast-transport-belt-slow"
recipe.enabled = true
recipe.hidden = true
recipe.flags = {'hidden'}
recipe.energy_required = 12
recipe.hidden_from_flow_stats = true
recipe.normal = nil
recipe.expensive = nil
recipe.ingredients =
	{
		{"iron-gear-wheel", 2},
		{"transport-belt", 1}
	}
recipe.result = "fast-transport-belt"
data:extend({recipe})
	
recipe = table.deepcopy(data.raw.recipe['express-transport-belt'])
recipe.name = "zadv-express-transport-belt-slow"
recipe.enabled = true
recipe.hidden = true
recipe.flags = {'hidden'}
recipe.energy_required = 19
recipe.hidden_from_flow_stats = true
recipe.normal = nil
recipe.expensive = nil
recipe.ingredients =
	{
		{"iron-gear-wheel", 5},
		{"fast-transport-belt", 1},
		{type="fluid", name="lubricant", amount=20}
	}
recipe.result = "express-transport-belt"
data:extend({recipe})


local slow_path = table.deepcopy(data.raw.tile['stone-path'])
slow_path.name = "zadv-slow-path-30"
slow_path.minable = nil
slow_path.walking_speed_modifier = 0.7
slow_path.decorative_removal_probability = 0
slow_path.vehicle_friction_modifier = 0.7
data:extend({slow_path})

local slow_path2 = table.deepcopy(slow_path)
slow_path2.name = "zadv-slow-path-50"
slow_path2.walking_speed_modifier = 0.5
slow_path.vehicle_friction_modifier = 0.5
data:extend({slow_path2})

local slow_path3 = table.deepcopy(slow_path)
slow_path3.name = "zadv-slow-path-70"
slow_path3.walking_speed_modifier = 0.3
slow_path.vehicle_friction_modifier = 0.3
data:extend({slow_path3})


local slow_brick = table.deepcopy(data.raw.item['stone-brick'])
slow_brick.name = "zadv-slow-brick-30"
slow_brick.flags = {'hidden'}
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


local spawner = table.deepcopy(data.raw['unit']['medium-biter'])
spawner.name = "zadv-medium-biter"
spawner.flags = {"placeable-off-grid", "breaths-air", "not-repairable"}
spawner.max_health = 350
spawner.healing_per_tick = 0.04
spawner.attack_parameters.cooldown = 25
spawner.vision_distance = 65
data:extend({spawner})

spawner = table.deepcopy(data.raw['unit']['big-biter'])
spawner.name = "zadv-big-biter"
spawner.flags = {"placeable-off-grid", "breaths-air", "not-repairable"}
spawner.max_health = 1350
spawner.healing_per_tick = 0.04
spawner.attack_parameters.cooldown = 25
spawner.vision_distance = 45
data:extend({spawner})

spawner = table.deepcopy(data.raw['unit']['behemoth-biter'])
spawner.name = "zadv-behemoth-biter"
spawner.flags = {"placeable-off-grid", "breaths-air"}
spawner.max_health = 6500
spawner.healing_per_tick = 0.04
spawner.attack_parameters.cooldown = 25
data:extend({spawner})


spawner = table.deepcopy(data.raw['unit']['medium-spitter'])
spawner.name = "zadv-medium-spitter"
spawner.flags = {"placeable-off-grid", "breaths-air", "not-repairable"}
spawner.max_health = 350
spawner.healing_per_tick = 0.04
spawner.attack_parameters.cooldown = 55
spawner.vision_distance = 65
data:extend({spawner})

spawner = table.deepcopy(data.raw['unit']['big-spitter'])
spawner.name = "zadv-big-spitter"
spawner.flags = {"placeable-off-grid", "breaths-air", "not-repairable"}
spawner.max_health = 1350
spawner.healing_per_tick = 0.04
spawner.attack_parameters.cooldown = 75
spawner.vision_distance = 45
data:extend({spawner})

spawner = table.deepcopy(data.raw['unit']['behemoth-spitter'])
spawner.name = "zadv-behemoth-spitter"
spawner.flags = {"placeable-off-grid", "breaths-air"}
spawner.max_health = 6500
spawner.healing_per_tick = 0.04
spawner.attack_parameters.cooldown = 85
data:extend({spawner})


spawner = table.deepcopy(data.raw['unit-spawner']['biter-spawner'])
spawner.name = "zadv-biter-spawner"
spawner.flags = {"placeable-neutral"}
spawner.max_health = 2350
spawner.autoplace = nil
spawner.result_units = {
	{"small-biter", {{0.0, 0.3}, {0.6, 0.0}}},
	{"zadv-medium-biter", {{0.2, 0.0}, {0.6, 0.3}, {0.7, 0.1}}},
	{"zadv-big-biter", {{0.5, 0.0}, {1.0, 0.4}}},
	{"zadv-behemoth-biter", {{0.9, 0.0}, {1.0, 0.3}}}
}
data:extend({spawner})

spawner = table.deepcopy(data.raw['unit-spawner']['spitter-spawner'])
spawner.name = "zadv-spitter-spawner"
spawner.flags = {"placeable-neutral"}
spawner.max_health = 2350
spawner.autoplace = nil
spawner.result_units = {
	{"small-biter", {{0.0, 0.3}, {0.35, 0}}},
	{"small-spitter", {{0.25, 0.0}, {0.5, 0.3}, {0.7, 0.0}}},
	{"zadv-medium-spitter", {{0.4, 0.0}, {0.7, 0.3}, {0.9, 0.1}}},
	{"zadv-big-spitter", {{0.5, 0.0}, {1.0, 0.4}}},
	{"zadv-behemoth-spitter", {{0.9, 0.0}, {1.0, 0.3}}}
}
data:extend({spawner})

spawner = table.deepcopy(data.raw['roboport']['roboport'])
spawner.name = "zadv-roboport"
spawner.flags = {}
spawner.minable = nil
spawner.max_health = 5000
spawner.collision_box = nil
spawner.selection_box = nil
spawner.resistances =  {
	{
		type = "fire",
		percent = 95
	},
	{
		type = "impact",
		percent = 100
	}
}
spawner.dying_explosion = "big-explosion"
spawner.energy_usage = "5kW"
spawner.logistics_radius = 25
spawner.construction_radius = 1500
spawner.charge_approach_distance = 25
spawner.draw_logistic_radius_visualization = false
spawner.draw_construction_radius_visualization = false
spawner.circuit_wire_connection_point = nil
spawner.circuit_connector_sprites = nil
spawner.circuit_wire_max_distance = nil
spawner.default_available_logistic_output_signal = nil
spawner.default_total_logistic_output_signal = nil
spawner.default_available_construction_output_signal = nil
spawner.default_total_construction_output_signal = nil
data:extend({spawner})

local racedata = table.deepcopy(data.raw['wall']['stone-wall'])
racedata.name = "zadv-race-cone"
racedata.icon = "__ZAdventure__/graphics/icons/race_cone.png"
racedata.icon_size = 32
racedata.minable = nil
racedata.destructible = nil
racedata.selection_box = nil
racedata.connected_gate_visualization = nil
racedata.pictures = {
      single =
      {
          {
            filename = "__ZAdventure__/graphics/entity/race_cone.png",
            priority = "extra-high",
            width = 256,
            height = 256,
			scale = 0.14
          }
      },
      straight_vertical =
      {
          {
            filename = "__ZAdventure__/graphics/entity/race_cone.png",
            priority = "extra-high",
            width = 256,
            height = 256,
			scale = 0.14
          }
      },
      straight_horizontal =
      {
          {
            filename = "__ZAdventure__/graphics/entity/race_cone.png",
            priority = "extra-high",
            width = 256,
            height = 256,
			scale = 0.14
          }
      },
      corner_right_down =
      {
          {
            filename = "__ZAdventure__/graphics/entity/race_cone.png",
            priority = "extra-high",
            width = 256,
            height = 256,
			scale = 0.14
          }
      },
      corner_left_down =
      {
          {
            filename = "__ZAdventure__/graphics/entity/race_cone.png",
            priority = "extra-high",
            width = 256,
            height = 256,
			scale = 0.14
          }
      },
      t_up =
      {
          {
            filename = "__ZAdventure__/graphics/entity/race_cone.png",
            priority = "extra-high",
            width = 256,
            height = 256,
			scale = 0.15,
            shift = {0, 0.95}
          }
      },
      ending_right =
      {
          {
            filename = "__ZAdventure__/graphics/entity/race_cone.png",
            priority = "extra-high",
            width = 256,
            height = 256,
			scale = 0.15,
            shift = {0, 0.95}
          }
      },
      ending_left =
      {
          {
            filename = "__ZAdventure__/graphics/entity/race_cone.png",
            priority = "extra-high",
            width = 256,
            height = 256,
			scale = 0.15,
            shift = {0, 0.95}
          }
      }
}
racedata.wall_diode_green = nil
racedata.wall_diode_green_light = nil
racedata.wall_diode_red = nil
racedata.wall_diode_red_light = nil
racedata.circuit_wire_connection_point = nil
racedata.circuit_connector_sprites = nil
racedata.circuit_wire_max_distance = nil
racedata.default_output_signal = nil
data:extend({racedata})

racedata = table.deepcopy(data.raw.item['stone-wall'])
racedata.name = "zadv-race-cone"
racedata.icon = "__ZAdventure__/graphics/icons/race_cone.png"
racedata.icon_size = 32
racedata.flags = {'hidden'}
racedata.place_result = "zadv-race-cone"
data:extend({racedata})


racedata = table.deepcopy(data.raw['car']['car'])
racedata.name = "zadv-race-car-yellow"
racedata.minable = nil
racedata.operable = nil
racedata.mined_sound = nil
racedata.guns = nil
racedata.health = 750
racedata.inventory_size = 0
racedata.stop_trigger[1].sound[1].volume = 1.2
for _,v in pairs(racedata.animation.layers[2].stripes) do
	if v.filename:find('mask') then v = nil end
end
for _,v in pairs(racedata.animation.layers[2].hr_version.stripes) do
	if v.filename:find('mask') then v = nil end
end
racedata.animation.layers[1].stripes[1].filename = "__ZAdventure__/graphics/entity/car/car-1-yellow.png"
racedata.animation.layers[1].stripes[2].filename = "__ZAdventure__/graphics/entity/car/car-2-yellow.png"
racedata.animation.layers[1].stripes[3].filename = "__ZAdventure__/graphics/entity/car/car-3-yellow.png"
racedata.animation.layers[1].hr_version.stripes[1].filename = "__ZAdventure__/graphics/entity/car/hr-car-1-yellow.png"
racedata.animation.layers[1].hr_version.stripes[2].filename = "__ZAdventure__/graphics/entity/car/hr-car-2-yellow.png"
racedata.animation.layers[1].hr_version.stripes[3].filename = "__ZAdventure__/graphics/entity/car/hr-car-3-yellow.png"
racedata.animation.layers[1].hr_version.stripes[4].filename = "__ZAdventure__/graphics/entity/car/hr-car-4-yellow.png"
racedata.animation.layers[1].hr_version.stripes[5].filename = "__ZAdventure__/graphics/entity/car/hr-car-5-yellow.png"
racedata.animation.layers[1].hr_version.stripes[6].filename = "__ZAdventure__/graphics/entity/car/hr-car-6-yellow.png"
racedata.vehicle_impact_sound.volume = 1
racedata.working_sound.sound.filename = "__ZAdventure__/sounds/eng2.ogg"
racedata.working_sound.sound.volume = 1.2
racedata.working_sound.activate_sound.filename = "__ZAdventure__/sounds/eng1.ogg"
racedata.working_sound.activate_sound.volume = 1.2
racedata.working_sound.deactivate_sound.volume = 1.2
data:extend({racedata})


racedata = table.deepcopy(racedata)
racedata.name = "zadv-race-car-green"
racedata.health = 1000
racedata.animation.layers[1].stripes[1].filename = "__ZAdventure__/graphics/entity/car/car-1-green.png"
racedata.animation.layers[1].stripes[2].filename = "__ZAdventure__/graphics/entity/car/car-2-green.png"
racedata.animation.layers[1].stripes[3].filename = "__ZAdventure__/graphics/entity/car/car-3-green.png"
racedata.animation.layers[1].hr_version.stripes[1].filename = "__ZAdventure__/graphics/entity/car/hr-car-1-green.png"
racedata.animation.layers[1].hr_version.stripes[2].filename = "__ZAdventure__/graphics/entity/car/hr-car-2-green.png"
racedata.animation.layers[1].hr_version.stripes[3].filename = "__ZAdventure__/graphics/entity/car/hr-car-3-green.png"
racedata.animation.layers[1].hr_version.stripes[4].filename = "__ZAdventure__/graphics/entity/car/hr-car-4-green.png"
racedata.animation.layers[1].hr_version.stripes[5].filename = "__ZAdventure__/graphics/entity/car/hr-car-5-green.png"
racedata.animation.layers[1].hr_version.stripes[6].filename = "__ZAdventure__/graphics/entity/car/hr-car-6-green.png"
data:extend({racedata})


racedata = table.deepcopy(racedata)
racedata.name = "zadv-race-car-red"
racedata.health = 500
racedata.animation.layers[1].stripes[1].filename = "__ZAdventure__/graphics/entity/car/car-1-red.png"
racedata.animation.layers[1].stripes[2].filename = "__ZAdventure__/graphics/entity/car/car-2-red.png"
racedata.animation.layers[1].stripes[3].filename = "__ZAdventure__/graphics/entity/car/car-3-red.png"
racedata.animation.layers[1].hr_version.stripes[1].filename = "__ZAdventure__/graphics/entity/car/hr-car-1-red.png"
racedata.animation.layers[1].hr_version.stripes[2].filename = "__ZAdventure__/graphics/entity/car/hr-car-2-red.png"
racedata.animation.layers[1].hr_version.stripes[3].filename = "__ZAdventure__/graphics/entity/car/hr-car-3-red.png"
racedata.animation.layers[1].hr_version.stripes[4].filename = "__ZAdventure__/graphics/entity/car/hr-car-4-red.png"
racedata.animation.layers[1].hr_version.stripes[5].filename = "__ZAdventure__/graphics/entity/car/hr-car-5-red.png"
racedata.animation.layers[1].hr_version.stripes[6].filename = "__ZAdventure__/graphics/entity/car/hr-car-6-red.png"
data:extend({racedata})


racedata = table.deepcopy(data.raw['item-with-entity-data']['car'])
racedata.name = "zadv-race-car-yellow"
racedata.icon = "__ZAdventure__/graphics/icons/car-yellow.png"
racedata.flags = {"hidden"}
racedata.place_result = "zadv-race-car-yellow"
data:extend({racedata})

racedata = table.deepcopy(racedata)
racedata.name = "zadv-race-car-green"
racedata.icon = "__ZAdventure__/graphics/icons/car-green.png"
racedata.place_result = "zadv-race-car-green"
data:extend({racedata})

racedata = table.deepcopy(racedata)
racedata.name = "zadv-race-car-red"
racedata.icon = "__ZAdventure__/graphics/icons/car-red.png"
racedata.place_result = "zadv-race-car-red"
data:extend({racedata})


racedata = table.deepcopy(data.raw['transport-belt']['transport-belt'])
racedata.name = "zadv-race-belt-1"
racedata.minable = nil
racedata.mined_sound = nil
racedata.selection_box = nil
racedata.working_sound = nil
racedata.circuit_wire_max_distance = 0
racedata.speed = 0.09375
racedata.layer = 1
data:extend({racedata})

racedata = table.deepcopy(data.raw['transport-belt']['express-transport-belt'])
racedata.name = "zadv-race-belt-2"
racedata.minable = nil
racedata.mined_sound = nil
racedata.selection_box = nil
racedata.working_sound = nil
racedata.circuit_wire_max_distance = 0
racedata.speed = 0.12500
racedata.layer = 1
data:extend({racedata})

racedata = table.deepcopy(data.raw['transport-belt']['fast-transport-belt'])
racedata.name = "zadv-race-belt-3"
racedata.flags = {}
racedata.minable = nil
racedata.mined_sound = nil
racedata.selection_box = nil
racedata.working_sound = nil
racedata.circuit_wire_max_distance = 0
racedata.speed = 0.15625
racedata.layer = 1
data:extend({racedata})

racedata = table.deepcopy(data.raw.item['transport-belt'])
racedata.name = "zadv-race-belt-1"
racedata.flags = {'hidden'}
racedata.place_result = racedata.name
data:extend({racedata})
racedata = table.deepcopy(data.raw.item['fast-transport-belt'])
racedata.name = "zadv-race-belt-2"
racedata.flags = {'hidden'}
racedata.place_result = racedata.name
data:extend({racedata})
racedata = table.deepcopy(data.raw.item['express-transport-belt'])
racedata.name = "zadv-race-belt-3"
racedata.flags = {'hidden'}
racedata.place_result = racedata.name
data:extend({racedata})

racedata = table.deepcopy(data.raw['container']['iron-chest'])
racedata.name = "zadv-race-trophy"
racedata.icon = "__ZAdventure__/graphics/icons/trophy.png"
racedata.flags = {}
racedata.minable = nil
racedata.selection_box = {{-0.8, -1.7}, {0.8, 0.4}}
racedata.open_sound = nil
racedata.close_sound = nil
racedata.inventory_size = 29
racedata.picture.filename = "__ZAdventure__/graphics/entity/trophy.png"
racedata.picture.width = 256
racedata.picture.height = 256
racedata.picture.scale = 0.35
racedata.picture.shift = {0, -0.6}
racedata.circuit_wire_connection_point = nil
racedata.circuit_connector_sprites = nil
racedata.circuit_wire_max_distance = nil
data:extend({racedata})

racedata = table.deepcopy(data.raw.item['coin'])
racedata.name = "zadv_coin"
racedata.icon = "__ZAdventure__/graphics/icons/coin.png"
racedata.flags = {}
racedata.icon_size = 64
data:extend({racedata})

racedata = table.deepcopy(data.raw.tile['concrete'])
racedata.name = "zadv_race_tile"
racedata.minable = nil
racedata.mined_sound = nil
racedata.walking_speed_modifier = 1
racedata.vehicle_friction_modifier = 0.8
racedata.map_color={r=50, g=50, b=50}
racedata.layer = 60
racedata.ageing=0
racedata.variants.inner_corner.picture = "__ZAdventure__/graphics/terrain/asphalt-inner-corner.png"
racedata.variants.inner_corner.scale = 0.5
racedata.variants.inner_corner.hr_version = nil
racedata.variants.outer_corner.picture = "__ZAdventure__/graphics/terrain/asphalt-outer-corner.png"
racedata.variants.outer_corner.scale = 0.5
racedata.variants.outer_corner.hr_version = nil
racedata.variants.side.picture = "__ZAdventure__/graphics/terrain/asphalt-side.png"
racedata.variants.side.scale = 0.5
racedata.variants.side.hr_version = nil
racedata.variants.u_transition.picture = "__ZAdventure__/graphics/terrain/asphalt-u.png"
racedata.variants.u_transition.scale = 0.5
racedata.variants.u_transition.hr_version = nil
racedata.variants.o_transition.picture = "__ZAdventure__/graphics/terrain/asphalt-o.png"
racedata.variants.o_transition.scale = 0.5
racedata.variants.o_transition.hr_version = nil
racedata.variants.material_background.picture = "__ZAdventure__/graphics/terrain/asphalt.png"
racedata.variants.material_background.hr_version.picture = "__ZAdventure__/graphics/terrain/hr-asphalt.png"
data:extend({racedata})

racedata = table.deepcopy(data.raw.item['stone-brick'])
racedata.name = "zadv_race_tile"
racedata.stack_size = 9999
racedata.flags = {'hidden'}
racedata.place_as_tile.result = "zadv_race_tile"
data:extend({racedata})

data.raw['font']['zadv_lable_race_font_1'] = {
	type = "font",
	name = "zadv_lable_race_font_1",
	from = "zadv-race-timer",
	size = 52,
	spacing = 1,
	scale_font = false,
	border = true,
	border_color = {}
}
data.raw['font']['zadv_lable_race_font_2'] = {
    type = "font",
    name = "zadv_lable_race_font_2",
    from = "default",
    size = 24
}
data.raw['font']['zadv_lable_race_font_3'] = {
    type = "font",
    name = "zadv_lable_race_font_3",
    from = "default",
    size = 18
}
data.raw['gui-style']['default']['zadv_lable_info'] = {
	type = "label_style",
	font = "default-bold",
	maximal_width = 250,
	top_padding = 0,
	bottom_padding = 0,
	single_line = false
}
data.raw['gui-style']['default']['zadv_lable_race_head'] = {
	type = "label_style",
	font = "zadv_lable_race_font_3",
	maximal_width = 250,
	single_line = true
}
data.raw['gui-style']['default']['zadv_lable_race_info'] = {
	type = "label_style",
	parent = "zadv_lable_info",
	font = "zadv_lable_race_font_2",
	single_line = true
}
data.raw['gui-style']['default']['zadv_lable_race_info_white'] = {
	type = "label_style",
	parent = "zadv_lable_race_info",
	font = "zadv_lable_race_font_1",
	minimal_width = 180,
	font_color = {r=1, g=1, b=1}
}
data.raw['gui-style']['default']['zadv_lable_race_info_green'] = {
	type = "label_style",
	parent = "zadv_lable_race_info",
	font_color = {r = 0.3, g = 0.7, b = 0.0}
}
data.raw['gui-style']['default']['zadv_lable_race_info_yellow'] = {
	type = "label_style",
	parent = "zadv_lable_race_info",
	font_color = {r = 0.9, g = 0.7, b = 0.0}
}
data.raw['gui-style']['default']['zadv_lable_race_info_red'] = {
	type = "label_style",
	parent = "zadv_lable_race_info",
	font_color = {r = 1.0, g = 0.2, b = 0.2}
}
data.raw['gui-style']['default']['zadv_lable_record_white'] = {
	type = "label_style",
	parent = "bold_label",
	maximal_width = 220,
    padding = 0,
	single_line = true
}
data.raw['gui-style']['default']['zadv_lable_record_green'] = {
	type = "label_style",
	parent = "zadv_lable_record_white",
	font_color = {r = 0.3, g = 0.7, b = 0.0}
}
data.raw['gui-style']['default']['zadv_lable_record_yellow'] = {
	type = "label_style",
	parent = "zadv_lable_record_white",
	font_color = {r = 0.9, g = 0.7, b = 0.0}
}
data.raw['gui-style']['default']['zadv_lable_record_red'] = {
	type = "label_style",
	parent = "zadv_lable_record_white",
	font_color = {r = 1.0, g = 0.2, b = 0.2}
}

local warnmine = table.deepcopy(data.raw['simple-entity-with-force']['simple-entity-with-force'])
warnmine.name = "zadv-land-mine-warn"
warnmine.icon = "__ZAdventure__/graphics/icons/warmines.png"
warnmine.flags = {}
warnmine.minable = nil
warnmine.collision_box = nil
warnmine.selection_box = {{-0.7, -0.8}, {0.3, 0.5}}
warnmine.picture.filename = "__ZAdventure__/graphics/entity/warmines.png"
warnmine.picture.width = 256
warnmine.picture.height = 256
warnmine.picture.scale = 0.25
warnmine.picture.shift = {-0.2, -0.2}
data:extend({warnmine})


