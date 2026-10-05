return {
	{
		"neovim/nvim-lspconfig",

		dependencies = {
			"saghen/blink.cmp",
		},

		config = function()
			------------------------------------------------------------
			-- Capabilities
			------------------------------------------------------------

			vim.lsp.config("*", {

				capabilities = require("blink.cmp").get_lsp_capabilities({
					textDocument = {
						-- necesario para que nvim-ufo reciba folds del LSP (ej. typescript)
						foldingRange = {
							dynamicRegistration = false,
							lineFoldingOnly = true,
						},
					},
				}),

				on_attach = function(client, bufnr)
					client.server_capabilities.documentFormattingProvider = false
				end,
			})

			------------------------------------------------------------
			-- Diagnósticos
			------------------------------------------------------------

			vim.diagnostic.config({

				underline = true,

				severity_sort = true,

				update_in_insert = false,

				virtual_text = {

					spacing = 4,

					source = "if_many",
				},

				float = {

					border = "rounded",

					source = "if_many",
				},

				signs = true,
			})

			------------------------------------------------------------
			-- Keymaps
			------------------------------------------------------------

			vim.api.nvim_create_autocmd("LspAttach", {

				callback = function(event)
					local opts = {
						buffer = event.buf,
						silent = true,
					}

					----------------------------------------------------
					-- Navegación
					----------------------------------------------------

					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

					vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)

					----------------------------------------------------
					-- Información
					----------------------------------------------------

					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

					-- vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)

					----------------------------------------------------
					-- Acciones
					----------------------------------------------------

					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

					----------------------------------------------------
					-- Diagnósticos
					----------------------------------------------------

					vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

					vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

					vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)

					----------------------------------------------------
					-- Inlay Hints
					----------------------------------------------------

					if vim.lsp.inlay_hint then
						vim.keymap.set("n", "<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end, opts)
					end
				end,
			})

			------------------------------------------------------------
			-- Configuración de servidores
			------------------------------------------------------------

			vim.lsp.config("lua_ls", {

				settings = {

					Lua = {

						telemetry = {

							enable = false,
						},

						diagnostics = {

							globals = { "vim" },
						},

						workspace = {

							checkThirdParty = false,
						},
					},
				},
			})
		end,
	},
}

