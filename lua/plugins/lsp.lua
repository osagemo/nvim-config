local is_win = require("osage.util").is_win

-- return {
--     "neovim/nvim-lspconfig",
--     dependencies = {
--         "williamboman/mason.nvim",
--         "williamboman/mason-lspconfig.nvim",
--         "hrsh7th/cmp-nvim-lsp",
--         "hrsh7th/cmp-buffer",
--         "hrsh7th/cmp-path",
--         "hrsh7th/cmp-cmdline",
--         "hrsh7th/nvim-cmp",
--         "L3MON4D3/LuaSnip",
--         "saadparwaiz1/cmp_luasnip",
--         "j-hui/fidget.nvim",
--     },
--
--     config = function()
--         local cmp = require('cmp')
--         local cmp_lsp = require("cmp_nvim_lsp")
--
--         require("fidget").setup({})
--         require('mason').setup()
--         require('mason-lspconfig').setup()
--     end
-- }

return {
    {
        'williamboman/mason.nvim',
        lazy = false,
        opts = {},
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        config = function()
            local cmp = require('cmp')
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-i>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.close(),
                    ['<CR>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true
                    }),
                    ['<C-y>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true
                    }),
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }, -- For luasnip users.
                }, {
                    { name = 'buffer' },
                })
            })
        end
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { "L3MON4D3/LuaSnip" },
            { "saadparwaiz1/cmp_luasnip" },
            { "j-hui/fidget.nvim" },
        },
        config = function()
            local lsp_defaults = require('lspconfig').util.default_config

            -- Add cmp_nvim_lsp capabilities settings to lspconfig
            -- This should be executed before you configure any language server
            lsp_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lsp_defaults.capabilities,
                require('cmp_nvim_lsp').default_capabilities()
            )

            -- LspAttach is where you enable features that only work
            -- if there is a language server active in the file
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    local opts = { buffer = event.buf }
                    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
                    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
                    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                    vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist)
                    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
                    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
                    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
                    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
                    vim.keymap.set("i", "<C-k>", function() vim.lsp.buf.signature_help() end, opts)

                    -- From lsp-zero docs
                    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                    vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
                end,
            })
            require("fidget").setup({})
            require('mason-lspconfig').setup({
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
                    -- this first function is the "default handler"
                    -- it applies to every language server without a "custom handler"
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,

                    -- From Prime
                    ["lua_ls"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.lua_ls.setup {
                            capabilities = capabilities,
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { "vim", "it", "describe", "before_each", "after_each" },
                                    }
                                }
                            }
                        }
                    end,
                }
            })

            if is_win then
                require("lspconfig").html.setup {
                    cmd = { "vscode-css-language-server.cmd", "--stdio" }
                }
                require("lspconfig").eslint.setup {
                    cmd = { "vscode-eslint-language-server.cmd", "--stdio" },
                    root_dir = require("lspconfig.util").root_pattern(
                        ".eslintrc",
                        ".eslintrc.js",
                        ".eslintrc.cjs",
                        ".eslintrc.yaml",
                        ".eslintrc.yml",
                        ".eslintrc.json",
                        "package.json",
                        ".git"
                    ),
                    settings = { format = false },
                }
                require("lspconfig").ts_ls.setup {
                    cmd = { "typescript-language-server.cmd", "--stdio" }
                }
                require("lspconfig").tailwindcss.setup {
                    cmd = { "tailwindcss-language-server.cmd", "--stdio" }
                }
                require("lspconfig").yamlls.setup {
                    cmd = { "yaml-language-server.cmd", "--stdio" }
                }
                require 'lspconfig'.jsonls.setup {
                    cmd = { "vscode-json-language-server.cmd", "--stdio" }
                }
            end

            vim.diagnostic.config({
                -- update_in_insert = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })
        end
    },
    {
        'stevearc/conform.nvim',
        config = function()
            require('conform').setup({
                formatters_by_ft = {
                    javascript = { "prettierd", "prettier", stop_after_first = true },
                    typescript = { 'prettierd', "prettier" },
                    typescriptreact = { 'prettierd', "prettier" },
                    javascriptreact = { 'prettierd', "prettier" },
                    json = { 'prettierd', "prettier" },
                    html = { 'prettierd', "prettier" },
                    css = { 'prettierd', "prettier" },
                },
                format_on_save = {
                    -- These options will be passed to conform.format()
                    timeout_ms = 500,
                    lsp_format = "fallback",
                },
            })
        end
    }
}
