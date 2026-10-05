return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      -- no se activa en el buffer de neo-tree ni en otros buffers especiales
      disable_filetype = { "TelescopePrompt", "neo-tree" },
    },
  },
  {
    "alvan/vim-closetag",
    init = function()
      -- vimCloseTag.vim
      vim.g.closetag_filenames = "*.html,*.xhtml,*.phtml,*.tsx,*.jsx"
      vim.g.closetag_filetypes = "html,xhtml,phtml,javascriptreact,typescriptreact"
      vim.g.closetag_xhtml_filenames = "*.jsx,*.tsx"
      vim.g.closetag_emptyTags_caseSensitive = 1
      vim.g.closetag_shortcut = ">"
    end,
  },
  { "tpope/vim-surround" },
  { "AndrewRadev/tagalong.vim" },
}
