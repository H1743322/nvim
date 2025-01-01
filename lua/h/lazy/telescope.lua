return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        -- { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
        local builtin = require('telescope.builtin')
        require "telescope".setup {
            defaults = {
                wrap_results = false,
                preview = {
                    treesitter = false
                },
                file_ignore_patterns = {
                    "node_modules",
                    "%.git",
                    "%.yarn",
                    "obj",
                    "yarn%.lock",
                    "dist",
                    "build",
                    "package%-lock"
                },
                layout_config = {
                    horizontal = {
                        -- width = 0.9, height = 0.9,
                        preview_cutoff = 90, preview_width = 0.6
                    },
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                    no_ignore = true
                },
                live_grep = {
                    additional_args = function()
                        return { '--hidden' }
                    end
                },
                grep_string = {
                    additional_args = function()
                        return { '--hidden' }
                    end
                },
                buffers = {
                    show_all_buffers = true,
                    sort_lastused = true,
                    previewer = true,
                    mappings = {
                        i = { ["<c-d>"] = "delete_buffer" }
                    }
                },
            }
        }
        -- vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>ff', function()
            require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({
                previewer = true,
            }))
        end)
        -- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<C-p>', function()
            require("telescope.builtin").git_files(require("telescope.themes").get_dropdown({
                previewer = true,
                windblend = 10,
            }))
        end)
        vim.keymap.set('n', '<leader>fs', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>fh', builtin.help_tags)
        vim.keymap.set('n', '<leader>fb', builtin.buffers)
        vim.keymap.set('n', '<leader>fg', builtin.live_grep)
        vim.keymap.set('n', '<leader>frr', builtin.lsp_references)
        vim.keymap.set('n', '<leader>fw', builtin.grep_string)
        vim.keymap.set('n', '<leader>fW', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('v', '<leader>fw', function()
            vim.cmd('normal! "vy')
            local text = vim.fn.getreg('v')
            -- text = string.gsub(selected_text, "\n", "")
            if text and #text > 0 then
                builtin.grep_string({ search = text })
            end
        end)
        vim.keymap.set('n', '<leader>/', function()
            require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                previewer = false,
            }))
        end)

        -- require('telescope').load_extension('fzf')
    end
}
