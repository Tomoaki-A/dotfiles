vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.js", "*.ts", "*.jsx", "*.tsx" },
  callback = function()
    local filepath = vim.fn.expand("%:p")

    -- プロジェクトルートから上に遡って node_modules を探す
    local node_modules = vim.fn.finddir("node_modules", ".;")
    if node_modules == "" then
      return  -- node_modules がなければ何もしない
    end

    local biome_path = node_modules .. "/.bin/biome"
    local eslint_path = node_modules .. "/.bin/eslint"
    local prettier_path = node_modules .. "/.bin/prettier"

    --  Biome があれば最優先で実行
    if vim.fn.filereadable(biome_path) == 1 then
      vim.system({ biome_path, "format", "--write", filepath }):wait()
      vim.cmd("edit!")
      return
    end

    -- SLint → Prettier の順で実行（両方ローカルにある場合のみ）
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
