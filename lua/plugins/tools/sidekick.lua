return {
	"folke/sidekick.nvim",
	event = { "LspAttach", "VeryLazy" },
	keys = {
		{
			"<tab>",
			function()
				if not require("sidekick").nes_jump_or_apply() then
					return "<tab>"
				end
			end,
			expr = true,
			desc = "Goto/Apply Next Edit Suggestion",
		},
		--[[ {
			"<leader>aa",
			function()
				require("sidekick.cli").toggle()
			end,
			desc = "Sidekick Toggle CLI",
		}, ]]
	},
	opts = {
		cli = { mux = { backend = "tmux", enabled = true } },
	},
}
