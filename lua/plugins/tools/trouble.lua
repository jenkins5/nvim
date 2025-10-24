return {
	"folke/trouble.nvim",
	cmd = { "Trouble", "TroubleToggle" },
	opts = { use_diagnostic_signs = true },
	-- stylua: ignore
	keys = {
		-- { "<leader>q", "<Cmd>TroubleToggle<CR>", desc = "Trouble" },
		{ '<leader>xx', function() require('trouble').toggle('diagnostics') end, desc = 'Document Diagnostics (Trouble)' },
		-- { '<leader>xx', function() require('trouble').toggle('document_diagnostics') end, desc = 'Document Diagnostics (Trouble)' },
		{ '<leader>xX', function() require('trouble').toggle('workspace_diagnostics') end, desc = 'Workspace Diagnostics (Trouble)' },
		{ '<leader>xL', function() require('trouble').toggle('loclist') end, desc = 'Location List (Trouble)' },
		{ '<leader>xQ', function() require('trouble').toggle('quickfix') end, desc = 'Quickfix List (Trouble)' },
		{ 'gR', function() require('trouble').open('lsp_references') end, desc = 'LSP References (Trouble)' },
		{
			'[q',
			function()
				if require('trouble').is_open() then
					require('trouble').previous({ skip_groups = true, jump = true })
				else
					vim.cmd.cprev()
				end
			end,
			desc = 'Previous Trouble/Quickfix Item',
		},
		{
			']q',
			function()
				if require('trouble').is_open() then
					require('trouble').next({ skip_groups = true, jump = true })
				else
					vim.cmd.cnext()
				end
			end,
			desc = 'Next Trouble/Quickfix Item',
		},
	},
}

