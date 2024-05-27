return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            { 'L3MON4D3/LuaSnip' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'rafamadriz/friendly-snippets' },
            { 'saadparwaiz1/cmp_luasnip' }
        },
        config = function()
            -- Here is where you configure the autocompletion settings.
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_cmp()

            -- And you can configure cmp even more, if you want to.
            local cmp = require('cmp')
            local cmp_action = lsp_zero.cmp_action()
            local ls = require("luasnip")
            require('luasnip.loaders.from_vscode').lazy_load()
            vim.keymap.set({ "i", "s" }, "<C-s>;", function() ls.jump(1) end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-s>,", function() ls.jump(-1) end, { silent = true })
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                sources = {
                    { name = 'nvim_lsp', priority = 100 },
                    { name = 'nvim_lua' },
                    { name = 'buffer',   keyword_length = 3, priority = 90, max_item_count = 5 },
                    { name = 'luasnip',  keyword_length = 2, priority = 50, max_item_count = 3 },
                },
                formatting = {
                    -- changing the order of fields so the icon is the first
                    fields = { 'abbr', 'menu', 'kind' },

                    -- here is where the change happens
                    format = function(entry, item)
                        local menu_icon = {
                            nvim_lsp = '[λ]',
                            luasnip = '[⋗]',
                            buffer = '[Ω]',
                            path = '🖫',
                            nvim_lua = 'Π',
                        }
                        item.menu = menu_icon[entry.source.name]
                        return item
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                --formatting = lsp_zero.cmp_format(),
                mapping = cmp.mapping.preset.insert({
                    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                }),
                experimental = {
                    ghost_text = false,
                },
            })
        end
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason-lspconfig.nvim' },
        },
        config = function()
            -- This is where all the LSP shenanigans will live
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()

            --- if you want to know more about lsp-zero and mason.nvim
            --- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp_zero.default_keymaps({ buffer = bufnr })
                local opts = { buffer = bufnr, remap = false }


                vim.keymap.set("n", "gd", function() require('telescope.builtin').lsp_definitions() end, opts)
                vim.keymap.set("n", "gr", function() require('telescope.builtin').lsp_references() end, opts)
                vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("n", "<leader>vd", '<cmd>vsp<cr> <cmd>lua vim.lsp.buf.definition()<CR><CR>zz')
            end)

            vim.diagnostic.config({
                virtual_text = true,
                severity_sort = true,
                underline = true,
                update_in_insert = true,
                float = {
                    header = '',
                    border = 'rounded',
                    focusable = false,
                    style = "minimal",
                    source = true,

                },
            })
            vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                {
                    signs = true,
                    underline = true,
                    virtual_text = {
                        spacing = 5,
                        severity = {
                            min = vim.diagnostic.severity.WARN
                        }
                    },
                    update_in_insert = true,

                })
            require('mason-lspconfig').setup({
                ensure_installed = {},
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        -- (Optional) Configure lua language server for neovim
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require('lspconfig').lua_ls.setup(lua_opts)
                    end,
                    --jdtls = function ()
                    --    require('jdtls').setup{
                    --        java={
                    --            format = {
                    --                enabled= true
                    --            }
                    --        }
                    --    }
                    --end
                }
            })
        end
    }
}
