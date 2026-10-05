return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            shell = "powershell.exe -NoLogo",
        })
    end,
}
