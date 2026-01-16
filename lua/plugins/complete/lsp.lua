local config = function()
	local custom = require("custom")
	-- local lspconfig = require("lspconfig")
	local server = require("utils.server").server

	require("lspconfig.ui.windows").default_options.border = "rounded"
	local lsp_keymap = function(bufnr)
		-- lsp-builtin
		local set = function(keys, func, indesc)
			vim.keymap.set("n", keys, func, { buffer = bufnr, desc = indesc })
		end
		-- set("gr", "<cmd>FzfLua lsp_references<CR>", "[R]eferences")
		set("gr", require("telescope.builtin").lsp_references, "[R]eferences")
		-- set("gi", "<cmd>FzfLua lsp_implementations<CR>", "[I]mplementations")
		-- set("gi", vim.lsp.buf.implementation, "implementation")
		set("gi", require("telescope.builtin").lsp_implementations, "implementation")
		set("gk", vim.lsp.buf.signature_help, "LSP Signature help")
		-- set("gD", "<cmd>FzfLua lsp_document_symbols<CR>", "[D]oc symbols")
		-- set("gD", vim.lsp.buf.declaration, "declaration")
		set("gD", require("telescope.builtin").lsp_document_symbols, "[D]oc symbols")
		-- set("gd", "<cmd>lua require('fzf-lua').lsp_definitions{ jump1 = true }<CR>", "definition")
		-- set("gd", vim.lsp.buf.definition, "definition")
		set("gd", require("telescope.builtin").lsp_definitions, "definition")
		set("<leader>ca", require("fastaction").code_action, "[C]ode [A]ction")
		set("<leader>cn", vim.lsp.buf.rename, "[C]ode Item Re[N]ame")
		set("<leader>ct", vim.lsp.buf.type_definition, "[C]ode [T]ype definition")
		set("<leader>cd", vim.diagnostic.open_float, "[C]ode [D]iagnostic")
	end

	vim.diagnostic.config({
		-- virtual_text = { spacing = 4 },
		-- virtual_lines = { current_line = true },
		virtual_text = false,
		jump = { float = true },
		float = {
			border = custom.border,
			severity_sort = true,
			source = "if_many",
		},
		severity_sort = true,
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = custom.icons.diagnostic.Error,
				[vim.diagnostic.severity.WARN] = custom.icons.diagnostic.Warning,
				[vim.diagnostic.severity.HINT] = custom.icons.diagnostic.Hint,
				[vim.diagnostic.severity.INFO] = custom.icons.diagnostic.Information,
			},
		},
	})

	-- lspconfig
	local lsp_list = {}
	for lsp, cfg in vim.iter(server) do
		vim.lsp.config[lsp] = cfg
		table.insert(lsp_list, lsp)
	end

	vim.lsp.enable(lsp_list)

	-- automatically sign up lsp
	vim.api.nvim_create_autocmd("LspAttach", {
		desc = "General LSP Attach",
		callback = function(args)
			-- buf keymap
			lsp_keymap(args.buf)

			-- inlay hints
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			--[[ if client and client.server_capabilities.inlayHintProvider then
				vim.lsp.inlay_hint.enable(true)
			end ]]
			if client then
				if client:supports_method("textDocument/inlayHint") then
					vim.lsp.inlay_hint.enable(true)
				end
				if vim.fn.has("nvim-0.12") == 1 and client:supports_method("textDocument/documentColor") then
					vim.lsp.document_color.enable(true, args.buf, { style = "virtual" })
				end
			end
		end,
	})

	--[[ if vim.version().prerelease == "dev" then
		vim.keymap.del("n", "gri")
		vim.keymap.del("n", "gra")
		vim.keymap.del("n", "grn")
		vim.keymap.del("n", "grr")
		vim.api.nvim_command("LspStart")
	end ]]
	if vim.fn.has("nvim-0.11") == 1 then
		vim.keymap.del("n", "gri")
		vim.keymap.del("n", "gra")
		vim.keymap.del("n", "grn")
		vim.keymap.del("n", "grr")
		vim.keymap.del("n", "grt")
	end
end

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		cmd = "LspInfo",
		config = config,
	},
	{
		"Chaitanyabsprip/fastaction.nvim",
		event = "LspAttach",
		opts = {},
	},
	{
		"kosayoda/nvim-lightbulb",
		event = "LspAttach",
		opts = {
			autocmd = { enabled = true },
		},
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "LspAttach",
		opts = {
			options = {
				use_icons_from_diagnostic = true,
				multilines = {
					enabled = true,
					always_show = true,
				},
			},
		},
	},
}
