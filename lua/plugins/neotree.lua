return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    vim.opt.splitright = true -- Splits verticales se abren a la derecha
    vim.opt.splitbelow = true

    -- Configuración de Neo-tree
    require("neo-tree").setup({
      close_if_last_window = true, -- Cierra Neo-tree si es la última ventana abierta
      popup_border_style = "rounded", -- Estilo del borde de las ventanas emergentes
      enable_git_status = true, -- Habilita indicadores de estado de Git
      enable_diagnostics = true, -- Habilita los diagnósticos (LSP)
      filesystem = {
        filtered_items = {
          visible = true, -- Muestra archivos ocultos por defecto
          hide_dotfiles = false, -- No ocultar archivos que inician con "."
          hide_gitignored = false, -- No ocultar archivos ignorados por Git
        },
        follow_current_file = {
          enabled = true, -- Cambia automáticamente al archivo abierto actual
        },
        use_libuv_file_watcher = true, -- Actualización automática de cambios en el sistema de archivos
      },
      window = {
        position = "float", -- Ubicación del panel (puede ser "left", "right", "top", "bottom")
        width = 30, -- Ancho del panel
        mappings = {
          ["<CR>"] = {
            "open",
            config = {
              quit_on_open = true, -- Cierra Neo-tree al abrir un archivo
            },
          },
          ["s"] = "open_vsplit", -- Abrir archivo en un vsplit
          ["v"] = "open_split", -- Abrir archivo en un split horizontal
          ["t"] = "open_tabnew", -- Abrir archivo en una nueva pestaña
          ["C"] = "close_node", -- Cerrar carpeta
          ["z"] = "close_all_nodes", -- Cierra todas las carpetas
          ["R"] = "refresh", -- Refrescar el árbol
          ["a"] = {
            "add",
            config = {
              show_path = "relative", -- Mostrar ruta relativa al añadir un archivo
            },
          },
          ["m"] = "move", -- Mover o renombrar archivo
          ["d"] = "delete", -- Eliminar archivo
        },
      },
      git_status = {
        window = {
          position = "float", -- Muestra estado de Git en una ventana flotante
        },
      },
    })

    -- Cerrar el árbol de Neo-tree automáticamente al abrir un archivo
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*",
      callback = function()
        if vim.fn.getbufvar(0, "&buftype") == "" and vim.bo.filetype ~= "neo-tree" then
          vim.cmd("Neotree close")
        end
      end,
    })
  end,
}
