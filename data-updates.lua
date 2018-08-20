require 'util'

do -- belts
	local recipe = table.deepcopy(ZADV.backup['iron-gear-wheel'])
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

	recipe = table.deepcopy(ZADV.backup['recipe-transport-belt'])
	recipe.name = "zadv-transport-belt"
	recipe.enabled = true
	recipe.hidden = true
	recipe.flags = {'hidden'}
	recipe.hidden_from_flow_stats = true
	recipe.normal = nil
	recipe.expensive = nil
	recipe.ingredients = {
		{"iron-plate", 1},
		{"iron-gear-wheel", 1}
	}
	recipe.result = "transport-belt"
	data:extend({recipe})

	recipe = table.deepcopy(ZADV.backup['recipe-fast-transport-belt'])
	recipe.name = "zadv-fast-transport-belt"
	recipe.enabled = true
	recipe.hidden = true
	recipe.flags = {'hidden'}
	recipe.hidden_from_flow_stats = true
	recipe.normal = nil
	recipe.expensive = nil
	recipe.ingredients = {
		{"iron-gear-wheel", 2},
		{"transport-belt", 1}
	}
	recipe.result = "fast-transport-belt"
	data:extend({recipe})

	recipe = table.deepcopy(ZADV.backup['recipe-transport-belt'])
	recipe.name = "zadv-transport-belt-slow"
	recipe.enabled = true
	recipe.hidden = true
	recipe.flags = {'hidden'}
	recipe.energy_required = 8
	recipe.hidden_from_flow_stats = true
	recipe.normal = nil
	recipe.expensive = nil
	recipe.ingredients = {
		{"iron-plate", 1},
		{"iron-gear-wheel", 1}
	}
	recipe.result = "transport-belt"
	data:extend({recipe})

	recipe = table.deepcopy(ZADV.backup['recipe-fast-transport-belt'])
	recipe.name = "zadv-fast-transport-belt-slow"
	recipe.enabled = true
	recipe.hidden = true
	recipe.flags = {'hidden'}
	recipe.energy_required = 12
	recipe.hidden_from_flow_stats = true
	recipe.normal = nil
	recipe.expensive = nil
	recipe.ingredients = {
		{"iron-gear-wheel", 2},
		{"transport-belt", 1}
	}
	recipe.result = "fast-transport-belt"
	data:extend({recipe})
	
	data:extend({ZADV.backup['lubricant']})
	data:extend({ZADV.backup['recipe-lubricant']})
	recipe = table.deepcopy(ZADV.backup['recipe-express-transport-belt'])
	recipe.name = "zadv-express-transport-belt-slow"
	recipe.enabled = true
	recipe.hidden = true
	recipe.flags = {'hidden'}
	recipe.energy_required = 19
	recipe.hidden_from_flow_stats = true
	recipe.normal = nil
	recipe.expensive = nil
	recipe.ingredients = {
		{"iron-gear-wheel", 5},
		{"fast-transport-belt", 1},
		{type="fluid", name="lubricant", amount=20}
	}
	recipe.result = "express-transport-belt"
	data:extend({recipe})
