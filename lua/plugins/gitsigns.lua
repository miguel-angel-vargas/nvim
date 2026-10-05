return {
    {
        "lewis6991/gitsigns.nvim",

        event = { "BufReadPre", "BufNewFile" },

        opts = {

            ------------------------------------------------------------------
            -- Signos
            ------------------------------------------------------------------

            signs = {
                add          = { text = "│" },
                change       = { text = "│" },
                delete       = { text = "_" },
                topdelete    = { text = "‾" },
                changedelete = { text = "~" },
                untracked    = { text = "┆" },
            },

            ------------------------------------------------------------------
            -- Blame
            ------------------------------------------------------------------

            current_line_blame = false,

            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol",
                delay = 500,
                ignore_whitespace = false,
            },

            ------------------------------------------------------------------
            -- Preview
            ------------------------------------------------------------------

            preview_config = {
                border = "rounded",
                style = "minimal",
            },

            ------------------------------------------------------------------
            -- Performance
            ------------------------------------------------------------------

            watch_gitdir = {
                follow_files = true,
            },

            attach_to_untracked = true,

            sign_priority = 6,

            update_debounce = 100,

            max_file_length = 40000,

        },

        config = function(_, opts)

            require("gitsigns").setup(opts)

            local gs = require("gitsigns")

            ------------------------------------------------------------------
            -- Navegación
            ------------------------------------------------------------------

            vim.keymap.set("n", "]h", gs.next_hunk, {
                desc = "Next Hunk",
            })

            vim.keymap.set("n", "[h", gs.prev_hunk, {
                desc = "Previous Hunk",
            })

            ------------------------------------------------------------------
            -- Acciones
            ------------------------------------------------------------------

            vim.keymap.set("n", "<leader>hs", gs.stage_hunk, {
                desc = "Stage Hunk",
            })

            vim.keymap.set("n", "<leader>hr", gs.reset_hunk, {
                desc = "Reset Hunk",
            })

            vim.keymap.set("v", "<leader>hs", function()

                gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })

            end, {
                desc = "Stage Selection",
            })

            vim.keymap.set("v", "<leader>hr", function()

                gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })

            end, {
                desc = "Reset Selection",
            })

            ------------------------------------------------------------------
            -- Buffer
            ------------------------------------------------------------------

            vim.keymap.set("n", "<leader>hS", gs.stage_buffer, {
                desc = "Stage Buffer",
            })

            vim.keymap.set("n", "<leader>hR", gs.reset_buffer, {
                desc = "Reset Buffer",
            })

            ------------------------------------------------------------------
            -- Preview
            ------------------------------------------------------------------

            vim.keymap.set("n", "<leader>hp", gs.preview_hunk, {
                desc = "Preview Hunk",
            })

            vim.keymap.set("n", "<leader>hb", gs.blame_line, {
                desc = "Blame Line",
            })

            vim.keymap.set("n", "<leader>hd", gs.diffthis, {
                desc = "Diff This",
            })

            vim.keymap.set("n", "<leader>hD", function()

                gs.diffthis("~")

            end, {
                desc = "Diff HEAD~",
            })

            ------------------------------------------------------------------
            -- Toggle
            ------------------------------------------------------------------

            vim.keymap.set("n", "<leader>tb", gs.toggle_current_line_blame, {
                desc = "Toggle Git Blame",
            })

            vim.keymap.set("n", "<leader>td", gs.toggle_deleted, {
                desc = "Toggle Deleted",
            })

        end,

    },
}