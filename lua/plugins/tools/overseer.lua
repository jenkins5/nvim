return {
	"stevearc/overseer.nvim",
	cmd = {
		"OverseerRun",
		"OverseerToggle",
		"OverseerTaskAction",
		"OverseerRestartLast",
	},
	keys = {
		{ "<leader>rr", "<cmd>OverseerRun<cr>", desc = "Run Task" },
		{ "<leader>rl", "<cmd>OverseerToggle<cr>", desc = "Task List" },
		{ "<leader>ra", "<cmd>OverseerTaskAction<cr>", desc = "Task Action" },
		{ "<leader>rs", "<cmd>OverseerRestartLast<cr>", desc = "Restart Last Task" },
	},
	opts = {
		strategy = "toggleterm",
		templates = { "builtin" },
		task_list = {
			direction = "bottom",
			default_detail = 1,
			bindings = {
				["<C-c>"] = "<cmd>OverseerQuickAction stop<cr>",
				["r"] = "<cmd>OverseerQuickAction restart<cr>",
			},
		},
	},
}
