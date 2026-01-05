return {
	"folke/todo-comments.nvim",
	event = { "BufNewFile", "BufReadPost" },
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("todo-comments").setup({
			signs = true,
		})
	end,
}
