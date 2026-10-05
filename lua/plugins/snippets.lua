return {
    {
        "L3MON4D3/LuaSnip",

        version = "v2.*",

        build = (function()
            if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                return
            end

            return "make install_jsregexp"
        end)(),

        dependencies = {
            "rafamadriz/friendly-snippets",
        },

        config = function()

            local luasnip = require("luasnip")

            ------------------------------------------------------------------
            -- Configuración
            ------------------------------------------------------------------

            luasnip.config.setup({

                history = true,

                updateevents = "TextChanged,TextChangedI",

                delete_check_events = "TextChanged",

                enable_autosnippets = true,

            })

            ------------------------------------------------------------------
            -- Cargar snippets de VSCode
            ------------------------------------------------------------------

            require("luasnip.loaders.from_vscode").lazy_load()

            ------------------------------------------------------------------
            -- Cargar snippets propios en formato Lua nativo (carpeta ./luasnippets)
            --
            -- Nota: "luasnip.loaders.from_ultisnips" NO existe como módulo
            -- en LuaSnip (nunca existió). El formato nativo de Lua es el
            -- único que soporta todo lo que usan nuestros snippets (nombre
            -- por defecto = nombre de archivo, capitalización automática
            -- para setters de useState, etc.), así que los snippets viven
            -- en ./luasnippets/*.lua en vez de ./UltiSnips/*.snippets.
            ------------------------------------------------------------------

            require("luasnip.loaders.from_lua").lazy_load()

        end,
    },
}
