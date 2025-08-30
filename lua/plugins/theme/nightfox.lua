return {
	"EdenEast/nightfox.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("nightfox").setup({
			options = {
				transparent = not vim.g.neovide,
				modules = { cmp = { enable = true } },
				styles = {
					comments = "italic",
					keywords = "bold",
					types = "italic,bold",
				},
			},
		})

		vim.cmd.colorscheme("nordfox")
		vim.g.lightline = { colorscheme = "nordfox" }
	end,
}
