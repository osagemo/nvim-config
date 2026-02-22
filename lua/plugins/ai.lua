-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])

return {
    "github/copilot.vim",
    {
        "echasnovski/mini.diff",
        config = function()
            local diff = require("mini.diff")
            diff.setup({
                -- Disabled by default
                source = diff.gen_source.none(),
            })
        end,
    },

    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("codecompanion").setup(
                {
                    interactions = {
                        chat = {
                            adapter = {
                                name = "copilot",
                                model = "claude-sonnet-4.6"
                            },
                        },
                        inline = {
                            adapter = {
                                name = "copilot",
                                model = "claude-sonnet-4.6"
                            },
                        },
                    },
                    display = {
                        action_palette = {
                            provider = "telescope",
                        },
                    },
                })

            vim.keymap.set("n", "<M-a>", "<cmd>CodeCompanionActions<cr>")
            vim.keymap.set("v", "<M-a>", "<cmd>CodeCompanionActions<cr>")
            -- vim.keymap.set("n", "<C-a>", "<cmd>CodeCompanionChat Toggle<cr>")
            -- vim.keymap.set("v", "<C-a>", "<cmd>CodeCompanionChat Toggle<cr>")
            vim.keymap.set("n", "<C-A-i>", "<cmd>CodeCompanionChat Toggle<cr>")
            vim.keymap.set("v", "<C-A-i>", "<cmd>CodeCompanionChat Toggle<cr>")
            vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>")
            -- Map Alt+i in visual mode to run CodeCompanion inline promps
            vim.keymap.set("v", "<M-i>", ":<C-u>'<,'>CodeCompanion ", { noremap = true, silent = false })
            -- I don't know where to read the model names in the format that the settings expect so i vibe-coded this monstrosity
            vim.keymap.set("n", "<leader>cm", function()
                -- 1. Open a new scratch buffer
                vim.cmd("enew")

                -- 2. Fetch the models
                local models_table = require("codecompanion.adapters.http.copilot.get_models").choices(require(
                    "codecompanion.adapters.http.copilot"))

                -- 3. Format them into a list of strings
                local formatted_lines = vim.split(vim.inspect(models_table), "\n")

                -- 4. Paste them into the new buffer
                vim.api.nvim_put(formatted_lines, "c", true, true)

                -- 5. (Optional) Set the buffer type to lua for syntax highlighting
                vim.bo.filetype = "lua"
            end, { desc = "CodeCompanion: Dump Copilot Models to Scratch Buffer" })
        end,
    }
}
