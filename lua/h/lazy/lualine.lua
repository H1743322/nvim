return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = "VeryLazy",
    config = function()
        local function trunc(trunc_len, no_ellipsis)
            return function(str)
                if trunc_len and #str > trunc_len then
                    return str:sub(1, trunc_len) .. (no_ellipsis and '' or '…')
                end
                return str
            end
        end

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
                lualine_b = { { 'branch', fmt = trunc(28, false) }, 'diff',
                    { 'diagnostics',
                        symbols = { error = 'E:',
                            warn = 'W:',
                            info = 'I:',
                            hint = 'H:' },
                    } },
                lualine_c = { { 'filename', path = 1 } },
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
