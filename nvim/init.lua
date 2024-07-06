require('plugins')
require('keybinds')
--require('coc')
require('filer')
require('options')
require('syntax')
require('theme')
require('ime')
require('fzf')
require('git-plug')
require('tab')
require('terminal')
require('indent')
require('status-line')
-- require('copilot')
require('linter')
--require('ale')

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "tsserver","biome","eslint","graphql","tailwindcss" },
}
require("lspconfig").tsserver.setup {}
require("lspconfig").biome.setup {}
require("lspconfig").eslint.setup{
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
}
require("lspconfig").graphql.setup {}
require("lspconfig").tailwindcss.setup {}

-- 定義に移動
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
-- 定義をホバー
vim.keymap.set('n', 'gh', vim.lsp.buf.hover)
