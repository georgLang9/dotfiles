local background = {}
function background.apply_to_config(config)
	-- Inactive pane
	config.inactive_pane_hsb = {
		saturation = 0.8,
		brightness = 0.7,
	}
end

return background
