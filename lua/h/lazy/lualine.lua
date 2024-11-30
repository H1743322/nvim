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

        local function hide_in_width()
            return vim.fn.winwidth(0) > 80
        end

        local function get_active_clients()
            local msg = 'NoLsp'
            local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
            local clients = vim.lsp.get_active_clients()
            if next(clients) == nil then
                return msg
            end
            for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    return client.name
                end
            end
            return msg
        end

        local encoding = function()
            local ret, _ = (vim.bo.fenc or vim.go.enc):gsub("^utf%-8$", "")
            return ret
        end

        local fileformat = function()
            local ret, _ = vim.bo.fileformat:gsub("^unix$", "")
            return ret
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
                lualine_b = {
                    { 'branch', fmt = trunc(28, false) },
                    'diff',
                    { 'diagnostics', symbols = {
                        error = 'e',
                        warn = 'w',
                        info = 'i',
                        hint = 'h'
                    }
                    }
                },
                lualine_c = {
                    { 'filename', path = 1 }
                },

                lualine_x = {
                    { get_active_clients, cond = hide_in_width, color = { fg = '#ffffff', gui = 'bold' } },
                    { encoding,           cond = hide_in_width },
                    { fileformat,         cond = hide_in_width },
                    { 'filetype',         cond = hide_in_width }
                },
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
