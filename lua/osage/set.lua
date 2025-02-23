local is_win = require("osage.util").is_win

if is_win then
    -- Allows !commands and e.g. diffs to work with git bash in windows
    vim.opt.shell = '"C:\\Program Files\\Git\\usr\\bin\\bash.exe"'
    vim.opt.shellcmdflag = "-c"
    -- vim.opt.shellquote = ""
    vim.opt.shellxquote = "("
    vim.opt.shellslash = true
end

vim.api.nvim_exec2('language en_US.UTF8', { output = true })
-- vim.opt.guicursor = ""

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

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

-- Undo settings
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true
local home = os.getenv('HOME') or os.getenv('USERPROFILE')
vim.opt.undodir = home .. '/.nvim/undodir'
-- Ensure the undodir exists
local undodir = tostring(vim.opt.undodir)
if not vim.fn.isdirectory(undodir) then
    vim.fn.mkdir(undodir, 'p')
end

-- Get messages in buffer
vim.api.nvim_create_user_command('Messages', function()
    scratch_buffer = vim.api.nvim_create_buf(false, true)
    vim.bo[scratch_buffer].filetype = 'vim'
    local messages = vim.split(vim.fn.execute('messages', 'silent'), '\n')
    vim.api.nvim_buf_set_text(scratch_buffer, 0, 0, 0, 0, messages)
    vim.cmd('vertical sbuffer ' .. scratch_buffer)
    vim.opt_local.wrap = true
    vim.bo.buflisted = false
    vim.bo.bufhidden = 'wipe'
    vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = scratch_buffer })
end, {})
