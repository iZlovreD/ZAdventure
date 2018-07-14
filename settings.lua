data:extend({

-- STARTUP
	{
		type = "int-setting",
		name = "zadv_global_frequency",
        setting_type = "startup",
		orcder = "a",
		default_value = 75,
		minimum_value = 10,
		maximum_value = 250
	},
	{
		type = "int-setting",
		name = "zadv_starting_radiius",
        setting_type = "startup",
		orcder = "b",
		default_value = 12,
		minimum_value = 5,
		maximum_value = 64
	},
	{
		type = "bool-setting",
		name = "zadv_dangerous",
        setting_type = "startup",
		orcder = "c",
		default_value = true
	},
	{
		type = "bool-setting",
		name = "zadv_experemental",
        setting_type = "startup",
		orcder = "d",
		default_value = false
	},
})