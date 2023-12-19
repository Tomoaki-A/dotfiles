local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.local/share/nvim/site/autoload/plugged')

-- coc.nvim
Plug('neoclide/coc.nvim', {branch = 'release'})

-- nvim-tree
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'

Plug ('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

Plug 'projekt0n/github-nvim-theme'

vim.call('plug#end')
