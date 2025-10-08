-- common
vim.keymap.set('i', 'jj', '<Esc>:w<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '0', '$', { noremap = true, silent = true })
vim.keymap.set('v', '0', '$', { noremap = true, silent = true })
vim.keymap.set('n', '1', '0', { noremap = true, silent = true })
vim.keymap.set('v', '1', '0', { noremap = true, silent = true })

-- 移動
vim.keymap.set('n', 'w', 'ge', { noremap = true, silent = true })
vim.keymap.set("n", "]e", function()
  vim.diagnostic.goto_next({
    severity = vim.diagnostic.severity.ERROR,
    skip_current = true
  })
  vim.cmd("normal! e")
end, { noremap = true, silent = true })

vim.keymap.set("n", "]w", function()
  vim.cmd("normal! b")
  vim.diagnostic.goto_prev({
    severity = vim.diagnostic.severity.ERROR,
    skip_current = true
  })
  vim.cmd("normal! e")
end, { noremap = true, silent = true })

vim.keymap.set("n", "xx", '"_dd', { noremap = true, silent = true })

-- 単語のヤンク
vim.keymap.set('n', 'vv', 'viwy', { noremap = true, silent = true })

-- nvim-tree
vim.keymap.set("n", "<Space>at", ":NvimTreeToggle<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<Space>af", ":NvimTreeFindFile<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<Space>ap", [[:NvimTreeFindFile<cr>:lua require'nvim-tree.api'.fs.copy.relative_path()<cr>]], {silent = true, noremap = true})
vim.keymap.set('n', '<Space>ac', ":NvimTreeCollapse<cr>", {noremap = true, silent = true})

-- telescope
vim.keymap.set('n', '<Space>ff', require('telescope.builtin').find_files, {})
vim.keymap.set('n', '<Space>fb', require('telescope.builtin').buffers, {})
vim.keymap.set('n', '<Space>fg', require('telescope.builtin').live_grep, {})

-- git
vim.keymap.set('n', '<Space>g', ':LazyGit<cr>', {silent = true, noremap = true})
vim.keymap.set('n', '<Space>gg', ':Flog<cr>', {silent = true, noremap = true})

-- 定義に移動
vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions)
-- 定義をホバー
vim.keymap.set('n', 'gh', vim.lsp.buf.hover)
-- 定義を参照
vim.keymap.set('n', 'gr', function()
  require('telescope.builtin').lsp_references({
    layout_strategy = "vertical",
    path_display = {
      "truncate",
    },
    show_line = false,
  })
end)

-- エラーを表示
vim.keymap.set('n', 'ge', vim.diagnostic.open_float)
-- リネーム
vim.keymap.set('n', 'gn', vim.lsp.buf.rename)

-- tab
-- @memo タブを移動するときに、nvim-treeのファイルを開く
vim.keymap.set('n', ',', [[:BufferPrevious<cr> :lua require'nvim-tree.api'.tree.find_file({ open = true, focus = false, })<cr>]], {silent = false, noremap = true})
vim.keymap.set('n', '.', [[:BufferNext<cr>:lua require'nvim-tree.api'.tree.find_file({ open = true, focus = false, })<cr>]], {silent = false, noremap = true})

vim.keymap.set('n', '<C-c>', ':BufferClose<cr>', {silent = true, noremap = true})
vim.keymap.set('n', '<C-d>', ':BufferCloseAllButCurrent<cr>', {silent = true, noremap = true})
vim.keymap.set('n', '<C-s>', ':BufferOrderByDirectory<cr>', {silent = true, noremap = true})
