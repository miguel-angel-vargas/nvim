return {
    {
        "mason-org/mason.nvim",

        cmd = "Mason",

        opts = {
            ui = {
                border = "rounded",

                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
    },

    {
        "mason-org/mason-lspconfig.nvim",

        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },

        opts = {

            ensure_installed = {

                -- Lua
                "lua_ls",

                -- PHP
                "intelephense",

                -- Python
                "pyright",

                -- Web
                "html",
                "cssls",
                "jsonls",
                "emmet_language_server",

                -- JS / TS
                "ts_ls",

                -- Angular
                "angularls",

                -- SQL
                "sqlls",

                -- C#
                "omnisharp",

                -- Java (el LSP lo arranca nvim-jdtls, no mason-lspconfig)
                "jdtls",

            },

            automatic_enable = true,

        },
    },

    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",

        dependencies = {
            "mason-org/mason.nvim",
        },

        opts = {

            ensure_installed = {

                -----------------------------
                -- Formatters
                -----------------------------

                "stylua",

                "prettier",

                "black",

                "isort",

                "php-cs-fixer",

                "sql-formatter",

                "shfmt",

                -----------------------------
                -- Linters
                -----------------------------

                "eslint_d",

                "markdownlint",

                "shellcheck",

            },

            auto_update = false,

            run_on_start = true,

            start_delay = 3000,

        },
    },
}
