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

-- gsで単語のハイライトをtoggleする
function SearchWord()
    if vim.v.hlsearch == 1 then
      vim.cmd('nohlsearch')
      return
    end
    local word = vim.fn.expand('<cword>')
    vim.fn.setreg('/', '\\<' .. word .. '\\>')
    vim.opt.hlsearch = true
end

vim.api.nvim_create_user_command('SearchWord', SearchWord, {})
vim.api.nvim_set_keymap('n', 'gs', ':SearchWord<CR>', { noremap = true, silent = true })
