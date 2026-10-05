return {
    "mfussenegger/nvim-dap",

    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-neotest/nvim-nio",
    },

    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup()

        --------------------------------------------------
        -- PHP DEBUG ADAPTER
        --------------------------------------------------

        dap.adapters.php = {
            type = "executable",
            command = "node",
            args = {
                vim.fn.stdpath("data")
                    .. "\\mason\\packages\\php-debug-adapter\\extension\\out\\phpDebug.js",
            },
        }

        --------------------------------------------------
        -- PHP CONFIGURATION
        --------------------------------------------------

        dap.configurations.php = {
            {
                type = "php",
                request = "launch",
                name = "Listen for Xdebug",
                port = 9003,
            },
        }

        --------------------------------------------------
        -- DAP UI
        --------------------------------------------------

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end

        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end

        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        --------------------------------------------------
        -- KEYMAPS
        --------------------------------------------------

        vim.keymap.set("n", "<F5>", dap.continue)
        vim.keymap.set("n", "<F10>", dap.step_over)
        vim.keymap.set("n", "<F11>", dap.step_into)
        vim.keymap.set("n", "<F12>", dap.step_out)

        vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
        vim.keymap.set("n", "<leader>du", dapui.toggle)
    end,
}
