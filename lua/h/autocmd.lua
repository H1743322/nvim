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
--    pattern = 'javascript, typescript',
--    callback = function()
--        vim.keymap.set("n", "<leader>f", "<cmd>!yarn run lint --fix<CR>", { buffer = true })
--    end
--})
--autocmd('FileType', {
--    group = h,
--    pattern = 'Jenkinsfile, groovy',
--    callback = function()
--        vim.keymap.set("n", "<leader>f", "<cmd>!npm-groovy-lint --fix %<CR>", { buffer = true })
--    end
--
--})
