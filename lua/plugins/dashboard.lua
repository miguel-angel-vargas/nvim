return {
  "nvimdev/dashboard-nvim",
  config = function()
    require("dashboard").setup({
      theme = "hyper",

      config = {
        header = {},

        week_header = {
          enable = true,
        },

        disable_move = true, -- evita que el cursor caiga en líneas sin contenido clicable (fix del crash de math.min en hyper.lua)

        shortcut = {
          {
            desc = "󰊳 Update",
            group = "@property",
            action = "Lazy update",
            key = "u",
          },
          {
            desc = " Files",
            group = "Label",
            action = "Telescope find_files",
            key = "f",
          },
          {
            desc = " Apps",
            group = "DiagnosticHint",
            action = "Telescope app",
            key = "a",
          },
          {
            desc = " Dotfiles",
            group = "Number",
            action = "Telescope dotfiles",
            key = "d",
          },
        },

        project = {
          enable = true,
          limit = 8,
          icon = "󰉋 ",
          label = "Recently Projects",
        },

        mru = {
          enable = true,
          limit = 10,
          icon = "󰈚 ",
          label = "Most Recent Files",
        },

        footer = {
          "",
          "🚀 Sharp tools make good work.",
        },
      },
    })
  end,
}
