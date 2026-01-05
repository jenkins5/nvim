local custom = require("custom")
local config = require("utils.lspconfig").config
M = { server = {} }

M.lsp = {
	"html",
	-- "volar",
	"astro",
	"clangd",
	"ts_ls",
	"gopls",
	"lua_ls",
	"jdtls",
	"jsonls",
	"yamlls",
	"taplo",
	"marksman",
	"tinymist",
	"tailwindcss",
	"mdx_analyzer",
	"solidity_ls",
	"pyright",
	"vue_ls",
}

M.tools = {
	-- formatter
	"black",
	"google-java-format",
	"isort",
	"prettier",
	"stylua",
	"ruff",
	-- "typstyle",
	"clang-format",

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

local windows = {
	"verible", -- Verilog
	"omnisharp", -- C#
}

if vim.uv.os_uname().sysname == "Darwin" then
	for _, i in ipairs(windows) do
		table.insert(M.lsp, i)
	end
end

custom.register(M.server, M.lsp, config)
custom.register(M.server, system, config)

return M
