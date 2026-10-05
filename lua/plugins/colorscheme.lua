return {
  { "morhetz/gruvbox" },
  {
    -- theme.vim: colorscheme activo
    "navarasu/onedark.nvim",
    tag = "v0.1.0",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.onedark_config = {
        style = "deep",
      }
      vim.cmd.colorscheme("onedark")
    end,
  },
  { "ishan9299/nvim-solarized-lua" },
  { "crusoexia/vim-monokai" },
  { "rebelot/heirline.nvim" }, -- declarado pero sin setup() activo (igual que en la config original)
  { "maxmx03/solarized.nvim" },
  { "folke/tokyonight.nvim" },
  { "uloco/bluloco.nvim" },
  { "rktjmp/lush.nvim" },
  { "olimorris/onedarkpro.nvim" },
  { "oxfist/night-owl.nvim" },
}
