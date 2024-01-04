return {
  -- Provides various tools to work with haskell in nvim,
  -- Examples: lsp, telescope, debugging, etc...
  -- For a full list visit https://github.com/mrcjkb/haskell-tools.nvim
  {
    "mrcjkb/haskell-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    version = "^2", -- Recommended
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
  },
}
