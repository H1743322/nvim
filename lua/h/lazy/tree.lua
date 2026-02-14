return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = { { "<leader>t", "<cmd>NvimTreeToggle<cr>" } },
    lazy = true,
    config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        vim.opt.termguicolors = true

        local HEIGHT_RATIO = 1
        local WIDTH_RATIO = 0.2

        require("nvim-tree").setup({
            diagnostics = {
                enable = false,
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
            actions = {
                open_file = {
                    quit_on_open = true,
                },
            },
            renderer = {
                group_empty = true,
                full_name = true,
                indent_width = 1,
            },
            filters = {
                dotfiles = false,
            },
            git = {
                enable = false,
                ignore = false,
                timeout = 6000
            },

        })

        -- vim.keymap.set("n", "<leader>t", "<cmd>NvimTreeToggle<cr>")
    end,
}
