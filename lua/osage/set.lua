local is_win = require("osage.util").is_win

-- Allows ! commands to work with git bash in windows
if is_win then
    vim.cmd('set shell=bash.exe')
    vim.cmd('set shellcmdflag=-c')
end

vim.api.nvim_exec('language en_US.UTF8', true)
vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.mouse = 'a'
vim.o.undofile = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
