return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = { "RRethy/nvim-treesitter-textsubjects", "nvim-treesitter/nvim-treesitter-textobjects" },
	event = { "BufNewFile", "BufRead" },
	cmd = { "TSUpdate", "TSInstall", "TSInstallInfo" },
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.install").prefer_git = true
		require("nvim-treesitter.configs").setup({
			auto_install = true,
			highlight = {
				enable = true,
				disable = { "latex" },
				additional_vim_regex_highlighting = false,
			},
			ensure_installed = {
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
				-- "latex",
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
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					node_decremental = "<BS>",
					scope_incremental = "<TAB>",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["aa"] = { query = "@parameter.outer", desc = "a argument" },
						["ia"] = { query = "@parameter.inner", desc = "inner part of a argument" },
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
						["id"] = "@conditional.inner",
						["ad"] = "@conditional.outer",
						["ar"] = { query = "@return.outer", desc = "a return" },
						["ir"] = { query = "@return.outer", desc = "inner return" },
						-- ["al"] = { query = "@loop.outer", desc = "a loop" },
						-- ["il"] = { query = "@loop.inner", desc = "inner part of a loop" },
					},
					selection_modes = {
						["@parameter.outer"] = "v", -- charwise
						["@function.outer"] = "V", -- linewise
						["@class.outer"] = "<c-v>", -- blockwise
					},
					include_surrounding_whitespace = false,
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
						["]a"] = "@parameter.inner",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
						["[a"] = "@parameter.inner",
					},
				},
			},
			textsubjects = {
				enable = true,
				prev_selection = ",",
				keymaps = {
					["<CR>"] = "textsubjects-smart",
					[";"] = "textsubjects-container-outer",
					["i;"] = {
						"textsubjects-container-inner",
						desc = "Select inside containers (classes, functions, etc.)",
					},
				},
			},
		})
	end,
}
