return {
    -- LSP & Navigation
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
        end
    },
    { 'echasnovski/mini.colors',

    },

    {
        'nvim-telescope/telescope.nvim',
        dependencies = { { 'nvim-lua/plenary.nvim' }, },
    },
    'theprimeagen/harpoon',

    {
        "williamboman/mason.nvim",
        config = function()
            require('mason').setup()
        end
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        },
    },

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
}
