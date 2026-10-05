return {
    {
        "windwp/nvim-autopairs",

        event = "InsertEnter",

        opts = {

            ------------------------------------------------------------------
            -- Opciones generales
            ------------------------------------------------------------------

            check_ts = true,

            disable_filetype = {
                "TelescopePrompt",
                "spectre_panel",
            },

            enable_check_bracket_line = true,

            ignored_next_char = "[%w%.]",

            fast_wrap = {},

        },

        config = function(_, opts)

            local autopairs = require("nvim-autopairs")

            autopairs.setup(opts)

            ------------------------------------------------------------------
            -- Integración con Blink
            ------------------------------------------------------------------

            local ok, blink = pcall(require, "blink.cmp")

            if ok then

                blink.setup({

                    completion = {

                        accept = {

                            auto_brackets = {

                                enabled = true,

                            },

                        },

                    },

                })

            end

        end,

    },
}