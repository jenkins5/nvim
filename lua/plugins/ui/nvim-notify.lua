---@diagnostic disable: duplicate-set-field
---@type LazyPluginSpec
return {
	"rcarriga/nvim-notify",
	lazy = true,
	config = function()
		require("notify").setup({
			stages = "fade",
			render = "wrapped-compact",
			background_colour = "#000000",
			on_open = function(win)
				vim.api.nvim_win_set_config(win, { focusable = false })
			end,
		})
	end,
}
