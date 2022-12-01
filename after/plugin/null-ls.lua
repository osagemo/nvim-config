local status, null_ls = pcall(require, "null-ls")
if (not status) then return end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
    if vim.lsp.buf.format then -- >=0.8
        vim.lsp.buf.format({
            filter = function(client)
                return client.name == "null-ls"
            end,
            bufnr = bufnr,
        })
    elseif vim.lsp.buf.formatting_sync then
        vim.lsp.buf.formatting_sync({
            bufnr = bufnr,
        })
    end
end

null_ls.setup {
    sources = {
        null_ls.builtins.formatting.prettierd.with({
            command = "prettierd.CMD",
            env = {
                PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/utils/linter-config/.prettierrc.json"),
            },
        }),
        -- null_ls.builtins.diagnostics.eslint_d.with({
        --     diagnostics_format = '[eslint] #{m}\n(#{c})'
        -- }),
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    lsp_formatting(bufnr)
                end,
            })
        end
    end
}

vim.api.nvim_create_user_command(
    'DisableLspFormatting',
    function()
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
    end,
    { nargs = 0 }
)
