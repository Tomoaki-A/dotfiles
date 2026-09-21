-- ルートディレクトリを決定
-- .git だけだとリポジトリルートで止まり、node_modules がある frontend/apps/karte まで
-- 降りてこない（node_modules はリポジトリルートの下の階層にしかない）。
-- package.json/biome.json も候補に入れ、検索の起点も cwd ではなく
-- 「編集中ファイルのディレクトリ」にする（cwd がどこでも正しく解決するように）。
local function get_ts_ls_root_dir()
  local root = require("lspconfig.util").root_pattern("biome.json", "package.json", ".git")
  return root(vim.fn.expand("%:p:h"))
end

-- BufWritePre: LSP経由で biome がバッファを整形してから書き込む
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.js", "*.ts", "*.jsx", "*.tsx", "*.css" },
  callback = function()
    local root_dir = get_ts_ls_root_dir()
    local node_modules = root_dir and vim.fn.finddir("node_modules", root_dir .. ";") or ""
    if node_modules == "" then
      return
    end

    local biome_path = node_modules .. "/.bin/biome"
    if vim.fn.filereadable(biome_path) == 1 then
      vim.lsp.buf.format({ name = "biome", async = false })
    end
  end,
})

-- BufWritePost: 書き込み後にファイルへ直接 eslint/prettier を適用して再読み込み
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.js", "*.ts", "*.jsx", "*.tsx", "*.css" },
  callback = function()
    local filepath = vim.fn.expand("%:p")
    local root_dir = get_ts_ls_root_dir()
    local node_modules = root_dir and vim.fn.finddir("node_modules", root_dir .. ";") or ""
    if node_modules == "" then
      return
    end

    local biome_path = node_modules .. "/.bin/biome"
    local eslint_path = node_modules .. "/.bin/eslint"
    local prettier_path = node_modules .. "/.bin/prettier"

    -- biome がある場合は BufWritePre で処理済み
    if vim.fn.filereadable(biome_path) == 1 then
      return
    end

    local ran = false

    if vim.fn.filereadable(eslint_path) == 1 then
      vim.system({ eslint_path, "--fix", filepath }):wait()
      ran = true
    end

    if vim.fn.filereadable(prettier_path) == 1 then
      vim.system({ prettier_path, "--write", filepath }):wait()
      ran = true
    end

    if ran then
      vim.cmd("edit!")
    end
  end,
})

-- pythonの保存時にruffで自動修正
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.py",
  callback = function(ctx)
    local filepath = vim.fn.expand("%:p")
    vim.system({ "ruff", "check", filepath, "--fix" }):wait()
    vim.system({ "ruff", "format", filepath }):wait()
    vim.cmd("edit!")
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.lua",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
