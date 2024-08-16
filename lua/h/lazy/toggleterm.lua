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
                hide_numbers = true, -- hide the number column in toggleterm buffers
                shade_filetypes = {},
                shade_terminals = true,
                shading_factor = 2,     -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
                start_in_insert = true,
                insert_mappings = true, -- whether or not the open mapping applies in insert mode
                persist_size = false,
                direction = "horizontal",
                close_on_exit = true, -- close the terminal window when the process exits
                shell = 'powershell', -- change the default shell
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
