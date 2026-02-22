return {
    -- Navigation
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { { 'nvim-lua/plenary.nvim' }, },
    },
    'theprimeagen/harpoon',
    {
        'echasnovski/mini.icons',
        version = '*',
        config = function()
            require('mini.icons').setup()
            require('mini.icons').mock_nvim_web_devicons()
        end
    },
    {
        'echasnovski/mini.files',
        version = '*',
        config = function()
            require('mini.files').setup()
            vim.keymap.set("n", "<Leader>e", "<cmd>lua MiniFiles.open()<CR>")
            vim.keymap.set("n", "<leader>t", function()
                MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
                MiniFiles.reveal_cwd()
            end)

            -- Helper to map a key for splitting the target window in mini.files
            local map_split = function(buf_id, lhs, direction)
                local rhs = function()
                    local new_target_window
                    vim.api.nvim_win_call(MiniFiles.get_explorer_state().target_window, function()
                        vim.cmd(direction .. ' split')
                        new_target_window = vim.api.nvim_get_current_win()
                    end)

                    MiniFiles.set_target_window(new_target_window)
                end

                -- Set the keymap in normal mode, buffer-local to mini.files buffer
                local desc = 'Split ' .. direction
                vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
            end

            -- Set focused directory as current working directory
            local set_cwd = function()
                local path = (MiniFiles.get_fs_entry() or {}).path
                if path == nil then return vim.notify('Cursor is not on valid entry') end
                vim.fn.chdir(vim.fs.dirname(path))
            end

            -- Yank in register full path of entry under cursor
            local yank_path = function()
                local path = (MiniFiles.get_fs_entry() or {}).path
                if path == nil then return vim.notify('Cursor is not on valid entry') end
                vim.fn.setreg(vim.v.register, path)
            end

            -- Open path with system default handler (useful for non-text files)
            local ui_open = function() vim.ui.open(MiniFiles.get_fs_entry().path) end

            -- Autocommand to set up split keymaps when mini.files buffer is created
            vim.api.nvim_create_autocmd('User', {
                pattern = 'MiniFilesBufferCreate',
                callback = function(args)
                    local buf_id = args.data.buf_id
                    -- Map 'gs' to horizontal split and 'gv' to vertical split in mini.files
                    map_split(buf_id, 'gs', 'belowright horizontal')
                    map_split(buf_id, 'gv', 'belowright vertical')

                    vim.keymap.set('n', 'g~', set_cwd, { buffer = buf_id, desc = 'Set cwd' })
                    vim.keymap.set('n', 'go', ui_open, { buffer = buf_id, desc = 'OS open' })
                    vim.keymap.set('n', 'gy', yank_path, { buffer = buf_id, desc = 'Yank path' })
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
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                        }
                    }
                }
            })
            require("telescope").load_extension("ui-select")
        end
    }
}
