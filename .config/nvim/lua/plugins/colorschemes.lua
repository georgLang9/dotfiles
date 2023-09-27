return {
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      integrations = {
        alpha = true,
        cmp = true,
        flash = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        noice = true,
        notify = true,
        neotree = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    },
  },
  {
    "folke/tokyonight.nvim",
  },
  { "sainnhe/everforest" },
  { "EdenEast/nightfox.nvim" },
  { "joshdick/onedark.vim" },
  { "nyoom-engineering/nyoom.nvim" },
  {
    "nyoom-engineering/oxocarbon.nvim",
    background = "dark",
  },
  { "patstockwell/vim-monokai-tasty" },
  { "ellisonleao/gruvbox.nvim", priority = 1000 },
  { "rktjmp/lush.nvim", priority = 1000 },
  { "rebelot/kanagawa.nvim", priority = 1000 },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
