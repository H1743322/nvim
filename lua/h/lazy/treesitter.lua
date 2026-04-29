return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufEnter" },
    branch = 'main',
    lazy = false,
    -- TODO: max file size
    config = function()
        vim.api.nvim_create_autocmd('FileType', {
            callback = function()
                vim.treesitter.stop()
                -- pcall(vim.treesitter.start)
                -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end
}
