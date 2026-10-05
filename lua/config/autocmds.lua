-- vim-visual-multi tiene mappings propios para las teclas de insert.
-- <CR>, <Up> y <Down> se deshabilitan directamente en VM (ver
-- lua/plugins/navigation-ui.lua) para que blink.cmp sea el único dueño de
-- esas teclas durante el insert con multicursor.
--
-- No necesitamos interceptar <CR> con un autocmd: hacerlo provocaba una
-- carrera entre el mapping de VM y blink.cmp después de aceptar la primera
-- sugerencia, que podía terminar generando un salto de línea en el segundo
-- ciclo.



-- El único autocomando de la config original (cerrar Neo-tree al entrar
-- a un buffer normal) vivía dentro de config/neotree.vim junto a su setup().
-- Para mantener la misma agrupación, se conserva en lua/plugins/neotree.lua
-- en lugar de centralizarlo aquí. Este archivo queda como punto de extensión
-- para futuros autocomandos generales.

-- Bug de Neovim 0.12/0.12.1: la query nativa de markdown usa
-- (#set! conceal_lines "") en bloques de código, y ese predicado llama a
-- .range() sobre un nodo que puede ser nil, causando:
--   "attempt to call method 'range' (a nil value)" en vim/treesitter.lua
-- Esto se dispara al mostrar documentación/firma (blink.cmp, LSP hover) de
-- funciones cuyo JSDoc trae bloques de código (ej. "test"/"describe" de
-- Jest/Vitest). Se desactiva treesitter solo en esos buffers flotantes
-- (buftype "nofile"), sin afectar el resaltado de archivos .md reales.
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function(args)
		if vim.bo[args.buf].buftype == "nofile" then
			pcall(vim.treesitter.stop, args.buf)
		end
	end,
})
