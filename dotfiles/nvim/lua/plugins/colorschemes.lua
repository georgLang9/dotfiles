return {
  -- Saves and loads a colorscheme across sessions
  {
    "https://git.sr.ht/~swaits/colorsaver.nvim",
    lazy = true,
    event = "VimEnter",
    -- Define overrides to any highlight arguments here; this is an optional argument
    -- to the generate function.
  }, -- https://git.sr.ht/%7Eswaits/colorsaver.nvim

  -- Set default colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  {
    "water-sucks/darkrose.nvim",
    opts = {
      colors = {
        bg = "#20111B", -- match with terminal theme bg color
        fg_dark = "#883F42", -- lualine color
      },
    },
  }, -- https://github.com/water-sucks/darkrose.nvim
  { "rose-pine/neovim" }, -- https://github.com/rose-pine/neovim
  { "scottmckendry/cyberdream.nvim" }, -- https://github.com/scottmckendry/cyberdream.nvim
  { "rktjmp/lush.nvim" }, -- https://github.com/rktjmp/lush.nvim
  { "rebelot/kanagawa.nvim" }, -- https://github.com/rebelot/kanagawa.nvim
  { "ellisonleao/gruvbox.nvim" }, -- https://github.com/ellisonleao/gruvbox.nvim
  { "kepano/flexoki" }, -- https://github.com/kepano/flexoki
  { "nyoom-engineering/nyoom.nvim" }, -- https://github.com/nyoom-engineering/nyoom.nvim
  { "rmehri01/onenord.nvim" }, -- https://github.com/rmehri01/onenord.nvim
  { "patstockwell/vim-monokai-tasty" }, -- https://github.com/patstockwell/vim-monokai-tasty
  { "ray-x/aurora" }, -- https://github.com/ray-x/aurora
  { "uloco/bluloco.nvim" }, -- https://github.com/uloco/bluloco.nvim
  { "oxfist/night-owl.nvim" }, -- https://github.com/oxfist/night-owl.nvim
  { "dasupradyumna/midnight.nvim" }, -- https://github.com/dasupradyumna/midnight.nvim
  { "AhmedAbdulrahman/aylin.vim" }, -- https://github.com/AhmedAbdulrahman/aylin.vim
  { "rileytwo/kiss" }, -- https://github.com/rileytwo/kiss
  { "kartikp10/noctis.nvim" }, -- https://github.com/kartikp10/noctis.nvim
  { "yonlu/omni.vim" }, -- https://github.com/yonlu/omni.vim
  { "Abstract-IDE/Abstract-cs" }, -- https://github.com/Abstract-IDE/Abstract-cs
  { "zootedb0t/citruszest.nvim" }, -- https://github.com/zootedb0t/citruszest.nvim
  { "blazkowolf/gruber-darker.nvim" }, -- https://github.com/blazkowolf/gruber-darker.nvim
  { "polirritmico/monokai-nightasty.nvim" }, -- https://github.com/polirritmico/monokai-nightasty.nvim
  { "yorik1984/newpaper.nvim" }, -- https://github.com/yorik1984/newpaper.nvim
  { "talha-akram/noctis.nvim" }, -- https://github.com/talha-akram/noctis.nvim
  { "fynnfluegge/monet.nvim" }, -- https://github.com/fynnfluegge/monet.nvim
  { "lighthaus-theme/vim-lighthaus" }, -- https://github.com/lighthaus-theme/vim-lighthaus
  { "elvessousa/sobrio" }, -- https://github.com/elvessousa/sobrio
  { "baliestri/aura-theme" }, -- https://github.com/baliestri/aura-theme
  { "kihachi2000/yash.nvim" }, -- https://github.com/kihachi2000/yash.nvim
  { "Scysta/pink-panic.nvim" }, -- https://github.com/Scysta/pink-panic.nvim
  { "DeviusVim/deviuspro.nvim" }, -- https://github.com/DeviusVim/deviuspro.nvim
}
