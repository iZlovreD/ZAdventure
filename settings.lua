data:extend({

-- STARTUP
	{
		type = "int-setting",
		name = "zadv_global_frequency",
        setting_type = "startup",
		orcder = "a",
		default_value = 50,
		minimum_value = 1,
		maximum_value = 250
	},
	{
		type = "int-setting",
		name = "zadv_starting_radiius",
        setting_type = "startup",
		orcder = "b",
		default_value = 12,
		minimum_value = 9,
		maximum_value = 64
	},
})