return {
	"NvChad/nvim-colorizer.lua",
	ft = {
		"html",
		"css",
		"javascript",
		"typescript",
		"javascriptreact",
		"typescriptreact",
		"lua",
		"yaml",
		"fish",
	},
	config = function()
		require("colorizer").setup({
			options = {
				parsers = {
					css = true,
				},
				display = {
					mode = "background",
				},
			},
		})
	end,
}
