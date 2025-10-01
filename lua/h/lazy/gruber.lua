return {
    "H1743322/gruber-darker-colorscheme",
    lazy = false,
    priority = 1000,
    config = function ()
        vim.g.original_colors = 0
        vim.cmd.colorscheme "gruber"
    end
}
