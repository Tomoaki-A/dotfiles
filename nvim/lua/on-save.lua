vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.js","*.jsx","*.ts","*.tsx","*.json","*.jsonc" },
  callback = function(args)
    local bufnr = args.buf

    -- biome が attach しているかチェック
    local has_biome = false
    for _, c in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
      if c.name == "biome" and c:supports_method("textDocument/formatting") then
        has_biome = true
        break
      end
    end

    if has_biome then
      -- biome LSP でフォーマット
      vim.lsp.buf.format({
        bufnr = bufnr,
        filter = function(c) return c.name == "biome" end,
        timeout_ms = 2000,
      })
    else
      -- biome が無いときは prettier CLI を使用
      local prettier_bin = require("mason-core.path").bin_prefix("prettier")
      if vim.fn.executable(prettier_bin) == 1 then
        vim.system({ prettier_bin, "--write", args.file }):wait()
      else
        vim.notify("Neither biome nor prettier is available for formatting", vim.log.levels.WARN)
      end
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
