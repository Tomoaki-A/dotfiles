vim.g.ale_fix_on_save = 1
vim.g.ale_fixers = {'biome','prettier','eslint'}
vim.g.ale_linters = {
  javascript = {'biome','eslint'},
  typescript = {'biome','eslint'},
  typescriptreact = {'biome','eslint'},
}
