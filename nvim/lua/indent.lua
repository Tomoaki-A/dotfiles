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
