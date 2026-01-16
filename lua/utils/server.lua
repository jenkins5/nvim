local custom = require("custom")
local config = require("utils.lspconfig").config
local M = { server = {} }

M.lsp = {
	"astro",
	"clangd",
	"gopls",
	"html",
	"jdtls",
	"jsonls",
	"lua_ls",
	"marksman",
	"mdx_analyzer",
	"pyright",
	"ruff",
	"solidity_ls",
	"tailwindcss",
	"taplo",
	"tinymist",
	"ts_ls",
	-- "volar",
	"vue_ls",
	"yamlls",
}

M.tools = {
	-- formatter
	"black",
	"clang-format",
	"gofmt",
	"goimports",
	"google-java-format",
	"isort",
	"prettier",
	"ruff",
	"rustfmt",
	"stylua",
	-- "typstyle",

	-- dap
	"codelldb",
	"debugpy",
	"delve",
	"java-debug-adapter",
	"java-test",
}

local system = {
	-- lsp
	"hls",
	"nixd",
	-- "clangd",
	-- "pyright",
}

custom.register(M.server, M.lsp, config)
custom.register(M.server, system, config)

return M
