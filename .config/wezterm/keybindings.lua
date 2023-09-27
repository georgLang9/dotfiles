local wezterm = require("wezterm")
local act = wezterm.action
local keybindings = {}

function keybindings.apply_to_config(config)
	config.keys = {
		-- Move panel
		{
			key = "h",
			mods = "CTRL|SHIFT",
			action = act.ActivatePaneDirection("Left"),
		},
		{
			key = "j",
			mods = "CTRL|SHIFT",
			action = act.ActivatePaneDirection("Down"),
		},
		{
			key = "k",
			mods = "CTRL|SHIFT",
			action = act.ActivatePaneDirection("Up"),
		},
		{
			key = "l",
			mods = "CTRL|SHIFT",
			action = act.ActivatePaneDirection("Right"),
		},

		-- Move tab
		{
			key = "h",
			mods = "SUPER",
			action = act.ActivateTabRelative(-1),
		},
		{
			key = "l",
			mods = "SUPER",
			action = act.ActivateTabRelative(1),
		},

		-- Closes in the following order: 1. Pane, 2. Tab, 3. Window
		{
			key = "q",
			mods = "SHIFT|CTRL|ALT",
			action = wezterm.action.CloseCurrentPane({ confirm = false }),
		},

		-- Create new panel
		{
			key = "v",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "h",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
	}
end

return keybindings
