return {
	"NvChad/nvim-colorizer.lua",
	event = "FileType",
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
		require("colorizer").setup({})
	end,
}
