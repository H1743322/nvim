return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = "VeryLazy",
    config = function()
        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = "catppuccin",
                component_separators = { left = '|', right = '|' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    --statusline = {'packer','NvimTree'},
                    --winbar = {'packer','NvimTree'},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = true,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff',
                    { 'diagnostics',
                        symbols = { error = 'E:',
                            warn = 'W:',
                            info = 'I:',
                            hint = 'H:' },
                    } },
                lualine_c = { { "%=", separator = { right = "" } }, { 'filename', path = 1, } },
                lualine_x = { 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        }
    end
}
