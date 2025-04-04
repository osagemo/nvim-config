return {
    'akinsho/toggleterm.nvim', version = "*",
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
        -- Exit term with <C-\> (+ <C-n> in term)
        vim.api.nvim_set_keymap("n", "<leader>ot", "<cmd>ToggleTermWithFlag<CR>",
            { noremap = true, silent = true })

    end
}
