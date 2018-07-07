data:extend({

-- STARTUP
	{
		type = "int-setting",
		name = "zadv_global_frequency",
        setting_type = "runtime-global",
		orcder = "a",
		default_value = 25,
		minimum_value = 1,
		maximum_value = 150
	},
	{
		type = "int-setting",
		name = "zadv_starting_radiius",
        setting_type = "runtime-global",
		orcder = "b",
		default_value = 12,
		minimum_value = 9,
		maximum_value = 64
	},
})