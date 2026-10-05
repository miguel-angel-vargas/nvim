return {
    {
        "kevinhwang91/nvim-ufo",

        dependencies = {
            "kevinhwang91/promise-async",
        },

        event = "BufReadPost",

        opts = {

            ------------------------------------------------------------------
            -- Folding
            ------------------------------------------------------------------

            open_fold_hl_timeout = 150,

            close_fold_kinds_for_ft = {

                default = {
                    "imports",
                    "comment",
                },
            },

            preview = {

                border = "rounded",

                win_config = {
                    winblend = 0,
                },

                mappings = {
                    scrollU = "<C-u>",
                    scrollD = "<C-d>",
                },
            },

            provider_selector = function(_, filetype, _)
                if filetype == "markdown" then
                    return { "treesitter", "indent" }
                end

                -- ts_ls (typescript-language-server) tarda en inicializar el
                -- workspace y su folding vía LSP es poco confiable con ufo;
                -- usamos "treesitter"/"indent", que no dependen del LSP.
                local ts_family = {
                    typescript = true,
                    typescriptreact = true,
                    javascript = true,
                    javascriptreact = true,
                }

                if ts_family[filetype] then
                    return { "treesitter", "indent" }
                end

                return { "lsp", "indent" }
            end,
        },

        config = function(_, opts)
            ------------------------------------------------------------------
            -- Opciones de Neovim
            ------------------------------------------------------------------

            vim.o.foldcolumn = "1"

            vim.o.foldlevel = 99

            vim.o.foldlevelstart = 99

            vim.o.foldenable = true

            ------------------------------------------------------------------
            -- Setup
            ------------------------------------------------------------------

            require("ufo").setup(opts)

            ------------------------------------------------------------------
            -- Keymaps
            ------------------------------------------------------------------

            local ufo = require("ufo")

            vim.keymap.set("n", "zR", ufo.openAllFolds, {
                desc = "Open all folds",
            })

            vim.keymap.set("n", "zM", ufo.closeAllFolds, {
                desc = "Close all folds",
            })

            vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds, {
                desc = "Open folds",
            })

            vim.keymap.set("n", "zm", ufo.closeFoldsWith, {
                desc = "Close folds",
            })

            vim.keymap.set("n", "zp", ufo.peekFoldedLinesUnderCursor, {
                desc = "Peek Fold",
            })
        end,
    },
}

