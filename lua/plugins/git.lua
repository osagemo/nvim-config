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
