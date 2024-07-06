require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "tsserver","biome","eslint","tailwindcss" },
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
require("lspconfig").tailwindcss.setup {}
