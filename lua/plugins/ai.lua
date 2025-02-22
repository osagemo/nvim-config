-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])

return {
    "github/copilot.vim",

    { "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("codecompanion").setup(
                {
                    strategies = {
                        chat = {
                            adapter = "copilot",
                        },
                        inline = {
                            adapter = "copilot",
                        },
                    },
                })

            vim.keymap.set("n", "<M-a>", "<cmd>CodeCompanionActions<cr>")
            vim.keymap.set("v", "<M-a>", "<cmd>CodeCompanionActions<cr>")
            vim.keymap.set("n", "<C-a>", "<cmd>CodeCompanionChat Toggle<cr>")
            vim.keymap.set("v", "<C-a>", "<cmd>CodeCompanionChat Toggle<cr>")
            vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>")
        end,
    }
}
