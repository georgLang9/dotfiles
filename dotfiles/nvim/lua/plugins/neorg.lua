return {
  -- https://github.com/nvim-neorg/neorg
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("neorg").setup({
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        -- ["core.completion"] = {}, -- Offers auto completion
        -- ["core.keybinds"] = {
        -- config = {
        --   hook = function(keybinds)
        --
        --   end,
        -- },
        -- },
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = "~/notes",
            },
          },
        },
      },
    })
  end,
}
