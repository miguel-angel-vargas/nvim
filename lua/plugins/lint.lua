return {
    {
        "mfussenegger/nvim-lint",

        event = {
            "BufReadPre",
            "BufNewFile",
        },

        config = function()

            local lint = require("lint")

            ------------------------------------------------------------------
            -- Linters por FileType
            ------------------------------------------------------------------

            lint.linters_by_ft = {

                javascript = { "eslint_d" },

                javascriptreact = { "eslint_d" },

                typescript = { "eslint_d" },

                typescriptreact = { "eslint_d" },

                vue = { "eslint_d" },

                markdown = { "markdownlint" },

                python = { "pylint" },

                php = { "phpcs" },

                sh = { "shellcheck" },

                bash = { "shellcheck" },

                zsh = { "shellcheck" },

            }

            ------------------------------------------------------------------
            -- Ejecutar automáticamente
            ------------------------------------------------------------------

            local group = vim.api.nvim_create_augroup("nvim-lint", {
                clear = true,
            })

            vim.api.nvim_create_autocmd({

                "BufEnter",
                "BufWritePost",
                "InsertLeave",

            }, {

                group = group,

                callback = function()

                    lint.try_lint()

                end,

            })

        end,
    },
}