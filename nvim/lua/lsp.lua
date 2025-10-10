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

-- TypeScript/JavaScript LSPの設定
lspconfig.vtsls.setup({
  capabilities = capabilities,
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/vtsls", "--stdio" },
  filetypes = frontend_filetypes,
  root_dir = lspconfig.util.root_pattern("tsconfig.json", "package.json", ".git"),
  single_file_support = true,
  settings = {
    vtsls = { tsserver = { maxTsServerMemory = 4096 } },
    typescript = { preferences = { importModuleSpecifier = "non-relative" } },
  },
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

-- Typo LSPの設定
lspconfig.cspell.setup({
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern(".git"),
  cmd = { "cspell-lsp" },
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
lspconfig.ruff_lsp.setup({
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
