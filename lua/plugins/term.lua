return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
        require("toggleterm").setup({
            open_mapping = '<M-t>',
            start_in_insert = true,
            direction = 'float',
            close_on_exit = true,
        })

        local Terminal = require('toggleterm.terminal').Terminal
        local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true })

        function _lazygit_toggle()
            lazygit:toggle()
        end

        -- Exit term with <C-\> (+ <C-n> in term)
        vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>",
            { noremap = true, silent = true })
        vim.api.nvim_set_keymap("t", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
    end
}
