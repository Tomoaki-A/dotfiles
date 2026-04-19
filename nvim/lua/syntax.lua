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
-- ほとんどの関数が削除されている。telescope 0.1.5 など旧 API 前提の
-- プラグインが落ちないよう、最低限の関数を vim.treesitter のビルトイン
-- API へ橋渡しするシムを用意する。
local parsers_ok, parsers_mod = pcall(require, "nvim-treesitter.parsers")
if parsers_ok and type(parsers_mod) == "table" then
	if not parsers_mod.ft_to_lang then
		parsers_mod.ft_to_lang = function(ft)
			return vim.treesitter.language.get_lang(ft) or ft
		end
	end
	if not parsers_mod.get_parser then
		parsers_mod.get_parser = function(bufnr, lang)
			local ok, parser = pcall(vim.treesitter.get_parser, bufnr or 0, lang)
			if ok then
				return parser
			end
		end
	end
	if not parsers_mod.has_parser then
		parsers_mod.has_parser = function(lang)
			if not lang or lang == "" then
				return false
			end
			local ok, has = pcall(vim.treesitter.language.add, lang)
			return ok and has or false
		end
	end
end

local configs_ok, configs_mod = pcall(require, "nvim-treesitter.configs")
if configs_ok and type(configs_mod) == "table" then
	if not configs_mod.is_enabled then
		configs_mod.is_enabled = function()
			return true
		end
	end
	if not configs_mod.get_module then
		configs_mod.get_module = function()
			return {}
		end
	end
end
