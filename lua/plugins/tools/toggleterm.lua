local custom = require("custom")

return {
	"akinsho/toggleterm.nvim",
	cmd = { "ToggleTerm", "TermExec" },
	opts = {
		size = function(term)
			if term.direction == "horizontal" then
				return 16
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			end
		end,

		on_create = function(t)
			local bufnr = t.bufnr
			vim.keymap.set("t", "<Esc>", "<C-\\><C-N>", { buffer = bufnr })
		end,
		---@diagnostic disable-next-line: undefined-field
		shell = vim.uv.os_uname().sysname == "Darwin" and "zsh" or "pwsh -nologo",
		shade_terminals = false,
		float_opts = {
			border = custom.border,
		},
	},
	keys = function()
		local float_opts = { border = custom.border }
		local lazygit, yazi, coderunner

		local function get_lazygit()
			if not lazygit then
				lazygit = require("toggleterm.terminal").Terminal:new({
					cmd = "lazygit",
					hidden = true,
					direction = "float",
					float_opts = float_opts,
					on_create = function(t)
						vim.keymap.set("t", "<Esc>", "<Esc>", { buffer = t.bufnr })
					end,
				})
			end
			return lazygit
		end

		local function get_yazi()
			if not yazi then
				yazi = require("toggleterm.terminal").Terminal:new({
					cmd = "yazi",
					hidden = true,
					direction = "float",
					float_opts = float_opts,
					on_create = function(t)
						vim.keymap.set("t", "<Esc>", "<Esc>", { buffer = t.bufnr })
					end,
				})
			end
			return yazi
		end

		local function get_coderunner()
			if not coderunner then
				coderunner = require("toggleterm.terminal").Terminal:new({
					cmd = vim.o.shell,
					hidden = true,
					direction = "float",
					float_opts = float_opts,
					close_on_exit = false,
					on_create = function(t)
						vim.keymap.set("t", "<Esc>", "<C-\\><C-N>", { buffer = t.bufnr })
					end,
				})
			end
			return coderunner
		end

		return {
			{
				"<C-\\>",
				"<cmd>1ToggleTerm direction=horizontal<cr>",
				mode = { "n", "t" },
				desc = "Toggle Horizontal Terminal",
			},
			{ "`", "<cmd>2ToggleTerm direction=vertical<cr>", mode = { "n", "t" }, desc = "Toggle Vertical Terminal" },

			{ "<leader>tt", "<cmd>TermSelect<cr>", desc = "Select Terminal" },

			-- External programs
			{
				"<leader>gl",
				function()
					get_lazygit():toggle()
				end,
				desc = "LazyGit",
			},
			{
				"<leader>gf",
				function()
					get_yazi():toggle()
				end,
				mode = { "n", "t" },
				desc = "Yazi",
			},
			{
				"<leader>cr",
				function()
					get_coderunner():toggle()
				end,
				mode = { "n", "t" },
				desc = "Code Runner Terminal",
			},
		}
	end,
}
