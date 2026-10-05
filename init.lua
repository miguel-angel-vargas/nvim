-- mapleader debe definirse ANTES de cargar lazy.nvim / plugins,
-- porque los specs de plugins pueden usar <leader> al definirse.
vim.g.mapleader = " "

require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")
