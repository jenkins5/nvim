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
				astro = { "prettier" },
				cpp = { "clang_format" },
				css = { "prettier" },
				go = { "goimports", "gofmt" },
				-- nix = { "nixfmt" },
				html = { "prettier" },
				java = { "google-java-format" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				lua = { "stylua" },
				markdown = { "prettier" },
				-- python = { "isort", "black" },
				python = { "ruff_organize_imports", "ruff_format" },
				rust = { "rustfmt" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				typst = { "typstyle" },
				yaml = { "prettier" },
			},

			formatters = {
				clang_format = {
					command = "clang-format",
				},
				prettier = {
					prepend_args = {
						"--config-precedence prefer-file",
						"--vue-indent-script-and-style",
						"--experimental-ternaries",
						"--bracket-same-line",
					},
				},
				["google-java-format"] = {
					prepend_args = { "--aosp" }, -- Use AOSP style 4 space indent
				},
			},
		})
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		vim.o.formatprg = "v:lua.require'conform'.formatprg()"
	end,
}
