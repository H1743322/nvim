return {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
        require('gitsigns').setup {
            on_attach = function(bufnr)
                local function map(mode, lhs, rhs, opts)
                    opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
                    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
                end
                -- Navigation
                map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
                map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

                -- Actions
                map('n', '<leader>gd', '<cmd>Gitsigns diffthis<CR>:set wrap<CR>:wincmd h<CR>:set wrap<CR>')
                map('n', '<leader>gp', '<cmd>Gitsigns preview_hunk<CR>')
                map('n', '<leader>gr', '<cmd>Gitsigns reset_hunk<CR>')
                map('n', '<leader>gs', '<cmd>Gitsigns stage_hunk<CR>')
                map('n', '<leader>gb', '<cmd>Gitsigns blame_line<CR>')
                --map('n', '<leader>gB', '<cmd>Gitsigns toggle_current_line_blame<CR>')
            end,
            signs_staged_enable = false
        }
    end
}
