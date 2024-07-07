if vim.fn.has('termguicolors') == 1 then
  vim.o.termguicolors = true
end

vim.cmd('colorscheme github_dark_colorblind')

vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg="#FFBA18" })
vim.api.nvim_set_hl(0, "WarningMsg", { fg="#FFBA18" })
vim.api.nvim_set_hl(0, "Warning", { fg="#FFBA18" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg="#FFBA18" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { underline=true, fg="#FFBA18" })
vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })

vim.api.nvim_set_hl(0, "DiagnosticError", { fg="#DF3478" })
vim.api.nvim_set_hl(0, "ErrorMsg", { fg="#DF3478" })
vim.api.nvim_set_hl(0, "Error", { fg="#DF3478" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg="#DF3478" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline=true, fg="#DF3478" })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })

--vim.cmd('hi clear')
--if vim.fn.exists("syntax_on") then
--  vim.cmd('syntax reset')
--end
--
--local colors = {
--  bg = "#000000",
--  fg = "#d4d4d4",
--  fg2 = "#c3c3c3",
--  fg3 = "#b2b2b2",
--  fg4 = "#a1a1a1",
--  bg2 = "#141414",
--  bg3 = "#292929",
--  bg4 = "#3d3d3d",
--  keyword = "#d4d4d4",
--  builtin = "#d4d4d4",
--  const = "#d4d4d4",
--  comment = "#808080",
--  func = "#d4d4d4",
--  str = "#d4d4d4",
--  type = "#d4d4d4",
--  var = "#d4d4d4",
--  warning = "#ff0000",
--  warning2 = "#ff8800",
--}
--
---- ハイライトの設定
--local function set_highlight(group, opts)
--  vim.api.nvim_set_hl(0, group, opts)
--end
--
--set_highlight('Normal', { fg = colors.fg, bg = colors.bg })
--set_highlight('Cursor', { fg = colors.bg, bg = colors.fg })
--set_highlight('CursorLine', { bg = colors.bg2 })
--set_highlight('CursorLineNr', { fg = colors.str, bg = colors.bg })
--set_highlight('CursorColumn', { bg = colors.bg2 })
--set_highlight('ColorColumn', { bg = colors.bg2 })
--set_highlight('FoldColumn', { fg = colors.comment, bg = colors.bg2 })
--set_highlight('SignColumn', { fg = colors.comment, bg = colors.bg2 })
--set_highlight('LineNr', { fg = colors.fg2, bg = colors.bg2 })
--set_highlight('CursorLineNr', { fg = colors.fg, bg = colors.bg2 })
--set_highlight('VertSplit', { fg = colors.fg3, bg = colors.bg3 })
--set_highlight('MatchParen', { fg = colors.warning2, underline = true })
--set_highlight('StatusLine', { fg = colors.fg2, bg = colors.bg3, bold = true })
--set_highlight('Pmenu', { fg = colors.fg, bg = colors.bg2 })
--set_highlight('PmenuSel', { bg = colors.bg3 })
--set_highlight('IncSearch', { fg = colors.bg, bg = colors.keyword })
--set_highlight('Search', { underline = true })
--set_highlight('Directory', { fg = colors.const })
--set_highlight('Folded', { fg = colors.fg4, bg = colors.bg })
--set_highlight('WildMenu', { fg = colors.str, bg = colors.bg })
--set_highlight('Boolean', { fg = colors.const })
--set_highlight('Character', { fg = colors.const })
--set_highlight('Comment', { fg = colors.comment })
--set_highlight('Conditional', { fg = colors.keyword })
--set_highlight('Constant', { fg = colors.const })
--set_highlight('Todo', { bg = colors.bg })
--set_highlight('Define', { fg = colors.keyword })
--set_highlight('DiffAdd', { fg = '#fafafa', bg = '#123d0f', bold = true })
--set_highlight('DiffDelete', { bg = colors.bg2 })
--set_highlight('DiffChange', { fg = '#fafafa', bg = '#151b3c' })
--set_highlight('DiffText', { fg = '#ffffff', bg = '#ff0000', bold = true })
--set_highlight('ErrorMsg', { fg = colors.warning, bg = colors.bg2, bold = true })
--set_highlight('WarningMsg', { fg = colors.fg, bg = colors.warning2 })
--set_highlight('Float', { fg = colors.const })
--set_highlight('Function', { fg = colors.func })
--set_highlight('Identifier', { fg = colors.type, italic = true })
--set_highlight('Keyword', { fg = colors.keyword, bold = true })
--set_highlight('Label', { fg = colors.var })
--set_highlight('NonText', { fg = colors.bg4, bg = colors.bg2 })
--set_highlight('Number', { fg = colors.const })
--set_highlight('Operator', { fg = colors.keyword })
--set_highlight('PreProc', { fg = colors.keyword })
--set_highlight('Special', { fg = colors.fg })
--set_highlight('SpecialKey', { fg = colors.fg2, bg = colors.bg2 })
--set_highlight('Statement', { fg = colors.keyword })
--set_highlight('StorageClass', { fg = colors.type, italic = true })
--set_highlight('String', { fg = colors.str })
--set_highlight('Tag', { fg = colors.keyword })
--set_highlight('Title', { fg = colors.fg, bold = true })
--set_highlight('Todo', { fg = colors.fg2, underline = true, bold = true })
--set_highlight('Type', { fg = colors.type })
--set_highlight('Underlined', { underline = true })
--
--vim.g.terminal_color_0 = colors.bg
--vim.g.terminal_color_1 = colors.warning
--vim.g.terminal_color_2 = colors.keyword
--vim.g.terminal_color_3 = colors.bg4
--vim.g.terminal_color_4 = colors.func
--vim.g.terminal_color_5 = colors.builtin
--vim.g.terminal_color_6 = colors.fg3
--vim.g.terminal_color_7 = colors.str
--vim.g.terminal_color_8 = colors.bg2
--vim.g.terminal_color_9 = colors.warning2
--vim.g.terminal_color_10 = colors.fg2
--vim.g.terminal_color_11 = colors.var
--vim.g.terminal_color_12 = colors.type
--vim.g.terminal_color_13 = colors.const
--vim.g.terminal_color_14 = colors.fg4
--vim.g.terminal_color_15 = colors.comment
