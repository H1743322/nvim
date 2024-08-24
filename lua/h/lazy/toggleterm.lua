return {
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        keys = {
            { "<c-\\>", "<cmd>ToggleTerm<cr>" },
        },
        lazy = true,
        config = function()
            require("toggleterm").setup {
                size = 10,
                open_mapping = [[<c-\>]],
                hide_numbers = true,
                shade_filetypes = {},
                shade_terminals = true,
                shading_factor = 2,
                start_in_insert = true,
                insert_mappings = true,
                persist_size = false,
                direction = "horizontal",
                close_on_exit = true, 
                shell = 'powershell',
                float_opts = {
                    border = "rounded",
                    winblend = 0,
                    highlights = {
                        border = "Normal",
                        background = "Normal",
                    },
                },
            }
        end
    }
}
