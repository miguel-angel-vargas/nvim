local map = vim.keymap.set

-- ==============================
-- Mapeos generales (mappings.vim)
-- Nota: "nmap" en Vimscript es un mapeo RECURSIVO (remap = true).
-- "nnoremap" es NO recursivo (remap = false, comportamiento por defecto).
-- ==============================

map("n", "<leader>s", ":/", { remap = true })
map("n", "<leader>a", ":Neotree reveal<CR>", { remap = true })
map("n", "<leader>w", ":w<CR>", { remap = true })
map("n", "<leader>q", ":q<CR>", { remap = true })
map("n", "<leader>f", ":Telescope find_files<CR>", { remap = true })
map("n", "<leader>g", ":Telescope live_grep<CR>", { remap = true })
map("n", "<leader>aa", ":Neotree buffers<CR>", { remap = true })
map("n", "<leader>e", ":e<CR>", { remap = true })
map("n", "<leader>z", ":Telescope git_branches<CR>", { remap = true })
map("n", "<leader>d", ":bdelete<CR>", { remap = true })
map("n", "<leader>n", ":%s/", { remap = true })
map("n", "<leader>m", ":noh<CR>", { remap = true })
map("n", "<leader>l", ":m .", { remap = true })
map("n", "<leader>t", ":ToggleTerm direction=float<CR>", { remap = true })
map("n", "<leader>j'", "ysiw'", { remap = true })
map("n", '<leader>j"', 'ysiw"', { remap = true })
map("n", "<leader>j(", "ysiw(", { remap = true })
map("n", "<leader>j{", "ysiw{", { remap = true })
map("n", "<leader>y", vim.lsp.buf.code_action)

-- config commentary
map("n", "<leader>k", ":Commentary<CR>", {})
map("v", "<leader>k", ":Commentary<CR>", {})

-- recorrer el codigo cada 10 lineas
map("n", "<C-j>", "10<C-e>", {})
map("n", "<C-k>", "10<C-y>", {})

-- manejo de buffers
map("n", "<Tab>", ":BufferLineCycleNext<CR>", {})
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", {})
map("n", "<A-Right>", ":BufferLineMoveNext<CR>", {})
map("n", "<A-Left>", ":BufferLineMovePrev<CR>", {})
map("n", "<A-w>", "<cmd>wall<CR><cmd>%bd<CR>", {
    desc = "Guardar y cerrar todos los buffers",
})

-- ==============================
-- = Project y Tmux Navigator =
-- ==============================

vim.g.tmux_navigator_no_mappings = 1

map("n", "<C-Up>", ":TmuxNavigateUp<CR>", {})
map("n", "<C-Down>", ":TmuxNavigateDown<CR>", {})
map("n", "<C-Left>", ":TmuxNavigateLeft<CR>", {})
map("n", "<C-Right>", ":TmuxNavigateRight<CR>", {})

vim.g.UltiSnipsExpandTrigger = "<nop>"

-- ==============================
-- Format (Conform)
-- ==============================

map("n", "<leader>p", function()
    require("conform").format({
        async = true,
        lsp_fallback = false,
    })
end, { desc = "Format buffer" })
