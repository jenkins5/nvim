return {
	"nvim-lualine/lualine.nvim",
	event = { "BufNewFile", "BufReadPre" },
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"AndreM222/copilot-lualine",
	},
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				globalstatus = true,
			},
			sections = {
				lualine_c = {
					"filename",
					{
						function()
							local clients = vim.lsp.get_clients()
							if #clients == 0 then
								return ""
							end

							local client_names = {}
							for _, client in ipairs(clients) do
								table.insert(client_names, client.name)
							end

							return "LSP [" .. table.concat(client_names, ", ") .. "]"
						end,
						cond = function()
							return #vim.lsp.get_clients() > 0
						end,
					},
				},
				lualine_x = {
					{
						"copilot",
						symbols = {
							status = {
								icons = { unknown = " " },
							},
						},
					},
					"encoding",
					"fileformat",
					"filetype",
				}, -- I added copilot here
			},
		})
	end,
}
