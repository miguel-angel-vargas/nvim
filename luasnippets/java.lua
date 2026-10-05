local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

--------------------------------------------------------------------------------
-- Obtiene el nombre del archivo sin extensión
--------------------------------------------------------------------------------

local function classname()
    return vim.fn.expand("%:t:r")
end

--------------------------------------------------------------------------------
-- Calcula automáticamente el package
--------------------------------------------------------------------------------

local function package_name()
    local file = vim.fn.expand("%:p")

    local root = file:match("src/main/java/(.*)")
        or file:match("src/test/java/(.*)")

    if not root then
        return ""
    end

    local package = root:gsub("\\", ".")
    package = package:gsub("/", ".")
    package = package:gsub("%.[^.]+$", "")

    return package
end

--------------------------------------------------------------------------------
-- Clase
--------------------------------------------------------------------------------

ls.add_snippets("java", {

    s(
        "class",
        fmt(
            [[
package {};

public class {} {{

    public {}() {{}}

}}
]],
            {
                f(package_name),
                f(classname),
                f(classname),
            }
        )
    ),

--------------------------------------------------------------------------------
-- Interface
--------------------------------------------------------------------------------

    s(
        "interface",
        fmt(
            [[
package {};

public interface {} {{

}}
]],
            {
                f(package_name),
                f(classname),
            }
        )
    ),

})
