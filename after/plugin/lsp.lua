local is_win = require("osage.util").is_win
local lsp = require("lsp-zero")

require('mason').setup({})
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
        lsp.default_setup,
        lua_ls = function()
            local lua_opts = lsp.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
    }
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
    },
    formatting = lsp.cmp_format(),
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
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
    }),
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = { Error = " ", Warn = " ", Hint = " ", Info = " " }
})

local enable_format_on_save = function(_, bufnr)
    vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup_format,
        buffer = bufnr,
        callback = function()
            if vim.lsp.buf.format then
                vim.lsp.buf.format({ bufnr = bufnr })
            elseif vim.lsp.buf.formatting then
                vim.lsp.buf.formatting({ bufnr = bufnr })
            end
        end,
    })
end

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

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

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        if vim.lsp.buf.format then
            vim.lsp.buf.format()
        elseif vim.lsp.buf.formatting then
            vim.lsp.buf.formatting()
        end
    end, { desc = 'Format current buffer with LSP' })
    -- format on save
    enable_format_on_save(client, bufnr)
end)


lsp.setup()

vim.diagnostic.config({
    virtual_text = true
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
end
