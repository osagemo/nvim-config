return {
    -- LSP & Navigation
    { 'echasnovski/mini.icons', version = '*',
        config = function()
            require('mini.icons').setup()
            require('mini.icons').mock_nvim_web_devicons()
        end
    },
    { 'echasnovski/mini.files', version = '*' },

    {
        'nvim-telescope/telescope.nvim',
        dependencies = { { 'nvim-lua/plenary.nvim' }, },
    },
    'theprimeagen/harpoon',

    "williamboman/mason.nvim",
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                'ts_ls',
                'rust_analyzer',
                'html',
                'eslint',
                'gopls',
                'cssls',
                'jsonls',
                'yamlls',
                'vimls',
                'bashls',
                'dockerls',
                'tailwindcss',
                'csharp_ls',
            },
            handlers = {
                lsp.default_setup,
                lua_ls = function()
                    local lua_opts = lsp.nvim_lua_ls()
                    require('lspconfig').lua_ls.setup(lua_opts)
                end,
            }

        }
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
    "terrortylor/nvim-comment",

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
