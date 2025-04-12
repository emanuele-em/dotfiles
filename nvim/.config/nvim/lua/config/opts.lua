vim.opt.number = true
vim.opt.wrap = false
vim.opt.relativenumber = true
vim.opt.showmatch = true
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.joinspaces = true
vim.opt.ignorecase = true
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.wildmode = { 'list', 'longest' }
vim.opt.laststatus = 3
vim.opt.statusline = "%#TabLineSel#%f %#TabLine#%=[%l,%v] %p%%"
vim.opt.breakindent = true
vim.opt.signcolumn = 'yes'
vim.opt.autochdir = false
vim.opt.formatoptions:remove('cro')
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.scrolloff = 8
vim.o.background = "dark"
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert' }
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.opt.list = true
vim.opt.listchars:append "eol:↴"
vim.opt.shell = "/bin/bash"
