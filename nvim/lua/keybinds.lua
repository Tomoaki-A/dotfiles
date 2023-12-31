
-- nvim-tree
vim.keymap.set("n", "<Space>tt", ":NvimTreeToggle<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<Space>tf", ":NvimTreeFocus<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<Space>tp", [[:NvimTreeFindFile<cr>:lua require'nvim-tree.api'.fs.copy.relative_path()<cr>]], {silent = true, noremap = true})
vim.keymap.set('n', '<Space>tc', require('nvim-tree.api').fs.print_clipboard, {noremap = true, silent = true})

-- telescope
vim.keymap.set('n', '<Space>ff', require('telescope.builtin').find_files, {})
vim.keymap.set('n', '<Space>fg', require('telescope.builtin').live_grep, {})
