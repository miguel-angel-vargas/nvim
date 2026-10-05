return {
    {
        "saghen/blink.cmp",

        version = "*",

        dependencies = {

            "rafamadriz/friendly-snippets",

            "L3MON4D3/LuaSnip",

        },

        opts = {
            ------------------------------------------------------------------
            -- Keymap
            ------------------------------------------------------------------

            keymap = {

                preset = "default",

                ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },

                ["<CR>"] = { "accept", "fallback" },

                ["<Tab>"] = {
                    "select_next",
                    "snippet_forward",
                    "fallback",
                },

                ["<S-Tab>"] = {
                    "select_prev",
                    "snippet_backward",
                    "fallback",
                },

                ["<Up>"] = { "select_prev", "fallback" },

                ["<Down>"] = { "select_next", "fallback" },

            },

            ------------------------------------------------------------------
            -- Appearance
            ------------------------------------------------------------------

            appearance = {

                nerd_font_variant = "mono",

            },

            ------------------------------------------------------------------
            -- Completion
            ------------------------------------------------------------------

            completion = {

                accept = {
                    auto_brackets = {
                        enabled = true,
                    },
                },

                documentation = {

                    auto_show = true,

                    auto_show_delay_ms = 200,

                    window = {
                        border = "rounded",
                    },

                },

                menu = {

                    border = "rounded",

                    draw = {

                        columns = {

                            { "kind_icon" },

                            { "label", "label_description", gap = 1 },

                            { "kind" },

                        },

                    },

                },

                ghost_text = {

                    enabled = true,

                },

            },

            ------------------------------------------------------------------
            -- Signature
            ------------------------------------------------------------------

            signature = {

                enabled = true,

                trigger = {

                    -- no mostrarla sola al escribir "(" o "," — solo cuando la pidas
                    show_on_trigger_character = false,
                    show_on_insert_on_trigger_character = false,

                },

                window = {

                    border = "rounded",

                    -- prioriza mostrar el cuadro de firma ABAJO del cursor ('s')
                    -- en vez de arriba ('n'), para no tapar el código superior
                    direction_priority = { "s", "n" },

                },

            },

            ------------------------------------------------------------------
            -- Snippets
            ------------------------------------------------------------------

            snippets = {

                preset = "luasnip",

            },

            ------------------------------------------------------------------
            -- Sources
            ------------------------------------------------------------------

            sources = {

                default = {

                    "lsp",

                    "path",

                    "snippets",

                    "buffer",

                },

            },

            ------------------------------------------------------------------
            -- Fuzzy
            ------------------------------------------------------------------

            fuzzy = {

                implementation = "prefer_rust_with_warning",

            },

        },

        opts_extend = {

            "sources.default",

        },

    },
}
