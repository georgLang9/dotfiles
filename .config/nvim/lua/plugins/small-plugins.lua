return {
  {
    "gpanders/nvim-parinfer",
  },
  { "elkowar/yuck.vim" },
  { "lcheylus/overlength.nvim" },

  -- Provides documentation generation
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
    keys = {
      {
        "<leader>dd",
        function()
          require("neogen").generate()
        end,
        desc = "Generate documentation",
      },
    },
    opts = { snippet_engine = "luasnip" },
  },
}
