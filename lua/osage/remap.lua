local is_win = require("osage.util").is_win
-- Different \ binding on my linux US-ANSI keyboard layout for now
local commentKey
if not is_win then
    commentKey = "<C-_>"
    vim.g.mapleader = '<'
else
    commentKey = "<C-_>"
    vim.g.mapleader = ' '
end

-- Disable
vim.keymap.set("n", "Q", "<nop>")

-- Files
vim.keymap.set("n", "<Leader>o", vim.cmd.Ex)
vim.keymap.set("n", "<Leader>e", "<cmd>lua MiniFiles.open()<CR>")
vim.keymap.set("n", "<leader>t", function()
    MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
    MiniFiles.reveal_cwd()
end)

-- Clipboard yank/paste
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "x", "s", "o" }, "<leader>p", [["+p]])

-- Center
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set("n", "{", "{zz")

-- Comments
vim.keymap.set("i", commentKey, "<C-o><cmd>CommentToggle<CR><C-o>A")
vim.keymap.set("n", commentKey, "<cmd>CommentToggle<CR>")
vim.keymap.set("v", commentKey, ":<C-u>call CommentOperator(visualmode())<CR>")
-- vim.keymap.set("n","<C-E>", "<cmd>NvimTreeToggle<CR>")

-- Tabs
vim.keymap.set("n", 'te', ':tabedit<cr>')
vim.keymap.set("n", 'tn', ':tabn<cr>')
vim.keymap.set("n", 'tc', ':tabc<cr>')

-- Split window
vim.keymap.set("n", 'ss', ':split<Return><C-w>w')
vim.keymap.set("n", 'sv', ':vsplit<Return><C-w>w')

-- Move window Focus
vim.keymap.set("n", '<Space>', '<C-w>w')
vim.keymap.set('', 'sh', '<C-w>h')
vim.keymap.set('', 'sk', '<C-w>k')
vim.keymap.set('', 'sj', '<C-w>j')
vim.keymap.set('', 'sl', '<C-w>l')

-- Resize window
vim.keymap.set("n", '<C-w><left>', ':vertical resize -10<cr>')
vim.keymap.set("n", '<C-w><right>', ':vertical resize +10<cr>')
vim.keymap.set("n", '<C-w><down>', ':resize -10<cr>')
vim.keymap.set("n", '<C-w><up>', ':resize +10<cr>')

-- Move visual selection
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Format
vim.keymap.set("n", "<Leader>=", "gg=G<C-o>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Replace all occurrences in file
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Quickfix list
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
-- Currently not used, shortcuts are used by Harpoon
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

local toggle_qf = function()
    local qf_exists = false
    for _, win in pairs(vim.fn.getwininfo()) do
        if win["quickfix"] == 1 then
            qf_exists = true
        end
    end
    if qf_exists == true then
        vim.cmd "cclose"
        return
    end
    if not vim.tbl_isempty(vim.fn.getqflist()) then
        vim.cmd "copen"
    end
end

vim.keymap.set("n", "<leader>q", toggle_qf)

-- Harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<Leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<Leader>j", function() ui.nav_file(1) end)
vim.keymap.set("n", "<Leader>k", function() ui.nav_file(2) end)
vim.keymap.set("n", "<Leader>l", function() ui.nav_file(3) end)
vim.keymap.set("n", "<Leader>;", function() ui.nav_file(4) end)

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-gp>', builtin.git_files, {})
vim.keymap.set('n', '<Leader>gw', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

vim.keymap.set('n', '<c-f>', builtin.live_grep, {})
--vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
--vim.keymap.set('n', '

-- UndoTree
vim.keymap.set("n", "<Leader>u", vim.cmd.UndotreeToggle)
