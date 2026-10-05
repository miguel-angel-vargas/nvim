# Notas de la migración .vim → .lua (lazy.nvim)

Migración 1:1: mismos plugins, mismos mapeos, mismas opciones. Solo cambia
la sintaxis (Vimscript → Lua) y el gestor de plugins (vim-plug → lazy.nvim).

## Instalación

1. Localiza tu carpeta de config actual: `~\AppData\Local\nvim` (Windows).
2. Haz un respaldo de esa carpeta completa (por si acaso).
3. Reemplaza su contenido por el de este paquete, manteniendo el nombre
   `nvim` de la carpeta.
4. Abre Neovim. lazy.nvim se instalará solo la primera vez y descargará
   todos los plugins (puede tardar un par de minutos).
5. Como algunos plugins vienen de coc.nvim/UltiSnips, asegúrate de tener
   Node.js/Yarn instalados igual que antes (coc-intelephense y
   markdown-preview.nvim lo requieren para su `build`).

## Dónde quedó cada cosa

| Original | Nuevo |
|---|---|
| `config/plugins.vim` | `lua/plugins/*.lua` (agrupados igual que en el original) |
| `config/options.vim` | `lua/config/options.lua` |
| `config/mappings.vim` + `config/coc.vim` | `lua/config/keymaps.lua` |
| `config/theme.vim` | `lua/plugins/colorscheme.lua` |
| `config/neotree.vim` (incluye su autocomando) | `lua/plugins/neotree.lua` |
| `config/dashboard.vim` | `lua/plugins/dashboard.lua` |
| `config/project_nvim.vim` | `lua/plugins/project.lua` |
| `config/toggleterm.vim` | `lua/plugins/toggleterm.lua` |
| `config/bufferline.vim` | `lua/plugins/bufferline.lua` |
| `config/indent.vim` | `lua/plugins/navigation-ui.lua` |
| `config/noice.vim` | `lua/plugins/navigation-ui.lua` |
| `config/vimCloseTag.vim` | `lua/plugins/editing.lua` |
| `config/ufo.vim` + `config/statuscol.vim` | `lua/plugins/treesitter-fold.lua` |
| `coc-settings.json`, `.prettierrc`, `.gitignore`, `UltiSnips/` | Sin cambios, copiados tal cual |

## Decisiones tomadas (confirmadas contigo antes de aplicarlas)

- **`config/heirline.vim`**: en tu `init.vim` original no tenía línea
  `source`, es decir, nunca se cargaba. Se mantuvo igual: el plugin
  `heirline.nvim` está declarado (se instala) pero sin `setup()` activo.
- **`project_nvim.setup()` duplicado**: se llamaba dos veces (una vacía en
  `mappings.vim`, sobrescrita por la de `project_nvim.vim`). Se dejó una
  sola llamada con la configuración completa, que es el comportamiento
  que ya tenías en la práctica.

## Único cambio no evitable: ruta de instalación de plugins

Al cambiar de gestor (vim-plug → lazy.nvim, que pediste explícitamente),
los plugins ya no se instalan en `~/AppData/Local/.nvim/plugged`, sino en
la ruta estándar de datos de Neovim (`stdpath("data")`, normalmente
`~\AppData\Local\nvim-data\lazy\`). Esto es una consecuencia inevitable
del cambio de gestor, no una decisión de reconfiguración. La carpeta vieja
`plugged` puedes borrarla manualmente después de confirmar que todo
funciona.

## Cosas que NO se tocaron (aunque podrían optimizarse)

Fiel a "migrar, no mejorar": no se activó lazy-loading real (`event`,
`cmd`, `keys`, `ft`) en ningún plugin — todos cargan al inicio igual que
vim-plug los cargaba antes. No se llamó `setup()` en plugins que en tu
config original nunca lo tenían (p. ej. `gitsigns.nvim`, `auto-save.nvim`,
`vim-rooter`, `vim-virtualenv`). Si más adelante quieres optimizar tiempo
de arranque o activar esos plugins correctamente, es un paso aparte y
puedo ayudarte con eso cuando quieras.
