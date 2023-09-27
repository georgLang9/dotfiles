-- Pull in the wezterm API
local wezterm = require("wezterm")

local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- ==================================================================

-- This is where you actually apply your config choices

-- Disables title bar, enables resizable borders
config.window_decorations = "RESIZE"

config.window_frame = {
	font = wezterm.font({ family = "Liga SFMono Nerd Font", weight = "Regular" }),
}

config.enable_wayland = true
config.window_close_confirmation = "NeverPrompt"

-- config.window_background_opacity = 0.80

config.colors = {
	foreground = "#dde1e6",
	background = "#161616",
	cursor_bg = "#f2f4f8",
	cursor_fg = "#393939",
	cursor_border = "#f2f4f8",
	selection_fg = "#f2f4f8",
	selection_bg = "#525252",
	scrollbar_thumb = "#222222",
	split = "#444444",
	ansi = {
		"#262626",
		"#ff7eb6",
		"#42be65",
		"#82cfff",
		"#33b1ff",
		"#ee5396",
		"#3ddbd9",
		"#dde1e6",
	},
	brights = {
		"#393939",
		"#ff7eb6",
		"#42be65",
		"#82cfff",
		"#33b1ff",
		"#ee5396",
		"#3ddbd9",
		"#ffffff",
	},
}

-- Inactive pane
config.inactive_pane_hsb = {
	saturation = 0.8,
	brightness = 0.7,
}

-- Font
-- Available Fonts:
-- Liga SFMono Nerd Font
-- DroidSansM Nerd Font
-- JetBrains Nerd Font
-- FiraCode Nerd Font
-- MesloLGL Nerd Font
-- Source Code Pro Semibold
-- Symbols Nerd Font
config.font = wezterm.font_with_fallback({
	{ family = "Liga SFMono Nerd Font" },
	{ family = "Hack Nerd Font" },
	{ family = "Symbols Nerd Font" },
})

config.font_size = 14
config.line_height = 1.0

-- HOTKEYS
-- ==================================================================

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

-- ==================================================================

-- and finally, return the configuration to wezterm
return config
