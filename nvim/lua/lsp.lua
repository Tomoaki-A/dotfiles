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

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "tsserver","biome","eslint","tailwindcss","typos_lsp","pyright", "ruff" },
}
require('mason-lspconfig').setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = require('cmp_nvim_lsp').default_capabilities(),
    }
  end,
}

-- typo-lspをWarningレベルで起動
require('lspconfig').typos_lsp.setup({
    cmd_env = { RUST_LOG = "Warning" },
    init_options = {
        config = '~/code/typos-lsp/crates/typos-lsp/tests/typos.toml',
        diagnosticSeverity = "Warning"
    }
})
