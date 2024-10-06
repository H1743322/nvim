vim.g.mapleader = " "
--vim.keymap.set("n", "<leader>fe", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')

vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])

-- Indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "Q", "<nop>")

-- CList
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
--vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
--vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>vs", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

--vim.keymap.set("n", "<c-l>", ":bnext<CR>")
--vim.keymap.set("n", "<c-h>", ":bprevious<CR>")

-- Diff
vim.keymap.set("n", "<leader>dt", ":windo diffthis<CR>:windo set wrap<CR>")
vim.keymap.set("n", "<leader>do", ":windo diffoff<CR>")


-- Serach
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.cmd([[

nnoremap <Space> <NOP>

inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap {} {}<Left>
inoremap {<CR> {<CR>}<ESC>O
inoremap " ""<Left>
inoremap ' ''<left>
inoremap ` ``<left>

noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt

noremap <C-Left> :vertical resize +3<CR>
noremap <C-Right> :vertical resize -3<CR>
noremap <C-Up> :resize +3<CR>
noremap <C-Down> :resize -3<CR>

let g:ftplugin_sql_omni_key = '<C-j>'
]])
