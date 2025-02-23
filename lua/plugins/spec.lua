return {
    -- Navigation
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { { 'nvim-lua/plenary.nvim' }, },
    },
    'theprimeagen/harpoon',
    { 'echasnovski/mini.icons', version = '*',
        config = function()
            require('mini.icons').setup()
            require('mini.icons').mock_nvim_web_devicons()
        end
    },
    { 'echasnovski/mini.files',
        version = '*',
        config = function()
            require('mini.files').setup()
            vim.keymap.set("n", "<Leader>e", "<cmd>lua MiniFiles.open()<CR>")
            vim.keymap.set("n", "<leader>t", function()
                MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
                MiniFiles.reveal_cwd()
            end)

            local map_split = function(buf_id, lhs, direction)
                local rhs = function()
                    -- Make new window and set it as target
                    local new_target_window
                    vim.api.nvim_win_call(MiniFiles.get_explorer_state().target_window, function()
                        vim.cmd(direction .. ' split')
                        new_target_window = vim.api.nvim_get_current_win()
                    end)

                    MiniFiles.set_target_window(new_target_window)
                end

                -- Adding `desc` will result into `show_help` entries
                local desc = 'Split ' .. direction
                vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
            end

            vim.api.nvim_create_autocmd('User', {
                pattern = 'MiniFilesBufferCreate',
                callback = function(args)
                    local buf_id = args.data.buf_id
                    -- Tweak keys to your liking
                    map_split(buf_id, 'gs', 'belowright horizontal')
                    map_split(buf_id, 'gv', 'belowright vertical')
                end,
            })
        end
    },
    -- 'echasnovski/mini.colors',
    {
        'nvim-lualine/lualine.nvim',
        opts = {
            sections = {
                lualine_c = {
                    {
                        "filename", path = 4
                    }
                },
            },
        }
    },

    -- Undo history visualizer
    'mbbill/undotree',

    -- Enables :CommentToggle d by keybindings
    {
        "terrortylor/nvim-comment",
        config = function()
            require('nvim_comment').setup()
        end
    },

    -- Shows context when scrolling
    "nvim-treesitter/nvim-treesitter-context",

    -- Make Markdown buffers look beautiful for md and codecompanion
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "codecompanion" },
        opts = {
            render_modes = true, -- Render in ALL modes
            sign = {
                enabled = false, -- Turn off in the status column
            },
        },
    },

    {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup()
    end
}
}
