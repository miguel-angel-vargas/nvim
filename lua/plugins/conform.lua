return {
    {
        "stevearc/conform.nvim",

        event = { "BufWritePre" },

        cmd = { "ConformInfo" },

        opts = {

            ------------------------------------------------------------------
            -- Formateadores por FileType
            ------------------------------------------------------------------

            formatters_by_ft = {

                lua = { "stylua" },

                javascript = { "prettier" },
                javascriptreact = { "prettier" },

                typescript = { "prettier" },
                typescriptreact = { "prettier" },

                vue = { "prettier" },
                angular = { "prettier" },

                html = { "prettier" },
                css = { "prettier" },
                scss = { "prettier" },
                less = { "prettier" },

                json = { "prettier" },
                jsonc = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                graphql = { "prettier" },

                php = { "php_cs_fixer" },

                python = {
                    "isort",
                    "black",
                },

                sql = { "sql_formatter" },

                sh = { "shfmt" },
                bash = { "shfmt" },
                zsh = { "shfmt" },
            },

            ------------------------------------------------------------------
            -- 🔥 FORZAR TAB GLOBAL EN FORMATTERS
            ------------------------------------------------------------------

            formatters = {

                prettier = {
                    prepend_args = {
                        "--use-tabs",
                        "--tab-width",
                        "4",
                    },
                },

                shfmt = {
                    prepend_args = {
                        "-i",
                        "4",
                        "-s",
                        "-ci",
                        "-sr",
                    },
                },

                stylua = {
                    prepend_args = {
                        "--indent-type",
                        "Spaces",
                        "--indent-width",
                        "4",
                    },
                },
            },

            ------------------------------------------------------------------
            -- Formateo al guardar
            ------------------------------------------------------------------

            -- format_on_save = {

            --     timeout_ms = 3000,

            --     lsp_fallback = false, -- 👈 IMPORTANTE: evita que el LSP meta 2 espacios
            -- },

            ------------------------------------------------------------------
            -- Opciones por defecto
            ------------------------------------------------------------------

            default_format_opts = {

                lsp_format = "never", -- 👈 evita conflictos con LSP
            },

            ------------------------------------------------------------------
            -- Notificaciones
            ------------------------------------------------------------------

            notify_on_error = true,

            notify_no_formatters = false,
        },

        ----------------------------------------------------------------------
        -- Keymaps
        ----------------------------------------------------------------------

        keys = {

            {
                "<leader>fm",
                function()
                    require("conform").format({
                        async = true,
                        lsp_fallback = false,
                    })
                end,
                desc = "Format Buffer",
            },
        },
    },
}
