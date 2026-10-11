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
  "phpactor",
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
-- プロジェクトに node_modules/.bin/biome があればそれを優先して使う。
-- mason の biome はグローバル更新で 2.x に上がりがちだが、プロジェクトの
-- biome.json が 1.x スキーマのままだと 2.x はその設定を読めず（unknown key /
-- schema mismatch）、LSP は起動しても documentFormattingProvider を出さないため
-- 保存時整形が無反応になる。プロジェクトローカルを使えば設定とバージョンが一致する。
lspconfig.biome.setup({
  capabilities = capabilities,
  filetypes = frontend_filetypes,
  root_dir = lspconfig.util.root_pattern("biome.json", "biome.jsonc"),
  on_new_config = function(new_config, root_dir)
    local local_biome = root_dir .. "/node_modules/.bin/biome"
    if vim.fn.filereadable(local_biome) == 1 then
      new_config.cmd = { local_biome, "lsp-proxy" }
    else
      new_config.cmd = { vim.fn.stdpath("data") .. "/mason/bin/biome", "lsp-proxy" }
    end
  end,
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
  -- ESLint 設定ファイルが実在するプロジェクトでのみアタッチする。
  -- package.json/.git を含めると、Biome 移行済みで eslint 設定を持たない
  -- プロジェクトにも常にアタッチしてしまい、pull diagnostics のたびに
  -- "Could not find config file" (-32603) を返してインサートモードが激重になる。
  root_dir = lspconfig.util.root_pattern(
    "eslint.config.js",
    "eslint.config.mjs",
    "eslint.config.cjs",
    "eslint.config.ts",
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.json",
    ".eslintrc.yaml",
    ".eslintrc.yml"
  ),
  single_file_support = false,

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

-- PHP LSPの設定
lspconfig.phpactor.setup({
  capabilities = capabilities,
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/phpactor", "language-server" },
  filetypes = { "php" },
  root_dir = lspconfig.util.root_pattern("composer.json", ".phpactor.json", ".phpactor.yml", ".git"),
  single_file_support = true,
  -- 起動時の "Phpstan/Psalm detected, enable extension?" プロンプトを抑制し、
  -- 拡張は明示的に有効化する
  init_options = {
    ["language_server_configuration.auto_config"] = false,
    ["language_server_phpstan.enabled"] = true,
    -- psalm は enabled=true にすると vendor/bin/psalm が無いプロジェクトで
    -- 毎回エラーになるため、必要なプロジェクトだけ .phpactor.json で有効化する
    ["language_server_psalm.enabled"] = false,
  },
})

-- Lua LSPの設定
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      format = { enable = false }, -- LSPのformat機能をOFF
    },
  },
})
