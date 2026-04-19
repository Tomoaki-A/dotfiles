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

-- nvim-treesitter main (新 API) では parsers / configs モジュールの
-- ほとんどの関数が削除されている。telescope 0.1.5 の previewers/utils は
-- 読み込み時に `local _, ts_parsers = pcall(require, 'nvim-treesitter.parsers')`
-- と旧 API 前提で参照をローカルに閉じ込めてしまうため、parsers テーブルに
-- 後から関数を生やしても参照が通らないケースがある。そこで telescope 側の
-- ts_highlighter / regex_highlighter を、vim.treesitter.start を直接呼ぶ
-- 実装に丸ごと差し替える。
do
	local ok, tu = pcall(require, "telescope.previewers.utils")
	if ok and type(tu) == "table" then
		tu.ts_highlighter = function(bufnr, ft)
			if not ft or ft == "" then
				return false
			end
			local lang = vim.treesitter.language.get_lang(ft) or ft
			local started = pcall(vim.treesitter.start, bufnr, lang)
			return started
		end
	end
end
