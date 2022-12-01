local status, cmp = pcall(require, "cmp")
if (not status) then return end
local lspkind = require 'lspkind'

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-i>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = "luasnip" },
        { name = 'buffer' },
    }),
    formatting = {
        format = lspkind.cmp_format({ with_text = false, maxwidth = 50 })
    }
})

vim.cmd [[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]]

-- Autoclose
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)

require("luasnip.loaders.from_vscode").lazy_load()
-- -- " Use <Tab> and <S-Tab> to navigate through popup menu
-- -- inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
-- -- inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
