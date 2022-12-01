local nnoremap = require("osage.keymap").nnoremap
local noremap = require("osage.keymap").noremap
local vnoremap = require("osage.keymap").vnoremap
local inoremap = require("osage.keymap").inoremap
local silent = { silent = true }

nnoremap("<leader>op", "<cmd>Telescope file_browser<CR>")
nnoremap('<C-p>',
    "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>")
-- Hidden files
nnoremap("<leader>hp", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>")

nnoremap('<C-F>', "<cmd>Telescope live_grep<cr>")
noremap("<Leader>y", '"*y')
noremap("<Leader>p", '"*p')
nnoremap("<Leader>=", "gg=G<C-o>")

-- Center screen on next/previous selection.
nnoremap("n", "nzz")
nnoremap("N", "Nzz")
-- Last and next jump should center too.
nnoremap("<C-o>", "<C-o>zz")
nnoremap("<C-i>", "<C-i>zz")
nnoremap("}", "}zz")
nnoremap("{", "{zz")

inoremap("<C-G>", "<C-o><cmd>CommentToggle<CR><C-o>A")
nnoremap("<C-G>", "<cmd>CommentToggle<CR>")
vnoremap("<C-G>", ":<C-u>call CommentOperator(visualmode())<CR>")
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

nnoremap("<leader>u", function() require("harpoon.ui").nav_file(1) end, silent)
nnoremap("<leader>i", function() require("harpoon.ui").nav_file(2) end, silent)
nnoremap("<leader>o", function() require("harpoon.ui").nav_file(3) end, silent)
nnoremap("<leader>p", function() require("harpoon.ui").nav_file(4) end, silent)
