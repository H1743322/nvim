local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local yank_group = augroup('HighlightYank', {})
local h = augroup('H', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 200,
        })
    end,
})

autocmd({ "BufWritePre" }, {
    group = h,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd({ "User" }, {
    group = h,
    pattern = "TelescopePreviewerLoaded",
    callback = function()
        vim.wo.wrap = true
    end,
})

autocmd({ "BufRead", "BufNewFile" }, {

    group = h,
    pattern = { "*.JSON", "*.sarif" },
    command = 'set filetype=json'

})

-- autocmd('FileType', {
--    group = h,
--    pattern = { 'javascript', 'typescript' },
--    callback = function()
--        vim.keymap.set("n", "<leader>vf", "<cmd>!yarn run lint --fix<CR>", { buffer = true })
--    end
-- })
-- autocmd('FileType', {
--    group = h,
--    pattern = { 'Jenkinsfile', 'groovy' },
--    callback = function()
--        vim.keymap.set("n", "<leader>vf", "<cmd>!npm-groovy-lint --fix %<CR>", { buffer = true })
--    end
--
-- })

autocmd('LspAttach', {
    group = h,
    callback = function(event)
        local opts = { buffer = event.buf }
        vim.keymap.set("n", "gd", function() require('telescope.builtin').lsp_definitions() end, opts)
        vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
        vim.keymap.set("n", "gr", function() require('telescope.builtin').lsp_references() end, opts)
        vim.keymap.set("n", "gi", function() require('telescope.builtin').lsp_implementations() end, opts)
        vim.keymap.set("n", "go", function() vim.lsp.buf.type_definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = 'rounded' }) end, opts)
        vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "gs", function() vim.lsp.buf.signature_help({ border = 'rounded' }) end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("n", "<leader>vd", ':vsp<cr> :lua vim.lsp.buf.definition()<CR><CR>zz', opts)
        vim.keymap.set("n", "<leader>vh",
            function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = 0 }, { bufnr = 0 })
            end,
            opts)
        vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    end
})
