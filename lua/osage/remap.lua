local nnoremap = require("osage.keymap").nnoremap
local noremap = require("osage.keymap").noremap
local vnoremap = require("osage.keymap").vnoremap
local inoremap = require("osage.keymap").inoremap
local silent = { silent = true }
local has = vim.fn.has
local is_win = has "win32" == 1

-- Different \ binding on my linux US-ANSI keyboard layout for now
local commentKey
if not is_win then
    commentKey = "<C-_>"
    vim.g.mapleader = '<'
else
    commentKey = "<C-G>"
end

-- Disable
nnoremap("Q", "<nop>")

-- Telescope
nnoremap("<leader>op", "<cmd>Telescope file_browser path=%:p:h<CR>")
nnoremap('<C-p>',
    "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>")
-- Hidden files
nnoremap("<leader>ip", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>")
nnoremap('<C-F>', "<cmd>Telescope live_grep<cr>")

-- Clipboard yank/paste
noremap("<Leader>y", '"*y')
noremap("<Leader>p", '"*p')

-- Center screen after various navigations.
nnoremap("n", "nzz")
nnoremap("N", "Nzz")
nnoremap("<C-o>", "<C-o>zz")
nnoremap("<C-i>", "<C-i>zz")
nnoremap("}", "}zz")
nnoremap("{", "{zz")
nnoremap("<C-u>", "<C-u>zz")
nnoremap("<C-d>", "<C-d>zz")

-- Move visual selection
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

inoremap(commentKey, "<C-o><cmd>CommentToggle<CR><C-o>A")
nnoremap(commentKey, "<cmd>CommentToggle<CR>")
vnoremap(commentKey, ":<C-u>call CommentOperator(visualmode())<CR>")
-- nnoremap("<C-E>", "<cmd>NvimTreeToggle<CR>")

-- Tabs
nnoremap('te', ':tabedit<cr>')
nnoremap('tn', ':tabn<cr>')
nnoremap('tc', ':tabc<cr>')

-- Split window
nnoremap('ss', ':split<Return><C-w>w')
nnoremap('sv', ':vsplit<Return><C-w>w')

-- Move window
nnoremap('<Space>', '<C-w>w')
vim.keymap.set('', 'sh', '<C-w>h')
vim.keymap.set('', 'sk', '<C-w>k')
vim.keymap.set('', 'sj', '<C-w>j')
vim.keymap.set('', 'sl', '<C-w>l')

-- Resize window
nnoremap('<C-w><left>', ':vertical resize -10<cr>')
nnoremap('<C-w><right>', ':vertical resize +10<cr>')
nnoremap('<C-w><down>', ':resize -10<cr>')
nnoremap('<C-w><up>', ':resize +10<cr>')

-- Harpoon
nnoremap("<leader>a", function() require("harpoon.mark").add_file() end, silent)
nnoremap("<C-e>", function() require("harpoon.ui").toggle_quick_menu() end, silent)

nnoremap("<leader>h", function() require("harpoon.ui").nav_file(1) end, silent)
nnoremap("<leader>j", function() require("harpoon.ui").nav_file(2) end, silent)
nnoremap("<leader>k", function() require("harpoon.ui").nav_file(3) end, silent)
nnoremap("<leader>l", function() require("harpoon.ui").nav_file(4) end, silent)

-- Temporarily disabled
-- vim.keymap.set("n", "<leader>n>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Format
nnoremap("<Leader>=", "gg=G<C-o>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Quickfix list
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Replace all occurrences in file
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
