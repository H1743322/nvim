return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
        require 'catppuccin'.setup({
            transparent_background = true,
            no_italic = true,
            no_bold = false,
            no_underline = true,
            color_overrides = {
                mocha = {
                    base = "#000000",
                    mantle = "#000000",
                    crust = "#000000",
                },
            },
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                telescope = true,
            },
        })
        vim.cmd.colorscheme "catppuccin"
    end
}
