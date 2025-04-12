vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "q:", "<nop>")
vim.keymap.set("n", "<Esc>", "<CMD>nohlsearch<CR>")

vim.keymap.set("", "<Leader>y", '"+y')
vim.keymap.set("", "<Leader>p", '"+p')

vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', '<Leader>tt', ':tabnew<cr>')
vim.keymap.set('n', '<Leader>tn', ':tabnext<cr>')
vim.keymap.set('n', '<Leader>tp', ':tabprevious<cr>')
vim.keymap.set('n', '<Leader>tw', ':tabclose<cr>')
vim.keymap.set('n', '<Leader>bb', ':enew<cr>')
vim.keymap.set('n', '<Leader>bn', ':bnext<cr>')
vim.keymap.set('n', '<Leader>bp', ':bprev<cr>')
vim.keymap.set('n', '<Leader>bd', ':bdelete<cr>')
