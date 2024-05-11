return {
    "mbbill/undotree",
    keys = { "<leader>u", "<cmd>UndotreeToggle<CR>" },
    lazy = true,
    config = function()
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
}
