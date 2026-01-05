M = {}

local function get_mason_package_path(package_name)
	return vim.fn.stdpath("data") .. "/mason/packages/" .. package_name
end

local mason_path = vim.fn.stdpath("data") .. "/mason/packages/"

M.config = {
	solidity_ls = {
		cmd = { "vscode-solidity-server", "--stdio" },
		filetypes = { "solidity" },
	},
	astro = {
		cmd = { "astro-ls", "--stdio" },
		-- cmd = { "astro-language-server", "--stdio" },
		filetypes = { "astro" },
		-- cmd = { "~/.local/share/nvim/mason/bin/astro-ls", "--stdio" }, -- 使用 astro-ls
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
		cmd = { vim.fn.stdpath("data") .. "/mason/bin/jdtls" },
	},
	pyright = {
		cmd = { "delance-langserver", "--stdio" },
		-- cmd = { vim.fn.stdpath("data") .. "/mason/bin/pyright-langserver", "--stdio" },
		-- cmd = { "pyright-langserver", "--stdio" },
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

	lua_ls = {
		-- cmd = { "lua-language-server" },
		-- cmd = { get_mason_package_path("lua-language-server") .. "/bin/lua-language-server" },
		-- cmd = { get_mason_package_path("lua-language-server") .. "/lua-language-server" },
		cmd = { vim.fn.stdpath("data") .. "/mason/bin/lua-language-server" },
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
	tinymist = {
		offset_encoding = "utf-8",
		cmd = { "tinymist" },
		single_file_support = true,
		root_dir = function()
			return vim.fn.getcwd()
		end,
		settings = {},
	},
	yamlls = {
		cmd = { vim.fn.stdpath("data") .. "/mason/bin/yaml-language-server", "--stdio" },
		filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
	},
	ts_ls = {
		cmd = { vim.fn.stdpath("data") .. "/mason/bin/typescript-language-server", "--stdio" },
		init_options = {
			plugins = {
				{
					name = "@vue/typescript-plugin",
					-- location = require("mason-registry").get_package("vue-language-server"):get_install_path()
					-- .. "/node_modules/@vue/language-server",
					-- location = get_mason_package_path("vue-language-server") .. "/node_modules/@vue/language-server",
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
					-- location = require("mason-registry").get_package("mdx-analyzer"):get_install_path()
					-- .. "/node_modules/@mdx/language-server",
					-- location = get_mason_package_path("mdx-analyzer") .. "/node_modules/@mdx/language-server",
					location = mason_path .. "mdx-analyzer" .. "/node_modules/@mdx/language-server",
					languages = { "mdx" },
				},
			},
		},
		filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
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
	nil_ls = {
		settings = {
			["nil"] = {
				nix = { flake = { autoArchive = true } },
			},
		},
	},
	omnisharp = {
		cmd = {
			"dotnet",
			-- require("mason-registry").get_package("omnisharp"):get_install_path() .. "/libexec/Omnisharp.dll",
			get_mason_package_path("omnisharp") .. "/libexec/Omnisharp.dll",
		},
		handlers = {
			["textDocument/definition"] = function(...)
				return require("omnisharp_extended").handler(...)
			end,
		},
		keys = {
			{
				"gd",
				function()
					require("omnisharp_extended").telescope_lsp_definitions()
				end,
				desc = "Goto Definition",
			},
		},
		enable_roslyn_analyzers = true,
		organize_imports_on_format = true,
		enable_import_completion = true,
	},
	hls = {
		root_dir = function()
			return vim.fn.getcwd()
		end,
		settings = {
			haskell = {
				plugin = {
					["semanticTokens"] = {
						globalOn = true,
					},
				},
			},
		},
	},
	verible = {
		cmd = { "verible-verilog-ls", "--rules=-explicit-parameter-storage-type" },
		root_dir = function()
			return vim.fn.getcwd()
		end,
	},
}

return M
