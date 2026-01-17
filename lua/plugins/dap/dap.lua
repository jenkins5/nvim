vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticInfo" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "Constant" })
vim.fn.sign_define("DapBreakpointRejected", { text = "" })

local function get_mason_path(package_name)
	return vim.fn.stdpath("data") .. "/mason/packages/" .. package_name
end

return {
	"mfussenegger/nvim-dap",
	ft = { "cpp", "go", "python" },
	specs = { "nvim-neotest/nvim-nio" },
	dependencies = { "rcarriga/nvim-dap-ui", "theHamsta/nvim-dap-virtual-text" },
	config = function()
		local dap = require("dap")
		dap.adapters.codelldb = {
			type = "executable",
			command = "codelldb",
		}
		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					vim.cmd("cd %:h")
					vim.cmd("silent w !g++ %:p:. -g -std=c++23 -o %:p:.:h/bin/%:t:r")
					local file_name = vim.fn.bufname(vim.api.nvim_get_current_buf())
					local file_name_without_path = vim.fn.fnamemodify(file_name, ":t")
					local file_directory = vim.fn.expand("%:p:h")
					if file_name_without_path ~= 0 then
						return file_directory .. "/bin/" .. file_name_without_path:gsub("%.cpp$", "")
					end
				end,
				breakpointMode = "file",
				cwd = "${fileDirname}",
				stopAtEntry = true,
			},
		}

		dap.adapters.python = {
			type = "executable",
			command = get_mason_path("debugpy") .. "/venv/bin/python",
			args = { "-m", "debugpy.adapter" },
		}
		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				pythonPath = function()
					local cwd = vim.fn.getcwd()
					if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
						return cwd .. "/venv/bin/python"
					elseif vim.fn.executable(cwd .. "/venv/Scripts/python.exe") == 1 then
						return cwd .. "/venv/Scripts/python.exe"
					else
						-- return "/usr/bin/python3" -- or any default python path you prefer
						return vim.fn.exepath("python3") or "python"
					end
				end,
			},
			{
				type = "python",
				request = "launch",
				name = "Launch file with arguments",
				program = "${file}",
				args = function()
					local args_string = vim.fn.input("Arguments: ")
					return vim.split(args_string, " +")
				end,
				console = "integratedTerminal",
				pythonPath = function()
					local cwd = vim.fn.getcwd()
					if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
						return cwd .. "/venv/bin/python"
					elseif vim.fn.executable(cwd .. "/venv/Scripts/python.exe") == 1 then
						return cwd .. "/venv/Scripts/python.exe"
					else
						-- return "/usr/bin/python3" -- or any default python path you prefer
						return vim.fn.exepath("python3") or "python"
					end
				end,
			},
		}

		dap.adapters.delve = {
			type = "server",
			port = "${port}",
			executable = {
				-- command = vim.fn.stdpath("data") .. "/mason/bin/dlv",
				command = "dlv",
				args = { "dap", "-l", "127.0.0.1:${port}" },
			},
		}

		dap.configurations.go = {
			{
				type = "delve",
				name = "Debug",
				request = "launch",
				program = "${file}",
				--[[ cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = function()
					local args_string = vim.fn.input("Arguments: ")
					return vim.split(args_string, " +")
				end, ]]
			},
			{
				type = "delve",
				name = "Debug go test",
				request = "launch",
				mode = "test",
				program = "${file}",
			},
			{
				type = "delve",
				name = "Debug go test (go.mod)",
				request = "launch",
				mode = "test",
				program = "./${relativeFileDirname}",
			},
		}

		-- local dapui = require "dapui"
		-- dapui.setup {}
		--
		-- dap.listeners.after.event_initialized["dapui_config"] = function()
		--     dapui.open {}
		-- end
		--
		-- dap.listeners.before.event_terminated["dapui_config"] = function()
		--     dapui.close {}
		-- end
		--
		-- dap.listeners.before.event_exited["dapui_config"] = function()
		--     dapui.close {}
		-- end
	end,
	keys = {
		{
			"<F5>",
			function()
				require("dap").terminate()
			end,
			desc = "Debug: Terminate",
		},
		{
			"<F8>",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Debug: Toggle breakpoint",
		},
		{
			"<F9>",
			function()
				require("dap").continue()
			end,
			desc = "Debug: Continue",
		},
		{
			"<F10>",
			function()
				require("dap").step_into()
			end,
			desc = "Debug: Step into",
		},
		{
			"<F11>",
			function()
				require("dap").step_over()
			end,
			desc = "Debug: Step over",
		},
		{
			"<F12>",
			function()
				require("dap").step_out()
			end,
			desc = "Debug: Step out",
		},

		{
			"<leader>db",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "Set breakpoint",
		},
		{
			"<leader>dp",
			function()
				require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end,
			desc = "Set log point",
		},
		{
			"<leader>dr",
			function()
				require("dap").repl.toggle()
			end,
			desc = "Toggle REPL",
		},
		{
			"<leader>dR",
			function()
				require("dap").restart()
			end,
			desc = "Debug: Restart",
		},
		{
			"<leader>dl",
			function()
				require("dap").run_last()
			end,
			desc = "Run last",
		},
	},
}
