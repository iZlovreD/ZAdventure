data:extend({

-- STARTUP
	{
		type = "int-setting",
		name = "zadv_global_frequency",
        setting_type = "startup",
		orcder = "z-0-a",
		default_value = 75,
		minimum_value = 10,
		maximum_value = 500
	},
	{
		type = "int-setting",
		name = "zadv_starting_radiius",
        setting_type = "startup",
		orcder = "z-0-b",
		default_value = 17,
		minimum_value = 15,
		maximum_value = 64
	},
	{
		type = "bool-setting",
		name = "zadv_dangerous",
        setting_type = "startup",
		orcder = "z-0-c",
		default_value = true
	},
	{
		type = "bool-setting",
		name = "zadv_disable_in_pvp",
        setting_type = "startup",
		orcder = "z-0-d",
		default_value = false
	},
	{
		type = "bool-setting",
		name = "zadv_experemental",
        setting_type = "startup",
		orcder = "z-0-e",
		default_value = false
	},
})

local c=1
for _,a in pairs({
	 "rail"
	,"yellow"
	,"red"
	,"blue"
	,"garage"
	,"chest"
	,"maze"
	,"lab"
	,"atom"
	,"bp"
	,"base"
	,"recipe"
	,"technology"
	,"station"
	,"post"
}) do
	data:extend({
		{
			type = "bool-setting",
			name = "zadv_area_"..a,
			setting_type = "startup",
			orcder = "z-".. c ..'-'.. a,
			default_value = true
		}
	})
	c=c+1
end