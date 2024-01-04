local wezterm = require("wezterm")
local windows = {}
function windows.apply_to_config(config)
  -- config.window_decorations = "RESIZE"
  config.window_close_confirmation = "NeverPrompt"
  config.window_frame = {
    font = wezterm.font({ family = "Liga SFMono Nerd Font", weight = "Regular" }),
  }

  config.hide_tab_bar_if_only_one_tab = true
  config.use_fancy_tab_bar = false
end

return windows
