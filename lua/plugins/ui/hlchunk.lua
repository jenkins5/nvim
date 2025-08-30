return {
	"shellRaining/hlchunk.nvim",
	event = { "BufNewFile", "BufReadPre" },
	config = function()
		require("hlchunk").setup({
			chunk = {
				enable = true,
				use_treesitter = true,
				style = {
					{ fg = "#806d9c" },
				},
			},
			indent = {
				enable = true,
				use_treesitter = false,
				chars = {
					"│",
				},
				style = {
					vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
				},
			},
			line_num = {
				enable = false,
				use_treesitter = true,
				style = "#00ffff",
			},
			blank = {
				enable = false,
			},
		})

		-- 为不同文件类型设置缩进
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "java",
			callback = function()
				vim.opt_local.tabstop = 4
				vim.opt_local.shiftwidth = 4
				vim.opt_local.expandtab = true
				vim.opt_local.softtabstop = 4
			end,
		})
	end,
}
