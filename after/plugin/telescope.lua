local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-gp>', builtin.git_files, {})
vim.keymap.set('n', '<Leader>gw', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ")})
end)


vim.keymap.set('n', '<c-f>', builtin.live_grep, {})
--vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
--vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
