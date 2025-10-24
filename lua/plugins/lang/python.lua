return {
	"linux-cultist/venv-selector.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
	},
	ft = "python", -- Load when opening Python files
	keys = {
		{ "<leader>vs", "<cmd>VenvSelect<cr>", desc = "select python venv" }, -- Open picker on keymap
	},
	opts = { -- this can be an empty lua table - just showing below for clarity.
		search = {}, -- if you add your own searches, they go here.
		options = {}, -- if you add plugin options, they go here.
	},
}
