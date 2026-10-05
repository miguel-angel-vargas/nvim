local opt = vim.opt

--------------------------------------------------
-- Apariencia
--------------------------------------------------

opt.number = true
opt.relativenumber = true
opt.cursorline = true

opt.showmode = false
opt.showcmd = true
opt.ruler = true

opt.signcolumn = "yes"

opt.colorcolumn = ""

opt.background = "dark"

opt.wrap = false

opt.termguicolors = true

opt.scrolloff = 8
opt.sidescrolloff = 8

opt.showtabline = 2

--------------------------------------------------
-- Tabs & Indentation
--------------------------------------------------

opt.expandtab = false -- Usa TAB reales
opt.smarttab = true

opt.tabstop = 4 -- Tamaño visual del TAB
opt.softtabstop = 4 -- TAB al editar
opt.shiftwidth = 4 -- Indentación

opt.autoindent = true
opt.smartindent = true
opt.breakindent = true
opt.shiftround = true

--------------------------------------------------
-- Búsqueda
--------------------------------------------------

opt.ignorecase = true
opt.smartcase = true

opt.incsearch = true
opt.hlsearch = true

opt.wrapscan = true

--------------------------------------------------
-- Sistema
--------------------------------------------------

opt.clipboard = "unnamedplus"

opt.mouse = "a"

--------------------------------------------------
-- Archivos
--------------------------------------------------

opt.backup = false
opt.writebackup = false
opt.swapfile = false

opt.undofile = true

opt.autoread = true

--------------------------------------------------
-- Comportamiento
--------------------------------------------------

opt.wildmenu = true

opt.wildmode = {
	"longest:full",
	"full",
}

opt.updatetime = 300

opt.timeoutlen = 500

opt.completeopt = {
	"menu",
	"menuone",
	"noselect",
}

--------------------------------------------------
-- Folding
--------------------------------------------------

opt.foldcolumn = "1"

opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

opt.fillchars = {

	foldopen = "",

	foldclose = "",

	foldsep = " ",
}

--------------------------------------------------
-- Globals
--------------------------------------------------

vim.g.indent_blankline_char = "│"

--------------------------------------------------
-- Python
--------------------------------------------------

vim.g.python3_host_prog = "C:/Users/migue/AppData/Local/Programs/Python/Python314/python.exe"
