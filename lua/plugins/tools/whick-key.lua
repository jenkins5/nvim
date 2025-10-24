local custom = require("custom")
local opts = {
	show_help = true,
	win = { border = custom.border },
	plugins = { presets = { z = true } },
	delay = function(ctx)
		return ctx.plugin and 0 or 200
	end,
	defer = function(ctx)
		local defer_keys = { "`", "c", "d", "y", "g", "z" }
		local defer_modes = { "V", "<C-V>", "v" }

		for _, key in ipairs(defer_keys) do
			if ctx.keys == key then
				return true
			end
		end

		for _, mode in ipairs(defer_modes) do
			if ctx.mode == mode then
				return true
			end
		end

		return false
	end,
	replace = {
		desc = {
			{ "<Plug>%((.*)%)", "%1" },
			{ "^%+", "" },
			{ "<[cC]md>", "" },
			{ "<[cC][rR]>", "" },
			{ "<[sS]ilent>", "" },
			{ "^lua%s+", "" },
			{ "^call%s+", "" },
			{ "^:%s*", "" },
		},
	},
}

return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		require("which-key").setup(opts)
		require("which-key").add({
			{ "<leader>c", group = "Code Operations" },
			{ "<leader>s", group = "Chore" },
			{ "<leader>t", group = "Telescope" },
		})
	end,
}
