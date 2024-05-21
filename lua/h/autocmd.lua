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
    pattern = "*JSON",
    command = 'set filetype=json'

})

--autocmd('FileType', {
--    group = h,
--    pattern = 'python',
--    callback = function()
--        vim.keymap.set("n", "<leader>f", "<cmd>!black %<cr>", { buffer = true })
--    end,
--})
--
--autocmd('FileType', {
--    group = h,
--    pattern = 'javascript',
--    callback = function()
--        vim.keymap.set("n", "<leader>f", "<cmd>!yarn run eslint -f node_modules/eslint-friendly-formatter src test --fix<CR>",{buffer = true})
--    end
--})
autocmd('LspAttach', {
    group = h,
    callback = function(event)
        local opts = { buffer = event.buf }
        vim.keymap.set("n", "gd", function() require('telescope.builtin').lsp_definitions() end, opts)
        vim.keymap.set("n", "gr", function() require('telescope.builtin').lsp_references() end, opts)
        vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "gs", function() vim.diagnostic.signature_help() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("n", "<leader>vd", ':vsp<cr> :lua vim.lsp.buf.definition()<CR><CR>zz')
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    end
})
