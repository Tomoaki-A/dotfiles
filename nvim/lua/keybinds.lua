-- common
vim.keymap.set('i', 'jj', '<Esc>', { noremap = true, silent = true })

-- nvim-tree
vim.keymap.set("n", "<Space>at", ":NvimTreeToggle<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<Space>af", ":NvimTreeFindFile<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<Space>ap", [[:NvimTreeFindFile<cr>:lua require'nvim-tree.api'.fs.copy.relative_path()<cr>]], {silent = true, noremap = true})
vim.keymap.set('n', '<Space>ac', require('nvim-tree.api').fs.print_clipboard, {noremap = true, silent = true})

-- telescope
vim.keymap.set('n', '<Space>ff', require('telescope.builtin').find_files, {})
vim.keymap.set('n', '<Space>fb', require('telescope.builtin').buffers, {})
vim.keymap.set('n', '<Space>fg', require('telescope.builtin').live_grep, {})

-- git
vim.keymap.set('n', '<Space>g', ':LazyGit<cr>', {silent = true, noremap = true})
vim.keymap.set('n', '<Space>gg', ':Flog<cr>', {silent = true, noremap = true})

-- terminal
vim.keymap.set('n', '<Space>t', ':ToggleTerm<cr>', {silent = true, noremap = true})

-- coc
vim.keymap.set('n', 'gd', '<Plug>(coc-definition)')
vim.keymap.set('n', 'gy', '<Plug>(coc-type-definition)')
vim.keymap.set('n', 'gi', '<Plug>(coc-implementation)')
vim.keymap.set('n', 'gr', '<Plug>(coc-references)')

-- tab
vim.keymap.set('n', '<C-,>', ':BufferPrevious<cr>', {silent = true, noremap = true})
vim.keymap.set('n', '<C-.>', ':BufferNext<cr>', {silent = true, noremap = true})
vim.keymap.set('n', '<C-c>', ':BufferClose<cr>', {silent = true, noremap = true})
