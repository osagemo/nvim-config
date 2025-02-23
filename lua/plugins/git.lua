local is_win = require("osage.util").is_win

return {
    { 'lewis6991/gitsigns.nvim', config = function()
        require('gitsigns').setup()

        vim.api.nvim_set_keymap("n", "<leader>glb", "<cmd>Gitsigns blame_line<CR>",
            { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>gb", "<cmd>Gitsigns blame<CR>",
            { noremap = true, silent = true })

    end },

    { 'akinsho/toggleterm.nvim', version = "*", init = function()
    end,
        config = function()
            require("toggleterm").setup({
                open_mapping = '<C-\\>',
                start_in_insert = true,
                direction = 'float',
                close_on_exit = true,
            })


            function ToggleTermWithShellFlag()
                -- Set shellcmdflag to '-s' for interactive terminal
                vim.opt.shellcmdflag = '-s'

                vim.cmd('ToggleTerm cmd="lazygit')

                -- Set shellcmdflag back to '-c' for normal command execution
                vim.opt.shellcmdflag = '-c'
            end

            vim.api.nvim_create_user_command('ToggleTermWithFlag', ToggleTermWithShellFlag, {})

            vim.api.nvim_set_keymap("n", "<leader>ot", "<cmd>ToggleTermWithFlag<CR>",
                { noremap = true, silent = true })

        end }
}
