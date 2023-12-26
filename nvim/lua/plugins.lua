local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.local/share/nvim/site/autoload/plugged')

-- coc.nvim
Plug('neoclide/coc.nvim', {branch = 'release'})

-- nvim-tree
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'

-- telescope
Plug ('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

-- theme
Plug 'projekt0n/github-nvim-theme'

-- ime
Plug 'keaising/im-select.nvim'

-- fuzzy finder
Plug('junegunn/fzf', {['do'] = vim.fn['fzf#install()']})
Plug 'junegunn/fzf.vim'

vim.call('plug#end')
