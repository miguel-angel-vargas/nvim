return {
  { "nvim-tree/nvim-web-devicons" }, -- íconos para plugins como tabby o nerdtree
  { "nanozuki/tabby.nvim" },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          separator_style = "slant", -- o 'padded_slant', 'thick', 'thin', etc.
          diagnostics = "nvim_lsp",
          show_buffer_icons = true,
          show_close_icon = false,
          show_tab_indicators = false,
          always_show_bufferline = true,
        },
      })
    end,
  },
}
