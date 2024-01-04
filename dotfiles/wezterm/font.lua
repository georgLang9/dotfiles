local wezterm = require("wezterm")
local font = {}
function font.apply_to_config(config)
  -- Font
  -- Available Fonts:
  config.font = wezterm.font_with_fallback({
    { family = "JetBrainsMono Nerd Font" },
    { family = "FiraCode Nerd Font" },
    { family = "ComicShannsMono Nerd Font" },
    { family = "DroidSansM Nerd Font" },
  })

  config.font_size = 13
  config.line_height = 1.1
end

return font