end
do -- maze
	local slow_path = table.deepcopy(ZADV.backup['stone-path'])
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


	local slow_brick = table.deepcopy(ZADV.backup['stone-brick'])
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
end
do -- station
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
end
do -- base
	local s1,s2 = 1.25,1.5
	local c = { r = 0.9, g = 0.9, b = 0.9 }
	
	local spawner = table.deepcopy(ZADV.backup['medium-biter-corpse'])
	spawner.name = "zadv-medium-beast-corpse"
    spawner.selection_box = nil
    spawner.time_before_removed = 3600
    spawner.flags = {"placeable-off-grid", "not-on-map"}
	spawner.animation.layers[1].width = 114
	spawner.animation.layers[1].height = 112
	spawner.animation.layers[1].shift = util.by_pixel(-7.0,-5.5)
	spawner.animation.layers[1].scale = 0.5
	spawner.animation.layers[1].frame_count = 1
	spawner.animation.layers[1].direction_count = 1
	spawner.animation.layers[1].stripes = {
		{
			filename = "__ZAdventure__/graphics/entity/player/hr-level1_dead.png",
			width_in_frames = 1,
			height_in_frames = 1
		}
	}
		spawner.animation.layers[2] = table.deepcopy(spawner.animation.layers[1])
		spawner.animation.layers[2].tint = { r = 0.72, g = 0.21, b = 0 }
        spawner.animation.layers[2].stripes = nil
        spawner.animation.layers[2].flags = { "mask" }
		spawner.animation.layers[2].filename = "__ZAdventure__/graphics/entity/player/hr-level1_dead_mask.png"
			spawner.animation.layers[3] = nil
	data:extend({spawner})
	
	spawner = table.deepcopy(data.raw['corpse']['zadv-medium-beast-corpse'])
	spawner.name = "zadv-big-beast-corpse"
	spawner.animation.layers[1].scale = spawner.animation.layers[1].scale*s1
	spawner.animation.layers[1].shift[1] = spawner.animation.layers[1].shift[1]*s1
	spawner.animation.layers[1].shift[2] = spawner.animation.layers[1].shift[2]*s1
		spawner.animation.layers[2] = table.deepcopy(spawner.animation.layers[1])
		spawner.animation.layers[2].tint = {r = 0.3, g = 0.3, b = 0.0}
        spawner.animation.layers[2].stripes = nil
		spawner.animation.layers[2].filename = "__ZAdventure__/graphics/entity/player/hr-level2addon_dead.png"
			spawner.animation.layers[3] = table.deepcopy(spawner.animation.layers[1])
			spawner.animation.layers[3].tint = { r = 0.7, g = 0.7, b = 0.1}
			spawner.animation.layers[3].stripes = nil
			spawner.animation.layers[3].filename = "__ZAdventure__/graphics/entity/player/hr-level2addon_dead_mask.png"
	data:extend({spawner})
	
	spawner = table.deepcopy(data.raw['corpse']['zadv-medium-beast-corpse'])
	spawner.name = "zadv-behemoth-beast-corpse"
	spawner.animation.layers[1].scale = spawner.animation.layers[1].scale*s2
	spawner.animation.layers[1].shift[1] = spawner.animation.layers[1].shift[1]*s2
	spawner.animation.layers[1].shift[2] = spawner.animation.layers[1].shift[2]*s2
		spawner.animation.layers[2] = table.deepcopy(spawner.animation.layers[1])
		spawner.animation.layers[2].tint = {r = 0.1, g = 0.75, b = 0.21}
        spawner.animation.layers[2].stripes = nil
		spawner.animation.layers[2].filename = "__ZAdventure__/graphics/entity/player/hr-level3addon_dead.png"
			spawner.animation.layers[3] = table.deepcopy(spawner.animation.layers[1])
			spawner.animation.layers[3].tint = {r = 0.55, g = 0.68, b = 0.11}
			spawner.animation.layers[3].stripes = nil
			spawner.animation.layers[3].filename = "__ZAdventure__/graphics/entity/player/hr-level3addon_dead_mask.png"
	data:extend({spawner})
	
	spawner = table.deepcopy(data.raw['corpse']['zadv-medium-beast-corpse'])
	spawner.name = "zadv-medium-zombie-corpse"
	spawner.animation.layers[2].tint = { r = 0.32, g = 0.41, b = 0 }
	data:extend({spawner})
	
	spawner = table.deepcopy(data.raw['corpse']['zadv-big-beast-corpse'])
	spawner.name = "zadv-big-zombie-corpse"
		spawner.animation.layers[2].tint = { r = 0.45, g = 0.45, b = 0.45}
			spawner.animation.layers[3].tint = {r = 0.16, g = 0.31, b = 0.58}
	data:extend({spawner})
	
	spawner = table.deepcopy(data.raw['corpse']['zadv-big-beast-corpse'])
	spawner.name = "zadv-flame-zombie-corpse"
	spawner.animation.layers[3].tint = { r = 0.78, g = 0.45, b = 0}
	data:extend({spawner})
	
	spawner = table.deepcopy(data.raw['corpse']['zadv-behemoth-beast-corpse'])
	spawner.name = "zadv-behemoth-zombie-corpse"
	spawner.animation.layers[2].tint = {r = 0.75, g = 0.21, b = 0.1}
		spawner.animation.layers[3].tint = {r = 0.55, g = 0.11, b = 0.68}
	data:extend({spawner})
	
	
	spawner = table.deepcopy(ZADV.backup['medium-biter'])
	spawner.name = "zadv-medium-beast"
	spawner.corpse = "zadv-medium-beast-corpse"
	spawner.flags = {"placeable-off-grid", "breaths-air", "not-repairable", "not-flammable"}
	spawner.max_health = 350
	spawner.healing_per_tick = 0.04
	spawner.run_animation = table.deepcopy(ZADV.backup['panimations'][1].running)
	spawner.attack_parameters.animation = table.deepcopy(ZADV.backup['panimations'][1].mining_with_tool)
	spawner.run_animation.layers[2].tint = { r = 0.72, g = 0.21, b = 0 }
	spawner.run_animation.layers[2].hr_version.tint = { r = 0.72, g = 0.21, b = 0 }
	spawner.attack_parameters.animation.layers[2].tint = { r = 0.72, g = 0.21, b = 0 }
	spawner.attack_parameters.animation.layers[2].hr_version.tint = { r = 0.72, g = 0.21, b = 0 }
	spawner.attack_parameters.cooldown = 25
	data:extend({spawner})

	spawner = table.deepcopy(spawner)
	spawner.name = "zadv-big-beast"
	spawner.corpse = "zadv-big-beast-corpse"
	spawner.flags = {"placeable-off-grid", "breaths-air", "not-repairable", "not-flammable"}
	spawner.max_health = 1350
	spawner.healing_per_tick = 0.04
	spawner.vision_distance = 45
	spawner.run_animation = table.deepcopy(ZADV.backup['panimations'][2].running)
	spawner.attack_parameters.animation = table.deepcopy(ZADV.backup['panimations'][2].mining_with_tool)
	for i=1,5 do
		if i==1 then c={ r = 0.3, g = 0.3, b = 0.3}
		elseif i==2 then c={r = 0.3, g = 0.3, b = 0.0}
		elseif i==4 then c={ r = 0.7, g = 0.7, b = 0.1}
		else c=false end
		if c then
			spawner.run_animation.layers[i].tint = c
			spawner.run_animation.layers[i].hr_version.tint = c
			spawner.attack_parameters.animation.layers[i].tint = c
			spawner.attack_parameters.animation.layers[i].hr_version.tint = c
		end
		spawner.run_animation.layers[i].scale = s1
		spawner.run_animation.layers[i].hr_version.scale = spawner.run_animation.layers[i].hr_version.scale*s1
		spawner.run_animation.layers[i].animation_speed =  spawner.run_animation.layers[i].animation_speed/1.05
		spawner.run_animation.layers[i].hr_version.animation_speed =  spawner.run_animation.layers[i].hr_version.animation_speed/1.05
		spawner.run_animation.layers[i].shift[2] = spawner.run_animation.layers[i].shift[2]*s1
		spawner.run_animation.layers[i].hr_version.shift[2] = spawner.run_animation.layers[i].hr_version.shift[2]*s1
		
		spawner.attack_parameters.animation.layers[i].scale = s1
		spawner.attack_parameters.animation.layers[i].hr_version.scale = spawner.attack_parameters.animation.layers[i].hr_version.scale*s1
		spawner.attack_parameters.animation.layers[i].shift[2] = spawner.attack_parameters.animation.layers[i].shift[2]*s1
		spawner.attack_parameters.animation.layers[i].hr_version.shift[2] = spawner.attack_parameters.animation.layers[i].hr_version.shift[2]*s1
	end
	spawner.attack_parameters.cooldown = 25
	data:extend({spawner})

	spawner = table.deepcopy(spawner)
	spawner.name = "zadv-behemoth-beast"
	spawner.corpse = "zadv-behemoth-beast-corpse"
	spawner.flags = {"placeable-off-grid", "breaths-air", "not-flammable"}
	spawner.max_health = 6500
	spawner.healing_per_tick = 0.04
	spawner.vision_distance = 65
	spawner.min_pursue_time = 1200
	spawner.max_pursue_distance = 120
	spawner.run_animation = table.deepcopy(ZADV.backup['panimations'][3].running)
	spawner.attack_parameters.animation = table.deepcopy(ZADV.backup['panimations'][3].mining_with_tool)
	for i=1,5 do
		if i==1 then c={ r = 0.9, g = 0.9, b = 0.9}
		elseif i==2 then c={r = 0.1, g = 0.75, b = 0.21}
		elseif i==3 then c={r = 0.3, g = 0.5, b = 0.4}
		elseif i==4 then c={r = 0.55, g = 0.68, b = 0.11}
		else c=false end
		if c then
			spawner.run_animation.layers[i].tint = c
			spawner.run_animation.layers[i].hr_version.tint = c
			spawner.attack_parameters.animation.layers[i].tint = c
			spawner.attack_parameters.animation.layers[i].hr_version.tint = c
		end
		spawner.run_animation.layers[i].scale = s2
		spawner.run_animation.layers[i].hr_version.scale = spawner.run_animation.layers[i].hr_version.scale*s2
		spawner.run_animation.layers[i].shift[2] = spawner.run_animation.layers[i].shift[2]*s2
		spawner.run_animation.layers[i].hr_version.shift[2] = spawner.run_animation.layers[i].hr_version.shift[2]*s2
		spawner.run_animation.layers[i].animation_speed =  spawner.run_animation.layers[i].animation_speed/1.15
		spawner.run_animation.layers[i].hr_version.animation_speed =  spawner.run_animation.layers[i].hr_version.animation_speed/1.15
		
		spawner.attack_parameters.animation.layers[i].scale = s2
		spawner.attack_parameters.animation.layers[i].hr_version.scale = spawner.attack_parameters.animation.layers[i].hr_version.scale*s2
		spawner.attack_parameters.animation.layers[i].shift[2] = spawner.attack_parameters.animation.layers[i].shift[2]*s2
		spawner.attack_parameters.animation.layers[i].hr_version.shift[2] = spawner.attack_parameters.animation.layers[i].hr_version.shift[2]*s2
	end
	spawner.attack_parameters.cooldown = 25
	data:extend({spawner})
	
	data.raw['unit']['zadv-medium-beast'].movement_speed = 0.3
	data.raw['unit']['zadv-medium-beast'].distance_per_frame = 0.3
	data.raw['unit']['zadv-medium-beast'].max_pursue_distance = 75
	data.raw['unit']['zadv-behemoth-beast'].max_pursue_distance = 75
	data.raw['unit']['zadv-behemoth-beast'].min_pursue_time = 900

	spawner = table.deepcopy(spawner)
	spawner.name = "zadv-medium-zombie"
	spawner.corpse = "zadv-medium-zombie-corpse"
	spawner.flags = {"placeable-off-grid", "breaths-air", "not-repairable", "not-flammable"}
	spawner.max_health = 750
	spawner.healing_per_tick = 0.04
	spawner.vision_distance = 65
	spawner.run_animation = table.deepcopy(ZADV.backup['panimations'][1].running)
	spawner.attack_parameters.animation = table.deepcopy(ZADV.backup['panimations'][1].idle_with_gun)
	spawner.run_animation.layers[2].tint = { r = 0.32, g = 0.41, b = 0 }
	spawner.run_animation.layers[2].hr_version.tint = { r = 0.32, g = 0.41, b = 0 }
	spawner.attack_parameters.animation.layers[2].tint = { r = 0.32, g = 0.41, b = 0 }
	spawner.attack_parameters.animation.layers[2].hr_version.tint = { r = 0.32, g = 0.41, b = 0 }
	spawner.attack_parameters.ammo_type = table.deepcopy(ZADV.backup['piercing-rounds-magazine'].ammo_type)
	spawner.attack_parameters.ammo_type.action.action_delivery.target_effects[2].damage.amount = 16
	spawner.attack_parameters.shell_particle = table.deepcopy(ZADV.backup['submachine-gun'].attack_parameters.shell_particle)
	spawner.attack_parameters.projectile_creation_distance = 1.125
	spawner.attack_parameters.ammo_category = "bullet"
	spawner.attack_parameters.range=12
	spawner.attack_parameters.warmup = 2
	spawner.attack_parameters.cooldown = 6
	data:extend({spawner})

	spawner = table.deepcopy(spawner)
	spawner.name = "zadv-big-zombie"
	spawner.corpse = "zadv-big-zombie-corpse"
	spawner.flags = {"placeable-off-grid", "breaths-air", "not-repairable", "not-flammable"}
	spawner.max_health = 2250
	spawner.healing_per_tick = 0.04
	spawner.vision_distance = 45
	spawner.run_animation = table.deepcopy(ZADV.backup['panimations'][2].running)
	spawner.attack_parameters.animation = table.deepcopy(ZADV.backup['panimations'][2].idle_with_gun)
	for i=1,5 do
		if i==1 then c={ r = 0.3, g = 0.3, b = 0.3}
		elseif i==2 then c={ r = 0.45, g = 0.45, b = 0.45}
		elseif i==4 then c={r = 0.16, g = 0.31, b = 0.58}
		else c=false end
		if c then
			spawner.run_animation.layers[i].tint = c
			spawner.run_animation.layers[i].hr_version.tint = c
			spawner.attack_parameters.animation.layers[i].tint = c
			spawner.attack_parameters.animation.layers[i].hr_version.tint = c
		end
		spawner.run_animation.layers[i].scale = s1
		spawner.run_animation.layers[i].hr_version.scale = spawner.run_animation.layers[i].hr_version.scale*s1
		spawner.run_animation.layers[i].animation_speed =  spawner.run_animation.layers[i].animation_speed/1.05
		spawner.run_animation.layers[i].hr_version.animation_speed =  spawner.run_animation.layers[i].hr_version.animation_speed/1.05
		spawner.run_animation.layers[i].shift[2] = spawner.run_animation.layers[i].shift[2]*s1
		spawner.run_animation.layers[i].hr_version.shift[2] = spawner.run_animation.layers[i].hr_version.shift[2]*s1
		
		spawner.attack_parameters.animation.layers[i].scale = s1
		spawner.attack_parameters.animation.layers[i].hr_version.scale = spawner.attack_parameters.animation.layers[i].hr_version.scale*s1
		spawner.attack_parameters.animation.layers[i].shift[2] = spawner.attack_parameters.animation.layers[i].shift[2]*s1
		spawner.attack_parameters.animation.layers[i].hr_version.shift[2] = spawner.attack_parameters.animation.layers[i].hr_version.shift[2]*s1
	end
	spawner.attack_parameters.ammo_type = table.deepcopy(ZADV.backup['cannon-shell'].ammo_type)
	spawner.attack_parameters.shell_particle = table.deepcopy(ZADV.backup['tank-machine-gun'].attack_parameters.shell_particle)
	spawner.attack_parameters.projectile_creation_distance = 1.6
	spawner.attack_parameters.projectile_center = {-0.15625, -0.07812}
	spawner.attack_parameters.ammo_category = "cannon-shell"
	spawner.attack_parameters.range=16
	spawner.attack_parameters.warmup = 6
	spawner.attack_parameters.cooldown = 12
	data:extend({spawner})

	spawner = table.deepcopy(spawner)
	spawner.name = "zadv-flame-zombie"
	spawner.corpse = "zadv-flame-zombie-corpse"
	for i=1,5 do
		if i==1 then c={ r = 0.3, g = 0.3, b = 0.3}
		elseif i==2 then c={ r = 0.45, g = 0.45, b = 0.45}
		elseif i==4 then c={ r = 0.78, g = 0.45, b = 0}
		else c=false end
		if c then
			spawner.run_animation.layers[i].tint = c
			spawner.run_animation.layers[i].hr_version.tint = c
			spawner.attack_parameters.animation.layers[i].tint = c
			spawner.attack_parameters.animation.layers[i].hr_version.tint = c
		end
	end
	--spawner.attack_parameters.ammo_type = table.deepcopy(ZADV.backup['flamethrower-ammo'].ammo_type[1])
	spawner.attack_parameters.ammo_type = {
		source_type = "default",
		category = "flamethrower",
		target_type = "position",
		clamp_position = true,
		action = {
			type = "direct",
			action_delivery = {
				type = "stream",
				stream = "handheld-flamethrower-fire-stream",
				max_length = 15,
				duration = 160
			}
		}
	}
	spawner.attack_parameters.cyclic_sound = table.deepcopy(ZADV.backup['flamethrower'].attack_parameters.cyclic_sound)
	spawner.attack_parameters.projectile_creation_distance = 0.6
	spawner.attack_parameters.shell_particle = nil
	spawner.attack_parameters.range = 15
	spawner.attack_parameters.min_range = 5
	spawner.attack_parameters.ammo_category = "flamethrower"
	spawner.attack_parameters.warmup = 0
	spawner.attack_parameters.cooldown = 1
	data:extend({spawner})


	spawner = table.deepcopy(ZADV.backup['behemoth-biter'])
	spawner.name = "zadv-behemoth-zombie"
	spawner.corpse = "zadv-behemoth-zombie-corpse"
	spawner.flags = {"placeable-off-grid", "breaths-air", "not-flammable"}
	spawner.max_health = 9500
	spawner.healing_per_tick = 0.04
	spawner.run_animation = table.deepcopy(ZADV.backup['panimations'][3].running)
	spawner.attack_parameters.animation = table.deepcopy(ZADV.backup['panimations'][3].idle_with_gun)
	for i=1,5 do
		if i==1 then c={ r = 0.9, g = 0.9, b = 0.9}
		elseif i==2 then c={r = 0.75, g = 0.21, b = 0.1}
		elseif i==3 then c={r = 0.5, g = 0.4, b = 0.3}
		elseif i==4 then c={r = 0.55, g = 0.11, b = 0.68}
		else c=false end
		if c then
			spawner.run_animation.layers[i].tint = c
			spawner.run_animation.layers[i].hr_version.tint = c
			spawner.attack_parameters.animation.layers[i].tint = c
			spawner.attack_parameters.animation.layers[i].hr_version.tint = c
		end
		spawner.run_animation.layers[i].scale = s2
		spawner.run_animation.layers[i].hr_version.scale = spawner.run_animation.layers[i].hr_version.scale*s2
		spawner.run_animation.layers[i].shift[2] = spawner.run_animation.layers[i].shift[2]*s2
		spawner.run_animation.layers[i].hr_version.shift[2] = spawner.run_animation.layers[i].hr_version.shift[2]*s2
		spawner.run_animation.layers[i].animation_speed =  spawner.run_animation.layers[i].animation_speed/1.15
		spawner.run_animation.layers[i].hr_version.animation_speed =  spawner.run_animation.layers[i].hr_version.animation_speed/1.15
		
		spawner.attack_parameters.animation.layers[i].scale = s2
		spawner.attack_parameters.animation.layers[i].hr_version.scale = spawner.attack_parameters.animation.layers[i].hr_version.scale*s2
		spawner.attack_parameters.animation.layers[i].shift[2] = spawner.attack_parameters.animation.layers[i].shift[2]*s2
		spawner.attack_parameters.animation.layers[i].hr_version.shift[2] = spawner.attack_parameters.animation.layers[i].hr_version.shift[2]*s2
	end
	spawner.attack_parameters.damage_modifier = 4
	spawner.attack_parameters.range=20
	data:extend({spawner})
	
	
	local optimal_tier = 21
	spawner = table.deepcopy(ZADV.backup['biter-spawner'])
	spawner.name = "zadv-beast-spawner"
	spawner.flags = {"placeable-neutral", "not-flammable"}
	spawner.max_health = 2350
	spawner.result_units = {
		{"zadv-medium-beast", {{0.2, 0.0}, {0.6, 0.3}, {0.7, 0.1}}},
		{"zadv-big-beast", {{0.5, 0.0}, {1.0, 0.4}}},
		{"zadv-behemoth-beast", {{0.9, 0.0}, {1.0, 0.3}}}
	}
	spawner.spawning_radius = 25
	spawner.spawning_spacing = 5
	spawner.max_friends_around_to_spawn = 15
	spawner.autoplace =  nil
	data:extend({spawner})
	
	optimal_tier = 23.6
	spawner = table.deepcopy(ZADV.backup['spitter-spawner'])
	spawner.name = "zadv-zombie-spawner"
	spawner.flags = {"placeable-neutral", "not-flammable"}
	spawner.max_health = 2350
	spawner.result_units = {
		{"zadv-medium-zombie", {{0.0, 0.0}, {0.7, 0.3}, {0.9, 0.1}}},
		{"zadv-big-zombie", {{0.4, 0.0}, {1.0, 0.4}}},
		{"zadv-flame-zombie", {{0.6, 0.0}, {1.0, 0.2}}},
		{"zadv-behemoth-zombie", {{0.7, 0.0}, {1.0, 0.3}}}
	}
	spawner.spawning_radius = 25
	spawner.spawning_spacing = 5
	spawner.max_friends_around_to_spawn = 15
	spawner.autoplace =  nil
	data:extend({spawner})
	

	spawner = table.deepcopy(ZADV.backup['roboport'])
	spawner.name = "zadv-roboport"
	spawner.flags = {"not-flammable"}
	spawner.minable = nil
	spawner.max_health = 15000
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
	spawner.dying_explosion = "big-artillery-explosion"
	spawner.energy_usage = "0kW"
	spawner.logistics_radius = 25
	spawner.construction_radius = 7500
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
end
do -- race
	local racedata = table.deepcopy(ZADV.backup['wall-stone-wall'])
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

	racedata = table.deepcopy(ZADV.backup['item-stone-wall'])
	racedata.name = "zadv-race-cone"
	racedata.icon = "__ZAdventure__/graphics/icons/race_cone.png"
	racedata.icon_size = 32
	racedata.flags = {'hidden'}
	racedata.place_result = "zadv-race-cone"
	data:extend({racedata})


	racedata = table.deepcopy(ZADV.backup['car'])
	racedata.name = "zadv-race-car-green"
	racedata.health = 1000
	racedata.minable = nil
	racedata.operable = nil
	racedata.mined_sound = nil
	racedata.guns = nil
	racedata.inventory_size = 0
	racedata.stop_trigger[1].sound[1].volume = 1.2
	racedata.animation.layers[1].apply_runtime_tint = false
	racedata.animation.layers[2].apply_runtime_tint = false
	racedata.animation.layers[3].apply_runtime_tint = false
	for _,v in pairs(racedata.animation.layers[2].stripes) do
		if v.filename:find('mask') then v = nil end
	end
	for _,v in pairs(racedata.animation.layers[2].hr_version.stripes) do
		if v.filename:find('mask') then v = nil end
	end
	racedata.animation.layers[1].stripes[1].filename = "__ZAdventure__/graphics/entity/car/car-1-green.png"
	racedata.animation.layers[1].stripes[2].filename = "__ZAdventure__/graphics/entity/car/car-2-green.png"
	racedata.animation.layers[1].stripes[3].filename = "__ZAdventure__/graphics/entity/car/car-3-green.png"
	racedata.animation.layers[1].hr_version.stripes[1].filename = "__ZAdventure__/graphics/entity/car/hr-car-1-green.png"
	racedata.animation.layers[1].hr_version.stripes[2].filename = "__ZAdventure__/graphics/entity/car/hr-car-2-green.png"
	racedata.animation.layers[1].hr_version.stripes[3].filename = "__ZAdventure__/graphics/entity/car/hr-car-3-green.png"
	racedata.animation.layers[1].hr_version.stripes[4].filename = "__ZAdventure__/graphics/entity/car/hr-car-4-green.png"
	racedata.animation.layers[1].hr_version.stripes[5].filename = "__ZAdventure__/graphics/entity/car/hr-car-5-green.png"
	racedata.animation.layers[1].hr_version.stripes[6].filename = "__ZAdventure__/graphics/entity/car/hr-car-6-green.png"
	racedata.working_sound.deactivate_sound.volume = 1.2
	racedata.working_sound.activate_sound = { filename = "__ZAdventure__/sounds/eng1.ogg", volume = 1.2 }
	racedata.working_sound.sound = { filename = "__ZAdventure__/sounds/eng2.ogg", volume = 1.2 }
	racedata.vehicle_impact_sound = { filename = "__ZAdventure__/sounds/imp.ogg", volume = 1 }
	data:extend({racedata})


	racedata = table.deepcopy(racedata)
	racedata.name = "zadv-race-car-yellow"
	racedata.health = 750
	racedata.animation.layers[1].stripes[1].filename = "__ZAdventure__/graphics/entity/car/car-1-yellow.png"
	racedata.animation.layers[1].stripes[2].filename = "__ZAdventure__/graphics/entity/car/car-2-yellow.png"
	racedata.animation.layers[1].stripes[3].filename = "__ZAdventure__/graphics/entity/car/car-3-yellow.png"
	racedata.animation.layers[1].hr_version.stripes[1].filename = "__ZAdventure__/graphics/entity/car/hr-car-1-yellow.png"
	racedata.animation.layers[1].hr_version.stripes[2].filename = "__ZAdventure__/graphics/entity/car/hr-car-2-yellow.png"
	racedata.animation.layers[1].hr_version.stripes[3].filename = "__ZAdventure__/graphics/entity/car/hr-car-3-yellow.png"
	racedata.animation.layers[1].hr_version.stripes[4].filename = "__ZAdventure__/graphics/entity/car/hr-car-4-yellow.png"
	racedata.animation.layers[1].hr_version.stripes[5].filename = "__ZAdventure__/graphics/entity/car/hr-car-5-yellow.png"
	racedata.animation.layers[1].hr_version.stripes[6].filename = "__ZAdventure__/graphics/entity/car/hr-car-6-yellow.png"
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


	racedata = table.deepcopy(ZADV.backup['item-car'])
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


	racedata = table.deepcopy(ZADV.backup['ent-transport-belt'])
	racedata.name = "zadv-race-belt-1"
	racedata.minable = nil
	racedata.mined_sound = nil
	racedata.selection_box = nil
	racedata.working_sound = nil
	racedata.circuit_wire_max_distance = 0
	racedata.speed = 0.09375
	racedata.layer = 1
	data:extend({racedata})

	racedata = table.deepcopy(ZADV.backup['ent-express-transport-belt'])
	racedata.name = "zadv-race-belt-2"
	racedata.minable = nil
	racedata.mined_sound = nil
	racedata.selection_box = nil
	racedata.working_sound = nil
	racedata.circuit_wire_max_distance = 0
	racedata.speed = 0.12500
	racedata.layer = 1
	data:extend({racedata})

	racedata = table.deepcopy(ZADV.backup['ent-fast-transport-belt'])
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

	racedata = table.deepcopy(ZADV.backup['item-transport-belt'])
	racedata.name = "zadv-race-belt-1"
	racedata.flags = {'hidden'}
	racedata.place_result = racedata.name
	data:extend({racedata})
	racedata = table.deepcopy(ZADV.backup['item-fast-transport-belt'])
	racedata.name = "zadv-race-belt-2"
	racedata.flags = {'hidden'}
	racedata.place_result = racedata.name
	data:extend({racedata})
	racedata = table.deepcopy(ZADV.backup['item-express-transport-belt'])
	racedata.name = "zadv-race-belt-3"
	racedata.flags = {'hidden'}
	racedata.place_result = racedata.name
	data:extend({racedata})

	racedata = table.deepcopy(ZADV.backup['iron-chest'])
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

	racedata = table.deepcopy(ZADV.backup['coin'])
	racedata.name = "zadv_coin"
	racedata.icon = "__ZAdventure__/graphics/icons/coin.png"
	racedata.flags = {}
	racedata.icon_size = 64
	data:extend({racedata})

	racedata = table.deepcopy(ZADV.backup['concrete'])
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

	racedata = table.deepcopy(ZADV.backup['stone-brick'])
	racedata.name = "zadv_race_tile"
	racedata.stack_size = 9999
	racedata.flags = {'hidden'}
	racedata.place_as_tile.result = "zadv_race_tile"
	data:extend({racedata})

	data:extend{
	  {
		type = "noise-layer",
		name = "zadv_race_tile-decal"
	  }
	}
	racedata = { -- zadv_race_tile-decal
		name = "zadv_race_tile-decal",
		type = "optimized-decorative",
		subgroup = "grass",
		order = "b[decorative]-b[zadv_race_tile-decal]",
		collision_mask = {"doodad-layer", "water-tile", "not-colliding-with-itself"},
		render_layer = "decals",
		tile_layer = 61,
		pictures =
		{
		  {
			filename = "__base__/graphics/decorative/concrete-hole-decal/concrete-hole-decal-00.png",
			width = 174,
			height = 134,
			shift = util.by_pixel(5, -2),
			hr_version =
			{
			  filename = "__base__/graphics/decorative/concrete-hole-decal/hr-concrete-hole-decal-00.png",
			  width = 351,
			  height = 267,
			  shift = util.by_pixel(4.25, -1.75),
			  scale = 0.5
			}
		  },
		  {
			filename = "__base__/graphics/decorative/concrete-hole-decal/concrete-hole-decal-01.png",
			width = 151,
			height = 130,
			shift = util.by_pixel(2.5, -3),
			hr_version =
			{
			  filename = "__base__/graphics/decorative/concrete-hole-decal/hr-concrete-hole-decal-01.png",
			  width = 305,
			  height = 262,
			  shift = util.by_pixel(2.25, -3),
			  scale = 0.5
			}
		  },
		  {
			filename = "__base__/graphics/decorative/concrete-hole-decal/concrete-hole-decal-02.png",
			width = 163,
			height = 135,
			shift = util.by_pixel(-8.5, -0.5),
			hr_version =
			{
			  filename = "__base__/graphics/decorative/concrete-hole-decal/hr-concrete-hole-decal-02.png",
			  width = 327,
			  height = 270,
			  shift = util.by_pixel(-8.25, -0.5),
			  scale = 0.5
			}
		  },
		  {
			filename = "__base__/graphics/decorative/concrete-hole-decal/concrete-hole-decal-03.png",
			width = 127,
			height = 135,
			shift = util.by_pixel(10.5, -1.5),
			hr_version =
			{
			  filename = "__base__/graphics/decorative/concrete-hole-decal/hr-concrete-hole-decal-03.png",
			  width = 258,
			  height = 268,
			  shift = util.by_pixel(10, -1.5),
			  scale = 0.5
			}
		  },
		  {
			filename = "__base__/graphics/decorative/concrete-hole-decal/concrete-hole-decal-04.png",
			width = 114,
			height = 100,
			shift = util.by_pixel(9, 3),
			hr_version =
			{
			  filename = "__base__/graphics/decorative/concrete-hole-decal/hr-concrete-hole-decal-04.png",
			  width = 231,
			  height = 201,
			  shift = util.by_pixel(8.75, 3.25),
			  scale = 0.5
			}
		  },
		  {
			filename = "__base__/graphics/decorative/concrete-hole-decal/concrete-hole-decal-05.png",
			width = 146,
			height = 116,
			shift = util.by_pixel(12, 6),
			hr_version =
			{
			  filename = "__base__/graphics/decorative/concrete-hole-decal/hr-concrete-hole-decal-05.png",
			  width = 295,
			  height = 234,
			  shift = util.by_pixel(12.25, 6.5),
			  scale = 0.5
			}
		  },
		  {
			filename = "__base__/graphics/decorative/concrete-hole-decal/concrete-hole-decal-06.png",
			width = 133,
			height = 85,
			shift = util.by_pixel(-6.5, 0.5),
			hr_version =
			{
			  filename = "__base__/graphics/decorative/concrete-hole-decal/hr-concrete-hole-decal-06.png",
			  width = 271,
			  height = 172,
			  shift = util.by_pixel(-5.75, 0.5),
			  scale = 0.5
			}
		  },
		  {
			filename = "__base__/graphics/decorative/concrete-hole-decal/concrete-hole-decal-07.png",
			width = 139,
			height = 118,
			shift = util.by_pixel(-1.5, 6),
			hr_version =
			{
			  filename = "__base__/graphics/decorative/concrete-hole-decal/hr-concrete-hole-decal-07.png",
			  width = 282,
			  height = 266,
			  shift = util.by_pixel(-1.5, -1.5),
			  scale = 0.5
			}
		  },
		  {
			filename = "__base__/graphics/decorative/concrete-hole-decal/concrete-hole-decal-08.png",
			width = 188,
			height = 114,
			shift = util.by_pixel(0, -7),
			hr_version =
			{
			  filename = "__base__/graphics/decorative/concrete-hole-decal/hr-concrete-hole-decal-08.png",
			  width = 377,
			  height = 231,
			  shift = util.by_pixel(-0.25, -7.25),
			  scale = 0.5
			}
		  },
		  {
			filename = "__base__/graphics/decorative/concrete-hole-decal/concrete-hole-decal-09.png",
			width = 170,
			height = 100,
			shift = util.by_pixel(9, 6),
			hr_version =
			{
			  filename = "__base__/graphics/decorative/concrete-hole-decal/hr-concrete-hole-decal-09.png",
			  width = 376,
			  height = 202,
			  shift = util.by_pixel(0, 6),
			  scale = 0.5
			}
		  },
		  {
			filename = "__base__/graphics/decorative/concrete-hole-decal/concrete-hole-decal-10.png",
			width = 184,
			height = 116,
			shift = util.by_pixel(-1, 3),
			hr_version =
			{
			  filename = "__base__/graphics/decorative/concrete-hole-decal/hr-concrete-hole-decal-10.png",
			  width = 372,
			  height = 234,
			  shift = util.by_pixel(-1, 3.5),
			  scale = 0.5
			}
		  },
		  {
			filename = "__base__/graphics/decorative/concrete-hole-decal/concrete-hole-decal-11.png",
			width = 171,
			height = 111,
			shift = util.by_pixel(-1.5, 1.5),
			hr_version =
			{
			  filename = "__base__/graphics/decorative/concrete-hole-decal/hr-concrete-hole-decal-11.png",
			  width = 344,
			  height = 224,
			  shift = util.by_pixel(-1.5, 1.5),
			  scale = 0.5
			}
		  },
		  {
			filename = "__base__/graphics/decorative/concrete-hole-decal/concrete-hole-decal-12.png",
			width = 138,
			height = 94,
			shift = util.by_pixel(-10, 4),
			hr_version =
			{
			  filename = "__base__/graphics/decorative/concrete-hole-decal/hr-concrete-hole-decal-12.png",
			  width = 290,
			  height = 189,
			  shift = util.by_pixel(-8, 4.25),
			  scale = 0.5
			}
		  },
		  {
			filename = "__base__/graphics/decorative/concrete-hole-decal/concrete-hole-decal-13.png",
			width = 159,
			height = 109,
			shift = util.by_pixel(-4.5, -3.5),
			hr_version =
			{
			  filename = "__base__/graphics/decorative/concrete-hole-decal/hr-concrete-hole-decal-13.png",
			  width = 326,
			  height = 228,
			  shift = util.by_pixel(-3, -2),
			  scale = 0.5
			}
		  },
		  {
			filename = "__base__/graphics/decorative/concrete-hole-decal/concrete-hole-decal-14.png",
			width = 153,
			height = 111,
			shift = util.by_pixel(-13.5, 4.5),
			hr_version =
			{
			  filename = "__base__/graphics/decorative/concrete-hole-decal/hr-concrete-hole-decal-14.png",
			  width = 312,
			  height = 225,
			  shift = util.by_pixel(-13.5, 4.25),
			  scale = 0.5
			}
		  },
		  {
			filename = "__base__/graphics/decorative/concrete-hole-decal/concrete-hole-decal-15.png",
			width = 178,
			height = 92,
			shift = util.by_pixel(-5, 4),
			hr_version =
			{
			  filename = "__base__/graphics/decorative/concrete-hole-decal/hr-concrete-hole-decal-15.png",
			  width = 359,
			  height = 186,
			  shift = util.by_pixel(-4.25, 4.5),
			  scale = 0.5
			}
		  },
		  {
			filename = "__base__/graphics/decorative/concrete-hole-decal/concrete-hole-decal-16.png",
			width = 142,
			height = 117,
			shift = util.by_pixel(11, 6.5),
			hr_version =
			{
			  filename = "__base__/graphics/decorative/concrete-hole-decal/hr-concrete-hole-decal-16.png",
			  width = 287,
			  height = 266,
			  shift = util.by_pixel(10.75, -1.5),
			  scale = 0.5
			}
		  },
		  {
			filename = "__base__/graphics/decorative/concrete-hole-decal/concrete-hole-decal-17.png",
			width = 188,
			height = 133,
			shift = util.by_pixel(0, -1.5),
			hr_version =
			{
			  filename = "__base__/graphics/decorative/concrete-hole-decal/hr-concrete-hole-decal-17.png",
			  width = 377,
			  height = 267,
			  shift = util.by_pixel(0.25, -1.75),
			  scale = 0.5
			}
		  },
		  {
			filename = "__base__/graphics/decorative/concrete-hole-decal/concrete-hole-decal-18.png",
			width = 186,
			height = 135,
			shift = util.by_pixel(1, -1.5),
			hr_version =
			{
			  filename = "__base__/graphics/decorative/concrete-hole-decal/hr-concrete-hole-decal-18.png",
			  width = 375,
			  height = 269,
			  shift = util.by_pixel(0.25, -1.25),
			  scale = 0.5
			}
		  },
		  {
			filename = "__base__/graphics/decorative/concrete-hole-decal/concrete-hole-decal-19.png",
			width = 171,
			height = 134,
			shift = util.by_pixel(-0.5, -1),
			hr_version =
			{
			  filename = "__base__/graphics/decorative/concrete-hole-decal/hr-concrete-hole-decal-19.png",
			  width = 346,
			  height = 270,
			  shift = util.by_pixel(-0.5, -1),
			  scale = 0.5
			}
		  },
		  {
			filename = "__base__/graphics/decorative/concrete-hole-decal/concrete-hole-decal-20.png",
			width = 129,
			height = 99,
			shift = util.by_pixel(-3.5, 0.5),
			hr_version =
			{
			  filename = "__base__/graphics/decorative/concrete-hole-decal/hr-concrete-hole-decal-20.png",
			  width = 261,
			  height = 198,
			  shift = util.by_pixel(-3.25, 0.5),
			  scale = 0.5
			}
		  },
		  {
			filename = "__base__/graphics/decorative/concrete-hole-decal/concrete-hole-decal-21.png",
			width = 134,
			height = 101,
			shift = util.by_pixel(3, -8.5),
			hr_version =
			{
			  filename = "__base__/graphics/decorative/concrete-hole-decal/hr-concrete-hole-decal-21.png",
			  width = 270,
			  height = 205,
			  shift = util.by_pixel(2.5, -8.75),
			  scale = 0.5
			}
		  },
		  {
			filename = "__base__/graphics/decorative/concrete-hole-decal/concrete-hole-decal-22.png",
			width = 131,
			height = 105,
			shift = util.by_pixel(-11.5, 5.5),
			hr_version =
			{
			  filename = "__base__/graphics/decorative/concrete-hole-decal/hr-concrete-hole-decal-22.png",
			  width = 266,
			  height = 212,
			  shift = util.by_pixel(-11.5, 5.5),
			  scale = 0.5
			}
		  },
		  {
			filename = "__base__/graphics/decorative/concrete-hole-decal/concrete-hole-decal-23.png",
			width = 145,
			height = 80,
			shift = util.by_pixel(13.5, -10),
			hr_version =
			{
			  filename = "__base__/graphics/decorative/concrete-hole-decal/hr-concrete-hole-decal-23.png",
			  width = 292,
			  height = 164,
			  shift = util.by_pixel(13.5, -10.5),
			  scale = 0.5
			}
		  },
		  {
			filename = "__base__/graphics/decorative/concrete-hole-decal/concrete-hole-decal-24.png",
			width = 188,
			height = 115,
			shift = util.by_pixel(0, 2.5),
			hr_version =
			{
			  filename = "__base__/graphics/decorative/concrete-hole-decal/hr-concrete-hole-decal-24.png",
			  width = 377,
			  height = 232,
			  shift = util.by_pixel(-0.25, 2.5),
			  scale = 0.5
			}
		  },
		  {
			filename = "__base__/graphics/decorative/concrete-hole-decal/concrete-hole-decal-25.png",
			width = 188,
			height = 100,
			shift = util.by_pixel(0, -3),
			hr_version =
			{
			  filename = "__base__/graphics/decorative/concrete-hole-decal/hr-concrete-hole-decal-25.png",
			  width = 376,
			  height = 204,
			  shift = util.by_pixel(0, -3),
			  scale = 0.5
			}
		  },
		  {
			filename = "__base__/graphics/decorative/concrete-hole-decal/concrete-hole-decal-26.png",
			width = 186,
			height = 107,
			shift = util.by_pixel(-1, -12.5),
			hr_version =
			{
			  filename = "__base__/graphics/decorative/concrete-hole-decal/hr-concrete-hole-decal-26.png",
			  width = 376,
			  height = 214,
			  shift = util.by_pixel(0, -13),
			  scale = 0.5
			}
		  },
		  {
			filename = "__base__/graphics/decorative/concrete-hole-decal/concrete-hole-decal-27.png",
			width = 188,
			height = 103,
			shift = util.by_pixel(0, -5.5),
			hr_version =
			{
			  filename = "__base__/graphics/decorative/concrete-hole-decal/hr-concrete-hole-decal-27.png",
			  width = 378,
			  height = 209,
			  shift = util.by_pixel(0, -4.75),
			  scale = 0.5
			}
		  },
		  {
			filename = "__base__/graphics/decorative/concrete-hole-decal/concrete-hole-decal-28.png",
			width = 188,
			height = 95,
			shift = util.by_pixel(0, 3.5),
			hr_version =
			{
			  filename = "__base__/graphics/decorative/concrete-hole-decal/hr-concrete-hole-decal-28.png",
			  width = 378,
			  height = 198,
			  shift = util.by_pixel(0, 5),
			  scale = 0.5
			}
		  },
		  {
			filename = "__base__/graphics/decorative/concrete-hole-decal/concrete-hole-decal-29.png",
			width = 176,
			height = 108,
			shift = util.by_pixel(6, 0),
			hr_version =
			{
			  filename = "__base__/graphics/decorative/concrete-hole-decal/hr-concrete-hole-decal-29.png",
			  width = 352,
			  height = 218,
			  shift = util.by_pixel(6, 0),
			  scale = 0.5
			}
		  }
		}
	  }
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
end
do -- danger chest
	local warnmine = table.deepcopy(ZADV.backup['simple-entity-with-force'])
	warnmine.name = "zadv-land-mine-warn"
	warnmine.icon = "__ZAdventure__/graphics/icons/warmines.png"
	warnmine.flags = {}
	warnmine.minable = nil
	warnmine.collision_box = nil
	warnmine.selection_box = {{-0.7, -0.8}, {0.3, 0.5}}
	warnmine.picture.filename = "__ZAdventure__/graphics/entity/warmines.png"
	warnmine.picture.width = 256
	warnmine.picture.height = 256
	warnmine.picture.scale = 0.5
	warnmine.picture.shift = {-0.2, -0.2}
	data:extend({warnmine})
end

