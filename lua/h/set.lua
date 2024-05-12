vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.cursorline = true
vim.opt.pumheight = 15

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.swapfile = false
vim.opt.backup = false
--vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.o.splitright = true
vim.o.splitbelow = true
vim.opt.termguicolors = true


vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.hidden = true
--vim.opt.colorcolumn = "120"

--netrw
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
--vim.g.netrw_winsize = 25

--Line wrap
vim.opt.wrap = true
vim.opt.breakindent = false
vim.opt.linebreak = true

-- fileformat
--vim.o.fileformat = "unix"

--remove tild
--vim.opt.fillchars = { eob = " " }

-- Decrease update time
vim.opt.updatetime = 50

-- Decrease mapped sequence wait time
--vim.opt.timeoutlen = 300
