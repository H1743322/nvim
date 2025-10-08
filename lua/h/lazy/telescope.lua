return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
        local builtin = require('telescope.builtin')
        require "telescope".setup {
            defaults = {
                wrap_results = false,
                preview = {
                    treesitter = false,
                    filesize_limit = 20
                },
                file_ignore_patterns = {
                    "node_modules/",
                    "%.git/",
                    "%.yarn/",
                    "%.cache/",
                    "obj/",
                    "yarn%.lock",
                    "dist/",
                    "build/",
                    "venv/",
                    "package%-lock"
                },
                layout_config = {
                    horizontal = {
                        -- width = 0.9, height = 0.9,
                        preview_cutoff = 90, preview_width = 0.6
                    },
                    bottom_pane = {
                        height = 0.40,
                        preview_cutoff = 90,
                        -- prompt_position = "bottom",
                        -- preview_width = 0.6
                    },
                },
                -- Ivy
                results_title = false,
                borderchars = {
                    prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
                    results = { " " },
                    preview = { "", "│", "", "│", "│", "", "", "" },
                    -- Bottom Prompt
                    -- prompt = { " ", " ", "─", " ", " ", " ", "─", "─" },
                    -- results = { "─", " ", " ", " ", "─", "─", " ", " " },
                    -- preview = { "─", " ", "", "│", "┬", "─", "", "│" },


                },
                layout_strategy = "bottom_pane",
                sorting_strategy = "ascending",
                -- dynamic_preview_title = true,

            },
            pickers = {
                find_files = {
                    hidden = true,
                    no_ignore = true,
                    preview_title = false,
                },
                live_grep = {
                    preview_title = false,
                    additional_args = function()
                        return { '--hidden', '--max-filesize', '10M' }
                    end
                },
                grep_string = {
                    preview_title = false,
                    additional_args = function()
                        return { '--hidden', '--max-filesize', '10M', '--trim' }
                    end
                },
                buffers = {
                    preview_title = false,
                    show_all_buffers = true,
                    sort_lastused = true,
                    previewer = true,
                    mappings = {
                        i = { ["<c-d>"] = "delete_buffer" }
                    }
                },
            }
        }
        vim.keymap.set('n', '<leader>ff', builtin.find_files)
        vim.keymap.set('n', '<C-p>', builtin.git_files)
        vim.keymap.set('n', '<leader>fs', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>fh', builtin.help_tags)
        vim.keymap.set('n', '<leader>fb', builtin.buffers)
        vim.keymap.set('n', '<leader>fg', builtin.live_grep)
        vim.keymap.set('n', '<leader>fr', builtin.resume)
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

        require('telescope').load_extension('fzf')
    end
}
