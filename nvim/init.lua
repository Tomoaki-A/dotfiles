require('plugins')
-- keybinds
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
-- coc
vim.g.coc_global_extensions = {
  'coc-tsserver',
  'coc-eslint',
  'coc-prettier',
  'coc-git',
  'coc-fzf-preview',
  'coc-lists',
  'coc-copilot',
  'coc-json',
  'coc-yaml',
  'coc-spell-checker',
  'coc-tailwindcss',
  "coc-phpls",
  "coc-html",
  "@yaegassy/coc-laravel",
}

vim.cmd([[
  inoremap <silent><expr> <Enter> coc#pum#visible() ? coc#pum#confirm() : "\<Enter>"
  inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
  inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"
  inoremap <silent><expr> <Enter> coc#pum#visible() ? coc#pum#confirm() : "\<Enter>"
  inoremap <silent><expr> <Esc> coc#pum#visible() ? coc#pum#cancel() : "\<Esc>"
]])
-- filer
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)
  -- fに割り当てられているkeymapを削除
  vim.keymap.del("n", "f", {buffer = bufnr})
end

-- nvim-treeの設定
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
    highlight_git = true,
    highlight_diagnostics = true,
    highlight_modified = "all",
    icons = {
      glyphs = {
        git = {
          unstaged = "●",
          staged = "",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  diagnostics = {
        enable = true,
        show_on_dirs = false,
        show_on_open_dirs = true,
        debounce_delay = 50,
        severity = {
          min = vim.diagnostic.severity.HINT,
          max = vim.diagnostic.severity.ERROR,
        },
        icons = {
          -- hint = "",
          -- info = "",
          warning = "",
          error = "",
        },
      },
  filters = {
    dotfiles = false,
  },
  git = {
   enable = true,
   ignore = false,
   timeout = 500,
  },
  on_attach = my_on_attach,
})

-- nvim-web-deviconsの設定
require('nvim-web-devicons').setup {
 override = {
  ts = {
    icon = "󰛦",
    color = "#519aba",
    cterm_color = "48",
    name = "TypeScript"
  }
 };
 color_icons = true;
 default = true;
 strict = true;
 override_by_filename = {
  [".gitignore"] = {
    icon = "",
    color = "#f1502f",
    name = "Gitignore"
  }
 };
 override_by_extension = {
  ["log"] = {
    icon = "",
    color = "#81e043",
    name = "Log"
  }
 };
}
-- options
vim.api.nvim_set_option('termguicolors', true)
vim.api.nvim_set_option('scrolloff', 4)
vim.api.nvim_set_option('ignorecase', true)
vim.api.nvim_set_option('smartcase', true)
vim.api.nvim_set_option('inccommand', 'split')
vim.api.nvim_set_option('clipboard', 'unnamedplus')

vim.api.nvim_win_set_option(0, 'number', true)
vim.api.nvim_win_set_option(0, 'cursorline', true)
vim.api.nvim_win_set_option(0, 'signcolumn', 'yes:1')

-- local to buffer options:
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = '*',

  group = vim.api.nvim_create_augroup('buffer_set_options', {}),

  callback = function()
    vim.api.nvim_buf_set_option(0, 'expandtab', true)
    vim.api.nvim_buf_set_option(0, 'tabstop', 2)
    vim.api.nvim_buf_set_option(0, 'shiftwidth', 0)
  end,
})

-- swap filesを作らない
vim.api.nvim_exec([[
  set noswapfile

]], false)

vim.opt.laststatus = 3
-- syntax
require'nvim-treesitter.configs'.setup ({
  ensure_installed = {
    "lua",
    "bash",
    "vim",
    "html",
    "css",
    "scss",
    "go",
    "json",
    "typescript",
    "typoscript",
    "tsx",
    "vue",
    "php",
    "graphql",
  },
 highlight = {
  enable = true,
  },
})
-- theme
if vim.fn.has('termguicolors') == 1 then
  vim.o.termguicolors = true
end

vim.cmd('set background=dark')
vim.cmd('colorscheme github_dark_colorblind')

vim.api.nvim_set_hl(0, "DiagnosticError", { fg="#ff0000" })
vim.api.nvim_set_hl(0, "ErrorMsg", { fg="#ff0000" })
vim.api.nvim_set_hl(0, "Error", { fg="#ff0000" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg="#ff0000" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline=true, fg="#ff0000" })

-- ime
require('im_select').setup({
  default_im_select  = "com.apple.keylayout.ABC",
  set_default_events = {"InsertLeave"},
})

-- fzf
require('telescope').setup({
  defaults = {
    file_ignore_patterns = {
      "node_modules"
    },
    layout_strategy = "vertical",
  }
})
-- git

-- tab
require('barbar').setup({})

-- terminal
require("toggleterm").setup({
  size = 20,
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})
-- indent
local highlight = {
    "CursorColumn",
    "Whitespace",
}

require("ibl").setup({
    whitespace = {
        highlight = highlight,
        remove_blankline_trail = false,
    },
})
-- Statusline
require('lualine').setup({
  options = {
    icons_enabled = true,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
})
-- Colilot
vim.g.copilot_filetypes = {markdown = true}
