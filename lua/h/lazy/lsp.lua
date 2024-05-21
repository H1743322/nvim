return {
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

            -- And you can configure cmp even more, if you want to.
            local cmp = require('cmp')
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
                    { name = 'luasnip',  keyword_length = 2, priority = 70, max_item_count = 3 },
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
                    source = "always",

                },
            })
            vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                {
                    signs = true,
                    underline = true,
                    virtual_text = {
                        spacing = 5,
                        severity_limit = "Warning", -- Set severity_limit to "Warning" or higher
                    },
                    update_in_insert = true,

                })

            local cmp_lsp = require("cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_lsp.default_capabilities())

            capabilities = require('cmp_nvim_lsp').default_capabilities()

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                },
                handlers = {
                    function(server_name) -- default handler (optional)
                        require("lspconfig")[server_name].setup {
                            capabilities = capabilities
                        }
                    end,

                    ["lua_ls"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.lua_ls.setup {
                            capabilities = capabilities,
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { "vim", "it", "describe", "before_each", "after_each" },
                                    }
                                }
                            }
                        }
                    end,
                }
            })
        end
    }
}
