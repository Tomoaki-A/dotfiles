local cmp = require('cmp')
cmp.setup({
  sources = {
    { name = "nvim_lsp" },
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
  }),
})

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls","tsserver","biome","eslint","tailwindcss" },
}
require('mason-lspconfig').setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = require('cmp_nvim_lsp').default_capabilities(),
    }
  end,
}
