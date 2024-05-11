return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
        require 'catppuccin'.setup({
            transparent_background = true,
            no_italic = true,     -- Force no italic
            no_bold = false,      -- Force no bold
            no_underline = false, -- Force no underline
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
            },
        })
        vim.cmd.colorscheme "catppuccin"
    end
}
