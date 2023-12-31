-- https://github.com/nvim-tree/nvim-tree.lua

-- デフォルトのファイラーをdisableにする
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
  filters = {
    dotfiles = true,
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

