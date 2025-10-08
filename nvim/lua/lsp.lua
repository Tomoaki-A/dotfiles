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

require("mason-lspconfig").setup {
    ensure_installed = { "ts_ls","biome","eslint","tailwindcss","typos_lsp","pyright", "ruff" },
}

-- 1) Mason の bin を PATH に通す（typescript-language-server を確実に見せる）
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

-- 2) ルート検出（取れなくても CWD で起動する保険付き）
local function ts_root(fname)
  return require("lspconfig.util").root_pattern(
    "pnpm-workspace.yaml","turbo.json","yarn.lock",
    "package.json","tsconfig.json",".git"
  )(fname) or vim.loop.cwd()
end

-- 3) ts_ls を通常セットアップ
require("lspconfig").ts_ls.setup({
  cmd = { "typescript-language-server", "--stdio" }, -- Mason 経由を想定
  root_dir = ts_root,
  single_file_support = true,
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  init_options = { hostInfo = "neovim" },
})

-- 4) FileType に頼らず、拡張子ベースで“必ず”付ける保険（読み込み順問題を回避）
local grp = vim.api.nvim_create_augroup("EnsureTsLsAttached", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = grp,
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
  callback = function(args)
    -- 既に ts_ls が付いていれば何もしない
    for _, c in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
      if c.name == "ts_ls" then return end
    end
    -- lspconfig のマネージャ経由でこのバッファを追加。無ければ最後の手段として LspStart
    local srv = require("lspconfig").ts_ls
    if srv and srv.manager and srv.manager.try_add then
      srv.manager.try_add(args.buf)
    else
      vim.cmd("LspStart " .. "ts_ls")
    end
  end,
})

-- biomeの設定
require('lspconfig').biome.setup({
  cmd = { path.bin_prefix("biome"), "lsp-proxy" },
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
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
