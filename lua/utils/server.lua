local custom = require("custom")
local config = require("utils.lspconfig").config
local M = { server = {} }

M.lsp = {
	"astro",
	"basedpyright",
	"buf_ls",
	"clangd",
	"gopls",
	"html",
	"jdtls",
	-- "jedi_language_server",
	"jsonls",
	"lua_ls",
	"marksman",
	"mdx_analyzer",
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
	"buf",
	"clang-format",
	"gofmt",
	"goimports",
	"google-java-format",
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
	"sourcekit",
}

custom.register(M.server, M.lsp, config)
custom.register(M.server, system, config)

return M
