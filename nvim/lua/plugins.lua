local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.local/share/nvim/site/autoload/plugged')

-- coc.nvim
Plug('neoclide/coc.nvim', {branch = 'release'})

-- nvim-tree
Plug 'nvim-tree/nvim-tree.lua'

vim.call('plug#end')
