return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
--    keys = {
--        { "<leader>t", ":NvimTreeToggle<cr>" },
--    },
--    lazy = true,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- set termguicolors to enable highlight groups
        vim.opt.termguicolors = true

        local HEIGHT_RATIO = 1  -- You can change this
        local WIDTH_RATIO = 0.2 -- You can change this too
        -- OR setup with some options
        require("nvim-tree").setup({
            diagnostics = {
            },
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                side = "right",
                signcolumn = "no",
                float = {
                    enable = false,
                    open_win_config = function()
                        local screen_w = vim.opt.columns:get()
                        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                        local window_w = screen_w * WIDTH_RATIO
                        local window_h = screen_h * HEIGHT_RATIO
                        local window_w_int = math.floor(window_w)
                        local window_h_int = math.floor(window_h)
                        local center_x = (screen_w - window_w) / 2
                        local center_y = ((vim.opt.lines:get() - window_h) / 2)
                            - vim.opt.cmdheight:get()
                        return {
                            relative = "editor",
                            row = center_y,
                            col = center_x,
                            width = window_w_int,
                            height = window_h_int,
                        }
                    end,
                },
                width = function()
                    return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
                end,
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                --dotfiles = false,
            },
            git = {
                enable = true,
                ignore = false,
                timeout= 6000
            },

        })

        vim.keymap.set("n", "<leader>t", "<cmd>NvimTreeToggle<cr>")
    end,
}
