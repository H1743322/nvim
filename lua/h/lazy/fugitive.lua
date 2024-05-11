return {
    "tpope/vim-fugitive",
   -- keys = {
   --     { "<leader>gg", "<cmd>:tab G<cr>" },
   -- },
    event = "VeryLazy",
    config = function()
        vim.keymap.set("n", "<leader>gg", '<cmd>:tab G<cr>')
        vim.keymap.set("n", "<leader>gh", "<cmd>diffget /:2<CR>")
        vim.keymap.set("n", "<leader>gl", "<cmd>diffget /:3<CR>")
    end
}
