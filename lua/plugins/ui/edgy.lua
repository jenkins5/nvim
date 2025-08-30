---@diagnostic disable: unused-local
---@type LazyPluginSpec

return {
	"folke/edgy.nvim",
	enabled = true,
	event = { "CursorHold", "CursorHoldI", "BufNewFile", "BufReadPre" },
	opts = {
		animate = { enabled = false },
		bottom = {
			"Trouble",
			{
				ft = "Trouble",
				size = { height = 20 },
			},
			{ ft = "qf", title = "QuickFix" },
			{
				ft = "help",
				size = { height = 20 },
				-- only show help buffers
				filter = function(buf)
					return vim.bo[buf].buftype == "help"
				end,
			},
			{
				ft = "noice",
				size = { height = 0.4 },
				filter = function(buf, win)
					return vim.api.nvim_win_get_config(win).relative == ""
				end,
			},
		},
		left = {
			{ ft = "Mundo", size = { width = 0.25 } },
			{ ft = "MundoDiff", size = { width = 0.25 } },
		},
		right = {
			{
				ft = "Outline",
				pinned = true,
				open = "SymbolsOutlineOpen",
				size = { width = 35 },
			},
		},
		exit_when_last = true,
	},
}
