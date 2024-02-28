-- common
vim.keymap.set('i', 'jj', '<Esc>', { noremap = true, silent = true })
vim.keymap.set('n', '0', '$', { noremap = true, silent = true })
vim.keymap.set('v', '0', '$', { noremap = true, silent = true })
vim.keymap.set('n', '1', '0', { noremap = true, silent = true })
vim.keymap.set('v', '1', '0', { noremap = true, silent = true })

vim.keymap.set('n', 'vv', 'viwy', { noremap = true, silent = true })

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

-- coc
vim.keymap.set('n', 'gd', ':CocCommand fzf-preview.CocDefinition<cr>')
vim.keymap.set('n', 'ge', ':CocCommand fzf-preview.CocCurrentDiagnostics<cr>')
vim.keymap.set('n', 'gt', ':CocCommand fzf-preview.CocTypeDefinition<cr>')
vim.keymap.set('n', 'gi', ':CocCommand fzf-preview.CocImplementations<cr>')
vim.keymap.set('n', 'gr', ':CocCommand fzf-preview.CocReferences<cr>')
vim.keymap.set('n', 'gh', ':call CocActionAsync("doHover")<cr>')

-- tab
-- @memo タブを移動するときに、nvim-treeのファイルを開く
vim.keymap.set('n', ',', [[:BufferPrevious<cr> :lua require'nvim-tree.api'.tree.find_file({ open = true, focus = false, })<cr>]], {silent = false, noremap = true})
vim.keymap.set('n', '.', [[:BufferNext<cr>:lua require'nvim-tree.api'.tree.find_file({ open = true, focus = false, })<cr>]], {silent = false, noremap = true})

vim.keymap.set('n', '<C-c>', ':BufferClose<cr>', {silent = true, noremap = true})
vim.keymap.set('n', '<C-d>', ':BufferCloseAllButCurrent<cr>', {silent = true, noremap = true})
vim.keymap.set('n', '<C-s>', ':BufferOrderByDirectory<cr>', {silent = true, noremap = true})
