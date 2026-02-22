local is_win = require("osage.util").is_win

return {
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = function()
            require('mason').setup()
        end
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
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local mod_cache = nil

            local function root_dir_with_patterns(fname, patterns)
                local match = vim.fs.find(patterns, { upward = true, path = fname })[1]
                if match then
                    return vim.fs.dirname(match)
                end
                return nil
            end

            local win_cmds = {}
            if is_win then
                win_cmds = {
                    html = { "vscode-html-language-server.cmd", "--stdio" },
                    cssls = { "vscode-css-language-server.cmd", "--stdio" },
                    eslint = { "vscode-eslint-language-server.cmd", "--stdio" },
                    ts_ls = { "typescript-language-server.cmd", "--stdio" },
                    tailwindcss = { "tailwindcss-language-server.cmd", "--stdio" },
                    yamlls = { "yaml-language-server.cmd", "--stdio" },
                    jsonls = { "vscode-json-language-server.cmd", "--stdio" },
                }
            end

            vim.lsp.config.gopls = {
                cmd = { "gopls" },
                filetypes = { "go", "gomod", "gowork", "gotmpl" },
                root_dir = function(bufnr, on_dir)
                    local fname = vim.api.nvim_buf_get_name(bufnr)
                    if fname == "" then
                        return
                    end
                    if not mod_cache then
                        local result = vim.fn.systemlist({ "go", "env", "GOMODCACHE" })
                        if result and result[1] then
                            mod_cache = vim.trim(result[1])
                        end
                    end
                    if mod_cache and fname:sub(1, #mod_cache) == mod_cache then
                        local clients = vim.lsp.get_clients({ name = "gopls" })
                        if #clients > 0 then
                            on_dir(clients[#clients].config.root_dir)
                            return
                        end
                    end
                    local root = vim.fs.root(fname, { "go.work", "go.mod", ".git" })
                    on_dir(root or vim.fs.dirname(fname))
                end,
                single_file_support = true,
                capabilities = capabilities,
            }

            vim.lsp.config.lua_ls = {
                cmd = { "lua-language-server" },
                filetypes = { "lua" },
                root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim", "it", "describe", "before_each", "after_each" },
                        },
                    },
                },
                capabilities = capabilities,
            }

            vim.lsp.config.eslint = {
                cmd = win_cmds.eslint or { "vscode-eslint-language-server", "--stdio" },
                filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
                root_markers = {
                    ".eslintrc",
                    ".eslintrc.js",
                    ".eslintrc.cjs",
                    ".eslintrc.yaml",
                    ".eslintrc.yml",
                    ".eslintrc.json",
                    "package.json",
                    ".git",
                },
                settings = { format = false },
                capabilities = capabilities,
            }

            vim.lsp.config.html = {
                cmd = win_cmds.html or { "vscode-html-language-server", "--stdio" },
                filetypes = { "html" },
                root_markers = { "package.json", ".git" },
                capabilities = capabilities,
            }

            vim.lsp.config.ts_ls = {
                cmd = win_cmds.ts_ls or { "typescript-language-server", "--stdio" },
                filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
                root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
                capabilities = capabilities,
            }

            vim.lsp.config.tailwindcss = {
                cmd = win_cmds.tailwindcss or { "tailwindcss-language-server", "--stdio" },
                filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
                root_markers = { "tailwind.config.js", "tailwind.config.cjs", "tailwind.config.mjs", "package.json", ".git" },
                capabilities = capabilities,
            }

            vim.lsp.config.yamlls = {
                cmd = win_cmds.yamlls or { "yaml-language-server", "--stdio" },
                filetypes = { "yaml", "yml" },
                root_markers = { "package.json", ".git" },
                capabilities = capabilities,
            }

            vim.lsp.config.jsonls = {
                cmd = win_cmds.jsonls or { "vscode-json-language-server", "--stdio" },
                filetypes = { "json", "jsonc" },
                root_markers = { "package.json", ".git" },
                capabilities = capabilities,
            }

            vim.lsp.config.rust_analyzer = {
                cmd = { "rust-analyzer" },
                filetypes = { "rust" },
                root_markers = { "Cargo.toml", ".git" },
                capabilities = capabilities,
            }

            vim.lsp.config.cssls = {
                cmd = win_cmds.cssls or { "vscode-css-language-server", "--stdio" },
                filetypes = { "css", "scss", "less" },
                root_markers = { "package.json", ".git" },
                capabilities = capabilities,
            }

            vim.lsp.config.vimls = {
                cmd = { "vim-language-server", "--stdio" },
                filetypes = { "vim" },
                root_markers = { ".vimrc", ".git" },
                capabilities = capabilities,
            }

            vim.lsp.config.bashls = {
                cmd = { "bash-language-server", "start" },
                filetypes = { "sh", "bash", "zsh" },
                root_markers = { ".git" },
                capabilities = capabilities,
            }

            vim.lsp.config.dockerls = {
                cmd = { "docker-langserver", "--stdio" },
                filetypes = { "dockerfile" },
                root_markers = { "Dockerfile", ".git" },
                capabilities = capabilities,
            }

            vim.lsp.config.csharp_ls = {
                cmd = { "csharp-ls" },
                filetypes = { "cs" },
                root_dir = function(bufnr, on_dir)
                    local fname = vim.api.nvim_buf_get_name(bufnr)
                    if fname == "" then
                        return
                    end
                    local root = root_dir_with_patterns(fname, { "*.sln", "*.csproj", ".git" })
                    on_dir(root or vim.fs.dirname(fname))
                end,
                capabilities = capabilities,
            }

            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    local opts = { buffer = event.buf }
                    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
                    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
                    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float({ focusable = true }) end, opts)
                    vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist)
                    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
                    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
                    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
                    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
                    vim.keymap.set("i", "<C-k>", function() vim.lsp.buf.signature_help() end, opts)

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
                    'lua_ls',
                    'yamlls',
                    'vimls',
                    'bashls',
                    'dockerls',
                    'tailwindcss',
                    'csharp_ls',
                },
            })

            vim.lsp.enable({
                'ts_ls',
                'rust_analyzer',
                'html',
                'eslint',
                'gopls',
                'cssls',
                'jsonls',
                'lua_ls',
                'yamlls',
                'vimls',
                'bashls',
                'dockerls',
                'tailwindcss',
                'csharp_ls',
            })

            vim.diagnostic.config({
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
                    yaml = { 'prettierd', "prettier" },
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
