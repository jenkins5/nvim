return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = "ConformInfo",
	keys = {
		{
			"<leader>F",
			function()
				require("conform").format({ lsp_format = "fallback" })
			end,
			desc = "Format Document",
			mode = { "n", "v" },
		},
	},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				cpp = { "clang_format" },
				go = { "goimports", "gofmt" },
				python = { "isort", "black" },
				-- python = { "ruff_fix", "ruff_format" },
				lua = { "stylua" },
				rust = { "rustfmt" },
				html = { "prettier" },
				astro = { "prettier" },
				java = { "google-java-format" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				markdown = { "prettier" },
				css = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				yaml = { "prettier" },
				typst = { "typstyle" },
				-- nix = { "nixfmt" },
				haskell = { "fourmolu" },
			},

			formatters = {
				clang_format = {
					command = "clang-format",
				},
				prettier = {
					prepend_args = {
						"--tab-width 2",
					},
				},
				["google-java-format"] = {
					-- command = vim.fn.stdpath("data") .. "/mason/bin/google-java-format",
					prepend_args = { "--aosp" }, -- 使用 4 空格缩进的 AOSP 风格
					timeout_ms = 10000,
				},
				--[[ isort = {
					command = vim.fn.stdpath("data") .. "/mason/bin/isort",
					timeout_ms = 5000,
				},
				black = {
					command = vim.fn.stdpath("data") .. "/mason/bin/black",
					timeout_ms = 5000,
				}, ]]
			},
		})
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		vim.o.formatprg = "v:lua.require'conform'.formatprg()"
	end,
}
