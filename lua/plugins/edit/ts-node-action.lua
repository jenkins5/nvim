return {
	"ckolkey/ts-node-action",
	dependencies = { "nvim-treesitter" },
	cmd = { "NodeAction", "NodeActionDebug" },
	opts = {},
	keys = { { "<C-t>", "<cmd>NodeAction<cr>", mode = "n", desc = "Node action" } },
}
