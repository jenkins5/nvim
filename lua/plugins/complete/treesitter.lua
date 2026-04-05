local ensure_installed = {
	"astro",
	"bash",
	"comment",
	"cpp",
	"css",
	"fish",
	"go",
	"gomod",
	"gosum",
	"html",
	"javascript",
	"lua",
	"markdown",
	"markdown_inline",
	"nix",
	"python",
	"regex",
	"rust",
	"typescript",
	"typst",
	"vim",
	"vimdoc",
	"vue",
	"yaml",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		event = { "BufNewFile", "BufRead" },
		cmd = { "TSUpdate", "TSInstall" },
		build = ":TSUpdate",
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local ft = vim.bo[args.buf].filetype
					if ft == "latex" then
						return
					end
					pcall(vim.treesitter.start, args.buf)

					-- skip incremental selection for special buffers
					local skip_ft = {
						"TelescopePrompt",
						"TelescopeResults",
						"qf",
						"help",
						"neogit",
						"toggleterm",
						"lazy",
						"mason",
						"notify",
						"noice",
						"codecompanion",
					}
					if vim.tbl_contains(skip_ft, ft) or vim.bo[args.buf].buftype ~= "" then
						return
					end

					-- incremental selection
					local node = nil
					vim.keymap.set("n", "<CR>", function()
						node = vim.treesitter.get_node()
						if not node then
							return
						end
						local sr, sc, er, ec = node:range()
						vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
						vim.cmd("normal! v")
						vim.api.nvim_win_set_cursor(0, { er + 1, ec > 0 and ec - 1 or 0 })
					end, { buffer = args.buf, desc = "init treesitter selection" })

					vim.keymap.set("x", "<CR>", function()
						if node then
							node = node:parent()
						end
						if not node then
							return
						end
						local sr, sc, er, ec = node:range()
						vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
						vim.cmd("normal! o")
						vim.api.nvim_win_set_cursor(0, { er + 1, ec > 0 and ec - 1 or 0 })
					end, { buffer = args.buf, desc = "expand treesitter selection" })

					vim.keymap.set("x", "<BS>", function()
						if node then
							local child = node:named_child(0)
							if child then
								node = child
							end
						end
						if not node then
							return
						end
						local sr, sc, er, ec = node:range()
						vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
						vim.cmd("normal! o")
						vim.api.nvim_win_set_cursor(0, { er + 1, ec > 0 and ec - 1 or 0 })
					end, { buffer = args.buf, desc = "shrink treesitter selection" })
				end,
			})
		end,
		config = function()
			-- ensure brew tree-sitter-cli is found before volta shim (macOS only)
			if vim.fn.isdirectory("/opt/homebrew/bin") == 1 then
				vim.env.PATH = "/opt/homebrew/bin:" .. vim.env.PATH
			end

			local installed = require("nvim-treesitter.config").get_installed()
			local to_install = vim.iter(ensure_installed)
				:filter(function(parser)
					return not vim.tbl_contains(installed, parser)
				end)
				:totable()
			if #to_install > 0 then
				require("nvim-treesitter").install(to_install)
			end
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		event = { "BufNewFile", "BufRead" },
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
					selection_modes = {
						["@parameter.outer"] = "v",
						["@function.outer"] = "V",
						["@class.outer"] = "<c-v>",
					},
					include_surrounding_whitespace = false,
				},
				move = {
					set_jumps = true,
				},
			})

			local select_fn = function(query)
				return function()
					require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
				end
			end

			local goto_next = function(query)
				return function()
					require("nvim-treesitter-textobjects.move").goto_next_start(query, "textobjects")
				end
			end

			local goto_prev = function(query)
				return function()
					require("nvim-treesitter-textobjects.move").goto_previous_start(query, "textobjects")
				end
			end

			local xo = { "x", "o" }
			local nxo = { "n", "x", "o" }

			-- select
			vim.keymap.set(xo, "aa", select_fn("@parameter.outer"), { desc = "a argument" })
			vim.keymap.set(xo, "ia", select_fn("@parameter.inner"), { desc = "inner argument" })
			vim.keymap.set(xo, "af", select_fn("@function.outer"), { desc = "a function" })
			vim.keymap.set(xo, "if", select_fn("@function.inner"), { desc = "inner function" })
			vim.keymap.set(xo, "ac", select_fn("@class.outer"), { desc = "a class" })
			vim.keymap.set(xo, "ic", select_fn("@class.inner"), { desc = "inner class" })
			vim.keymap.set(xo, "ad", select_fn("@conditional.outer"), { desc = "a conditional" })
			vim.keymap.set(xo, "id", select_fn("@conditional.inner"), { desc = "inner conditional" })
			vim.keymap.set(xo, "ar", select_fn("@return.outer"), { desc = "a return" })
			vim.keymap.set(xo, "ir", select_fn("@return.outer"), { desc = "inner return" })

			-- move
			vim.keymap.set(nxo, "]f", goto_next("@function.outer"), { desc = "next function" })
			vim.keymap.set(nxo, "]c", goto_next("@class.outer"), { desc = "next class" })
			vim.keymap.set(nxo, "]a", goto_next("@parameter.inner"), { desc = "next argument" })
			vim.keymap.set(nxo, "[f", goto_prev("@function.outer"), { desc = "prev function" })
			vim.keymap.set(nxo, "[c", goto_prev("@class.outer"), { desc = "prev class" })
			vim.keymap.set(nxo, "[a", goto_prev("@parameter.inner"), { desc = "prev argument" })
		end,
	},
}
