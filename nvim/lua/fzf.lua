require('telescope').setup({
  defaults = {
    file_ignore_patterns = {
      "node_modules",
      "pnpm-lock.yaml",
      "%.png",
      "%.jpg",
    },
    layout_strategy = "vertical",
    path_display = {
      "truncate"
    },
  }
})
