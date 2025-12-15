return {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,

    config = function()
        require("oil").setup({
            columns = {
                "permissions",
                "size",
                "mtime",
                "owner",
                "icon",
            },
            win_options = {
                wrap = false,
            },
            keymaps = {
                ["<C-t>"] = {
                    callback = function()
                        require("oil").select({ tab = true, close = true })
                    end,
                    desc = "Open in new tab and close Oil",
                    mode = "n",
                },
                ["<C-h>"] = {
                    callback = function()
                        require("oil").select({ horizontal = true, close = true })
                    end,
                    desc = "Open in horizontal split and close Oil",
                    mode = "n",
                },
                ["<C-s>"] = {
                    callback = function()
                        require("oil").select({ vertical = true, close = true })
                    end,
                    desc = "Open in vertical split and close Oil",
                    mode = "n",
                },
            },
        })
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end
}
