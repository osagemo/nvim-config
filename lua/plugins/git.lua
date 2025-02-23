local is_win = require("osage.util").is_win

return {
    { 'lewis6991/gitsigns.nvim', config = function()
        require('gitsigns').setup()

        vim.api.nvim_set_keymap("n", "<leader>glb", "<cmd>Gitsigns blame_line<CR>",
            { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>gb", "<cmd>Gitsigns blame<CR>",
            { noremap = true, silent = true })

    end },
}

-- Couldnt get any floating terminals to work on windows. :term works but these always open WSL
-- return {
--     { 'akinsho/toggleterm.nvim', version = "*", init = function()
--     end,
--         config = function()
--             print(vim.opt.shell:get())
--             print(vim.opt.shellcmdflag:get())
--             print(vim.opt.shellxquote:get())
--             print(vim.opt.shellslash:get())
--             -- vim.cmd [[let &shellcmdflag = '-s']]
--             require("toggleterm").setup({
--                 --open_mapping = '<C-\\>',
--                 start_in_insert = true,
--                 direction = 'float',
--                 close_on_exit = false,
--             })
--
--             local Terminal = require('toggleterm.terminal').Terminal
--             local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true })
--
--             function _lazygit_toggle()
--                 lazygit:toggle()
--             end
--
--             vim.api.nvim_set_keymap("n", "<leader>gl", "<cmd>lua _lazygit_toggle()<CR>",
--                 { noremap = true, silent = true })
--
--         end }
-- }
