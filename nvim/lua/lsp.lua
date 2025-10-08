local cmp = require('cmp')
cmp.setup({
  sources = {
    { name = "nvim_lsp" },
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm { select = false },
  }),
})

local path = require("mason-core.path")
require("mason").setup()

-- tsserverの設定
require('lspconfig').ts_ls.setup({
    init_options = {
      preferences = {
        importModuleSpecifierPreference = 'non-relative', -- 絶対パス優先
      }
    }
})

-- biomeの設定
require('lspconfig').biome.setup({
  cmd = { path.bin_prefix("biome"), "lsp-proxy" },
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  on_attach = function(client, bufnr)
    -- デバッグ用
    vim.notify("Biome attached with formatting: " .. tostring(client.server_capabilities.documentFormattingProvider))
  end
})
-- eslintの設定
require('lspconfig').eslint.setup({
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

-- tailwindcssの設定
require('lspconfig').tailwindcss.setup({
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

-- pyrightの設定
require('lspconfig').pyright.setup({
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

-- ruffの設定
require('lspconfig').ruff_lsp.setup({
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

-- typo-lspをWarningレベルで起動
require('lspconfig').typos_lsp.setup({
    cmd_env = { RUST_LOG = "Warning" },
    init_options = {
        config = '~/code/typos-lsp/crates/typos-lsp/tests/typos.toml',
        diagnosticSeverity = "Warning"
    },
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
})
