-- Pull in the wezterm API
local wezterm = require("wezterm")

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
	font = wezterm.font({ family = "Noto Sans", weight = "Regular" }),
}

config.window_background_opacity = 0.95

-- Color scheme
config.color_scheme = "Tokyo Night"

-- Inactive pane
config.inactive_pane_hsb = {
	saturation = 0.8,
	brightness = 0.7,
}

-- Font
config.font_size = 13
config.line_height = 1.2

-- HOTKEYS
-- ==================================================================

-- ==================================================================

-- and finally, return the configuration to wezterm
return config
