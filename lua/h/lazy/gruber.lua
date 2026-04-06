return {
    "H1743322/gruber-darker.vim",
    lazy = false,
    priority = 1000,
    config = function ()
        vim.g.original_colors = 1
        vim.cmd.colorscheme "gruber"
    end
}
