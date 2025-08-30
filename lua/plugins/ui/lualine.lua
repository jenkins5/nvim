return {
	"nvim-lualine/lualine.nvim",
	event = { "BufNewFile", "BufReadPre" },
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"arkav/lualine-lsp-progress",
	},
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				globalstatus = true,
			},
			sections = {
				lualine_c = {
					"filename",
					"lsp_progress",
				},
			},
		})
	end,
}
