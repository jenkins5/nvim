return {
	{
		"williamboman/mason.nvim",
		keys = {
			{ "<leader>m", "<cmd>Mason<CR>", desc = "open Mason" },
		},
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonUpdate",
		},
		config = function()
			require("mason").setup({
				---@since 1.0.0
				-- Where Mason should put its bin location in your PATH. Can be one of:
				-- - "prepend" (default, Mason's bin location is put first in PATH)
				-- - "append" (Mason's bin location is put at the end of PATH)
				---@type '"prepend"' | '"append"' | '"skip"'
				PATH = "prepend",

				registries = {
					"github:mason-org/mason-registry",
				},

				ui = {
					border = "rounded",
					icons = {
						package_installed = "",
						package_pending = "",
						package_uninstalled = "",
					},
					keymaps = {
						toggle_package_expand = "<CR>",
						install_package = "i",
						update_package = "s",
						check_package_version = "c",
						update_all_packages = "S",
						check_outdated_packages = "C",
						uninstall_package = "X",
						cancel_installation = "<C-c>",
						apply_language_filter = "<C-f>",
						toggle_package_install_log = "<CR>",
						toggle_help = "g?",
						up = "u",
						down = "e",
					},
				},
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		cmd = {
			"MasonToolsInstall",
			"MasonToolsInstallSync",
			"MasonToolsUpdate",
			"MasonToolsUpdateSync",
			"MasonToolsClean",
		},
		config = function()
			local installed = require("utils.server").tools

			for _, sv in ipairs(require("utils.server").lsp) do
				table.insert(installed, sv)
			end

			require("mason-tool-installer").setup({
				ensure_installed = installed,
			})
		end,
	},
}
