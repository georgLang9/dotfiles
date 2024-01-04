local wezterm = require("wezterm")
local act = wezterm.action
local keybindings = {}

function keybindings.apply_to_config(config)
  config.keys = {
    -- Move panel
    {
      key = "h",
      mods = "ALT",
      action = act.ActivatePaneDirection("Left"),
    },
    {
      key = "j",
      mods = "ALT",
      action = act.ActivatePaneDirection("Down"),
    },
    {
      key = "k",
      mods = "ALT",
      action = act.ActivatePaneDirection("Up"),
    },
    {
      key = "l",
      mods = "ALT",
      action = act.ActivatePaneDirection("Right"),
    },

    -- Move tab
    {
      key = "h",
      mods = "CTRL|ALT",
      action = act.ActivateTabRelative(-1),
    },
    {
      key = "l",
      mods = "CTRL|ALT",
      action = act.ActivateTabRelative(1),
    },

    -- Closes in the following order: 1. Pane, 2. Tab, 3. Window
    {
      key = "q",
      mods = "ALT",
      action = wezterm.action.CloseCurrentPane({ confirm = false }),
    },

    -- Create new panel
    {
      key = "v",
      mods = "SHIFT|ALT",
      action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "h",
      mods = "SHIFT|ALT",
      action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },

    -- Create a new tab in the same domain as the current pane.
    -- This is usually what you want.
    {
      key = "t",
      mods = "SHIFT|ALT",
      action = act.SpawnTab("CurrentPaneDomain"),
    },
  }
end

return keybindings
