local wezterm = require("wezterm")
local font = {}
function font.apply_to_config(config)
	-- Font
	-- Available Fonts:
	config.font = wezterm.font_with_fallback({
		{ family = "JetBrainsMono Nerd Font" },
		{ family = "Hack Nerd Font" },
		{ family = "FiraCode Nerd Font" },
		{ family = "DroidSansM Nerd Font" },
		{ family = "Liga SFMono Nerd Font" },
		{ family = "MesloLGL Nerd Font" },
		{ family = "Source Code Pro Semibold" },
		{ family = "Symbols Nerd Font" },
	})

	config.font_size = 13
	config.line_height = 1.0
end

return font
