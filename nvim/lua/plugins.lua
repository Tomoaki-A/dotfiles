local Plug = vim.fn["plug#"]
vim.call("plug#begin", "~/.local/share/nvim/site/autoload/plugged")

-- coc.nvim
--Plug('neoclide/coc.nvim', {branch = 'release'})

-- nvim-tree
Plug("nvim-tree/nvim-tree.lua")
Plug("nvim-tree/nvim-web-devicons")

-- telescope
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })

-- theme
Plug("projekt0n/github-nvim-theme")

-- ime
Plug("keaising/im-select.nvim")

-- fuzzy finder
Plug("nvim-lua/plenary.nvim")
Plug("nvim-telescope/telescope.nvim", { tag = "0.1.5" })
Plug("junegunn/fzf", { ["dir"] = "~/.fzf_bin", ["do"] = "./install --all" })

-- tab
Plug("romgrk/barbar.nvim")

-- git
Plug("kdheepak/lazygit.nvim")
Plug("tpope/vim-fugitive")
Plug("rbong/vim-flog")
Plug("lewis6991/gitsigns.nvim")

-- terminal
Plug("akinsho/toggleterm.nvim", { tag = "*" })

-- indent
Plug("lukas-reineke/indent-blankline.nvim")

-- statusline
Plug("nvim-lualine/lualine.nvim")

--
Plug("dense-analysis/ale")

Plug("williamboman/mason.nvim")
Plug("williamboman/mason-lspconfig.nvim")
Plug("neovim/nvim-lspconfig")

Plug("hrsh7th/nvim-cmp")
Plug("hrsh7th/cmp-nvim-lsp")
vim.call("plug#end")
