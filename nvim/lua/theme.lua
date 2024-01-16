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
