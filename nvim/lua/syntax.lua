-- nvim-treesitter main (新 API) では configs.setup ではなく install() で
-- パーサーを導入し、ハイライトは vim.treesitter.start() を呼ぶ方式に変わった。
local parsers = {
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
	"prisma",
	"sql",
	"yaml",
	-- LSP hover やドキュメント表示で markdown ハイライトを使うため必須
	"markdown",
	"markdown_inline",
}

require("nvim-treesitter").install(parsers)

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
})
