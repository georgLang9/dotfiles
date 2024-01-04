return {
  -- Displays colors optically of rgb and hex codes
  -- https://github.com/norcalli/nvim-colorizer.lua
  {
    "norcalli/nvim-colorizer.lua",
  },

  -- Marks text and code that doesn't fit into the textwidth or a custom width
  -- https://github.com/lcheylus/overlength.nvim
  {
    "lcheylus/overlength.nvim",
  },

  -- Syncs terminal theme with neovim colortheme
  -- https://github.com/typicode/bg.nvim
  {
    "typicode/bg.nvim",
    lazy = false,
  },
  -- https://github.com/jbyuki/nabla.nvim
  -- Enables the display of latex math equations
  {
    "jbyuki/nabla.nvim",
  },

  -- Provides documentation generation
  -- https://github.com/danymat/neogen
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
    keys = {
      {
        "<leader>cD",
        function()
          require("neogen").generate()
        end,
        desc = "Generate documentation",
      },
    },
    opts = { snippet_engine = "luasnip" },
  },
}
