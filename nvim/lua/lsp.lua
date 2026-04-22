local cmp = require("cmp")
cmp.setup({
  sources = {
    { name = "nvim_lsp" },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
  }),
})

require("mason").setup()

local servers = {
  "vtsls",
  "vue_ls",
  "biome",
  "tailwindcss",
  "eslint",
  "pyright",
  "ruff",
  "stylua",
  "lua_ls",
  "graphql",
}

local unsupported_servers = { "cspell-lsp" }

require("mason-lspconfig").setup({
  ensure_installed = servers,
})

local mason_registry = require("mason-registry")
for _, name in ipairs(unsupported_servers) do
  if not mason_registry.is_installed(name) then
    mason_registry.get_package(name):install()
  end
end
local lspconfig = require("lspconfig")

local frontend_filetypes = {
  "html",
  "css",
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "vue",
  "svelte",
}

-- Vue Language Server (Volar) のインストール先。
-- vtsls が .vue を解決できるよう、@vue/typescript-plugin をここから読み込ませる。
local vue_ls_path = vim.fn.stdpath("data")
  .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

-- TypeScript/JavaScript LSPの設定
lspconfig.vtsls.setup({
  capabilities = capabilities,
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/vtsls", "--stdio" },
  filetypes = frontend_filetypes,
  root_dir = lspconfig.util.root_pattern("tsconfig.json", "package.json", ".git"),
  single_file_support = true,
  settings = {
    vtsls = {
      tsserver = {
        maxTsServerMemory = 4096,
        globalPlugins = {
          {
            name = "@vue/typescript-plugin",
            location = vue_ls_path,
            languages = { "vue" },
            configNamespace = "typescript",
          },
        },
      },
    },
    typescript = { preferences = { importModuleSpecifier = "non-relative" } },
  },
})

-- Vue LSPの設定 (Volar hybrid mode: TS は vtsls、template/SFC 固有は vue_ls が担当)
lspconfig.vue_ls.setup({
  capabilities = capabilities,
  filetypes = { "vue" },
  root_dir = lspconfig.util.root_pattern("package.json", ".git"),
  single_file_support = true,
})

-- Biome LSPの設定
lspconfig.biome.setup({
  capabilities = capabilities,
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/biome", "lsp" },
  filetypes = frontend_filetypes,
  root_dir = lspconfig.util.root_pattern("biome.json", ".biomerc", ".git"),
  single_file_support = true,
})

-- Tailwind CSS LSPの設定
lspconfig.tailwindcss.setup({
  capabilities = capabilities,
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/tailwindcss-language-server", "--stdio" },
  filetypes = frontend_filetypes,
  root_dir = lspconfig.util.root_pattern(
    "tailwind.config.js",
    "tailwind.config.cjs",
    "tailwind.config.ts",
    "postcss.config.js",
    "postcss.config.cjs",
    "postcss.config.ts",
    "package.json",
    ".git"
  ),
  single_file_support = true,
})

-- ESLint LSPの設定
lspconfig.eslint.setup({
  capabilities = capabilities,
  filetypes = frontend_filetypes,
  root_dir = lspconfig.util.root_pattern(
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.json",
    ".eslintrc.yaml",
    ".eslintrc.yml",
    "package.json",
    ".git"
  ),
  single_file_support = true,

  on_init = function(client)
    -- LSP 側から送られる「Unable to find ESLint library.」メッセージを潰す
    local notify = vim.notify
    vim.notify = function(msg, level, opts)
      if type(msg) == "string" and msg:match("Unable to find ESLint library") then
        return
      end
      notify(msg, level, opts)
    end
  end,
})

-- Typo LSPの設定 (cspell-lsp は nvim-lspconfig 未登録のためカスタム定義)
local lsp_configs = require("lspconfig.configs")
if not lsp_configs.cspell_lsp then
  lsp_configs.cspell_lsp = {
    default_config = {
      cmd = { "cspell-lsp", "--stdio" },
      filetypes = { "*" },
      root_dir = lspconfig.util.root_pattern(".git"),
      single_file_support = true,
    },
  }
end
lspconfig.cspell_lsp.setup({
  capabilities = capabilities,
})

-- Python LSPの設定
lspconfig.pyright.setup({
  capabilities = capabilities,
  filetypes = { "python" },
  root_dir = lspconfig.util.root_pattern(
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "Pipfile.lock",
    ".git"
  ),
  single_file_support = true,
})

-- Ruff LSPの設定
lspconfig.ruff.setup({
  capabilities = capabilities,
  filetypes = { "python" },
  root_dir = lspconfig.util.root_pattern(
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "Pipfile.lock",
    ".git"
  ),
  single_file_support = true,
})

-- Lua LSPの設定
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      format = { enable = false }, -- LSPのformat機能をOFF
    },
  },
})
