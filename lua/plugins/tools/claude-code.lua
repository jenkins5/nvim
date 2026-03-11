return {
	"greggh/claude-code.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	cmd = { "ClaudeCode", "ClaudeCodeContinue", "ClaudeCodeResume" },
	keys = {
		{ "<leader>cc", "<cmd>ClaudeCode<CR>", desc = "Claude Code (Toggle)" },
		{ "<leader>cr", "<cmd>ClaudeCodeContinue<CR>", desc = "Claude Code (Continue Last)" },
		{ "<leader>cs", "<cmd>ClaudeCodeResume<CR>", desc = "Claude Code (Select Session)" },
	},
	config = function()
		require("claude-code").setup({
			window = {
				position = "float",
				float = {
					width = "80%",
					height = "80%",
					row = "center",
					col = "center",
					relative = "editor",
					border = "rounded",
				},
			},
		})
	end,
}
