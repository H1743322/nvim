return {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,

    config = function()
        require("oil").setup({
            skip_confirm_for_simple_edits = true,
            columns = {
                "permissions",
                "size",
                "mtime",
                "owner",
                "icon",
            },
            win_options = {
                wrap = false
            },
            view_options = {
                show_hidden = true
            },
            keymaps = {
                ["<C-s>"] = { "actions.select", opts = { vertical = true, close = true } },
                ["<C-h>"] = { "actions.select", opts = { horizontal = true, close = true } },
                ["<C-t>"] = { "actions.select", opts = { tab = true, close = true } }
            }
        })
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end
}
