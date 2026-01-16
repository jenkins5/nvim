local M = {}

local mason_path = vim.fn.stdpath("data") .. "/mason/packages/"

M.config = {
	astro = {
		cmd = { "astro-ls", "--stdio" },
		filetypes = { "astro" },
		settings = {
			astro = {
				["content-intellisense"] = true,
			},
		},
	},
	clangd = {
		filetypes = { "cpp", "c" },
		cmd = {
			"clangd",
			"--clang-tidy",
			"--completion-style=detailed",
			"--header-insertion=iwyu",
			"--offset-encoding=utf-16",
			"--function-arg-placeholders=0",
		},
		init_options = {
			fallbackFlags = {
				"-std=c++2b",
				"-xc++",
				"-Wall",
				"-Wno-unused-variable",
				"-Wno-vla-cxx-extension",
				"-Wno-unknown-attributes  ",
				"-Wno-unused-but-set-variable ",
				"-fsyntax-only",
				"-static-libgcc",
				"-l stdc++",
			},
		},
	},
	gopls = {
		cmd = { "gopls" },
		settings = {
			gopls = {
				completeUnimported = true,
				usePlaceholders = true,
				analyses = {
					unusedparams = true,
				},
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
			},
		},
	},
	jdtls = {
		cmd = { "jdtls" },
	},
	lua_ls = {
		cmd = { "lua-language-server" },
		settings = {
			Lua = {
				hint = {
					enable = true,
					arrIndex = "Enable",
					setType = true,
				},
				diagnostics = {
					disable = { "missing-fields", "incomplete-signature-doc" },
				},
			},
		},
	},
	nil_ls = {
		settings = {
			["nil"] = {
				nix = { flake = { autoArchive = true } },
			},
		},
	},
	pyright = {
		cmd = { "delance-langserver", "--stdio" },
		settings = {
			python = {
				-- disableOrganizeImports = true,
				pythonPath = vim.fn.exepath("python"),
				-- pythonPath = vim.fn.getcwd() .. "/venv/bin/python",
				-- pythonPath = vim.fn.exepath("python"),
				analysis = {
					-- venvPath = vim.fn.getcwd(),
					extraPaths = { vim.fn.getcwd() },
					-- venv = "venv",
					-- extraPaths = { vim.fn.getcwd() },
					-- ignore = { "*" },
					-- autoSearchPaths = true,
					-- useLibraryCodeForTypes = true,
					-- typeCheckingMode = "basic",
					inlayHints = {
						callArgumentNames = "partial",
						functionReturnTypes = true,
						pytestParameters = true,
						variableTypes = true,
					},
				},
			},
		},
	},
	ruff = {
		cmd = { "ruff", "server" },
		filetypes = { "python" },
		on_attach = function(client)
			client.server_capabilities.hoverProvider = false
		end,
	},
	solidity_ls = {
		cmd = { "vscode-solidity-server", "--stdio" },
		filetypes = { "solidity" },
	},
	tailwindcss = {
		filetypes = {
			"html",
			"css",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"astro",
		},
	},
	tinymist = {
		offset_encoding = "utf-8",
		cmd = { "tinymist" },
		single_file_support = true,
		root_dir = function()
			return vim.fn.getcwd()
		end,
		settings = {},
	},
	ts_ls = {
		cmd = { "typescript-language-server", "--stdio" },
		init_options = {
			plugins = {
				{
					name = "@vue/typescript-plugin",
					location = mason_path .. "vue-language-server" .. "/node_modules/@vue/language-server",
					languages = { "vue" },
				},
				-- {
				-- 	name = "@astrojs/ts-plugin",
				-- 	location = require("mason-registry").get_package("astro-language-server"):get_install_path()
				-- 		.. "/node_modules/@astro/ts-plugin",
				-- 	-- enableForWorkspaceTypeScriptVersions = true,
				-- 	languages = { "astro" },
				-- },
				{
					name = "@mdxjs/typescript-plugin",
					location = mason_path .. "mdx-analyzer" .. "/node_modules/@mdx/language-server",
					languages = { "mdx" },
				},
			},
		},
		filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
	},
	yamlls = {
		cmd = { "yaml-language-server", "--stdio" },
		filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
	},
}

return M
