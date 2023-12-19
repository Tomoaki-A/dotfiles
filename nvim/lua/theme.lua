if vim.fn.has('termguicolors') == 1 then
  vim.o.termguicolors = true
end

vim.cmd('set background=dark')
vim.cmd('colorscheme github_dark_colorblind')
