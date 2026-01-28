return {
	"folke/sidekick.nvim",
	event = { "LspAttach", "VeryLazy" },
	-- keys = {
	-- 	{
	-- 		"<tab>",
	-- 		function()
	-- 			if not require("sidekick").nes_jump_or_apply() then
	-- 				return "<tab>"
	-- 			end
	-- 		end,
	-- 		expr = true,
	-- 		desc = "Goto/Apply Next Edit Suggestion",
	-- 	},
	-- },
	keys = {
		{
			"<C-y>",
			function()
				require("sidekick").nes_jump_or_apply()
			end,
			mode = { "n", "i" },
			desc = "Apply Next Edit Suggestion",
		},
	},
	opts = {
		cli = { mux = { backend = "tmux", enabled = true } },
	},
}
