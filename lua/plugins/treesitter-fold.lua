return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        build = ":TSUpdate",
        config = function()
            -- nvim-treesitter fue archivado (sin mantenimiento) y su
            -- query_predicates.lua no es compatible con el nuevo formato de
            -- match[id] de Neovim 0.12, lo que causaba el crash
            -- "attempt to call method 'range' (a nil value)" al tipear en tsx.
            --
            -- Por eso YA NO llamamos a require("nvim-treesitter.configs").setup(...):
            -- Neovim 0.12 trae highlighting nativo activado por defecto para los
            -- parsers instalados, sin necesitar esa capa del plugin.
            --
            -- Dejamos el plugin solo para poder instalar/actualizar parsers.
            require("nvim-treesitter.install").compilers = { "zig" }

            -- Solo instala los parsers que falten (no fuerza reinstalar los
            -- que ya existen, para no descargar/compilar en cada arranque).
            local parsers = {
                "lua",
                "vim",
                "vimdoc",
                "javascript",
                "typescript",
                "tsx",
                "html",
                "css",
                "json",
                "php",
                "python",
                "bash",
            }

            local installed = require("nvim-treesitter.info").installed_parsers()
            local installed_set = {}
            for _, name in ipairs(installed) do
                installed_set[name] = true
            end

            local missing = {}
            for _, name in ipairs(parsers) do
                if not installed_set[name] then
                    table.insert(missing, name)
                end
            end

            if #missing > 0 then
                vim.cmd("TSInstall " .. table.concat(missing, " "))
            end
        end,
    },
    { "kevinhwang91/promise-async" },

    -- statuscol.vim
    {
        "luukvbaal/statuscol.nvim",
        config = function()
            local builtin = require("statuscol.builtin")

            require("statuscol").setup({
                setopt = true,

                segments = {
                    -- Solo la flecha del fold (sin números)
                    {
                        text = { builtin.foldfunc },
                        click = "v:lua.ScFa",
                    },

                    -- Signos de Git, LSP, etc.
                    {
                        text = { "%s" },
                        click = "v:lua.ScSa",
                    },

                    -- Números de línea
                    {
                        text = { builtin.lnumfunc, " " },
                        click = "v:lua.ScLa",
                    },
                },
            })
        end,
    },
}
