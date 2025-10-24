---@type LazyPluginSpec

return {
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		lazy = false, -- This plugin is already lazy
		ft = { "rust" },
		config = function()
			vim.g.rustaceanvim = {
				tools = {
					float_win_config = {
						border = "rounded",
					},
				},
			}
		end,
	},

	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		tag = "stable",
		config = function()
			---@diagnostic disable-next-line: missing-parameter
			require("crates").setup()
		end,
	},
}
