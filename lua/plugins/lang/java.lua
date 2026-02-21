--[[ return {
	"nvim-java/nvim-java",
	dependencies = "neovim/nvim-lspconfig",
	ft = "java",
	config = function()
		require("java").setup()
		require("lspconfig").jdtls.setup({})
	end,
} ]]

return {
  "nvim-java/nvim-java",
  ft = "java",
  dependencies = { "neovim/nvim-lspconfig" },
  config = function()
    require("java").setup()
    vim.lsp.enable("jdtls")
  end,
}
