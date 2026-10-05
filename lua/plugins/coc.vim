return {
  {
    "neoclide/coc.nvim",
    branch = "release",
    config = function()
      vim.cmd([[
        inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

        inoremap <silent><expr> <Tab> pumvisible() ? coc#pum#next(1) :
              \ coc#expandable() ? '<C-r>=coc#rpc#request("doKeymap", ["snippets-expand", ""])<CR>' :
              \ "\<Tab>"

        inoremap <silent><expr> <S-Tab> pumvisible() ? coc#pum#prev(1) : "\<C-h>"

        inoremap <silent><expr> <C-Space> coc#refresh()
      ]])
    end,
  },

  {
    "yaegassy/coc-intelephense",
    build = "yarn install --frozen-lockfile",
  },
}