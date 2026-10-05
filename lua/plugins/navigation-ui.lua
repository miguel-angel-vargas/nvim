return {
  { "easymotion/vim-easymotion" },
  { "christoomey/vim-tmux-navigator" },
  {
    "mg979/vim-visual-multi",
    init = function()
      -- Blink.cmp debe controlar <CR>, <Up> y <Down> durante el insert
      -- con multicursor. VM tiene mappings propios para esas teclas y los
      -- aplica como buffer-local, por lo que terminan sobrescribiendo a
      -- blink.cmp y producen saltos de línea/movimiento de cursores.
      --
      -- Dejamos deshabilitados SOLO esos mappings de VM. Los cursores siguen
      -- funcionando normalmente y VM conserva el resto de sus mappings.
      vim.g.VM_maps = {
        ["I BS"] = "<BS>",
        ["I Return"] = "",
        ["I Up Arrow"] = "",
        ["I Down Arrow"] = "",
      }
      vim.g.VM_mouse_mappings = 0
    end,
  },

  -- noice.vim
  {
    "folke/noice.nvim",
    dependencies = { "rcarriga/nvim-notify" },
    config = function()
      local notify = require("notify")
      vim.notify = notify

      notify.setup({
        stages = "fade_in_slide_out",
        timeout = 3000,
        max_width = 80,
      })

      require("noice").setup({
        cmdline = {
          enabled = true,
          view = "cmdline_popup",
          format = {
            cmdline = { pattern = "^:", icon = "", lang = "vim" },
            search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
            search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
            filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
            lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
            help = { pattern = "^:%s*he?l?p?%s+", icon = "?", lang = "vim" },
            input = {},
          },
        },
        messages = {
          enabled = true,
          view = "mini",
          view_error = "notify",
          view_warn = "notify",
          view_history = "messages",
        },
        notify = {
          enabled = true,
          view = "notify",
        },
        popupmenu = {
          enabled = true,
          backend = "nui",
        },
        throttle = 1000 / 60,
        views = {},
      })
    end,
  },

  -- indent.vim
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup()
    end,
  },
}
