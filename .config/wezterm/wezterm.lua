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
config.enable_wayland = true

-- Window
local window = require("window")
window.apply_to_config(config)

-- Background
local background = require("background")
background.apply_to_config(config)

local colors = require("colors")
colors.apply_to_config(config)

local font = require("font")
font.apply_to_config(config)

local keybindings = require("keybindings")
keybindings.apply_to_config(config)
-- ==================================================================

-- and finally, return the configuration to wezterm
return config
