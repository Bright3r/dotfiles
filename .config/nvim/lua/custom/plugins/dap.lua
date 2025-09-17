return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
		},
		config = function()
			local dap = require("dap")
			local ui = require("dapui")

			ui.setup()

			-- cpp config
			dap.adapters.cppdbg = {
				id = "cppdbg",
				type = "executable",
				command = "/usr/share/cpptools-debug/bin/OpenDebugAD7",
			}

			dap.configurations.cpp = {
				{
					name = "Launch file",
					type = "cppdbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopAtEntry = true,
					MIMode = "gdb",
					miDebuggerPath = "/usr/bin/gdb",
				},
			}

			-- C and Rust configs
			dap.configurations.c = dap.configurations.cpp
			dap.configurations.rust = dap.configurations.cpp

			-- Set breakpoint
			vim.keymap.set("n", "<space>b", dap.toggle_breakpoint, { desc = "[B]reakpoint" })
			vim.keymap.set("n", "<space>gb", dap.run_to_cursor, { desc = "[G]oto [B]reakpoint" })

			-- Eval var under cursor
			vim.keymap.set("n", "<space>?", function()
				ui.eval(nil, { enter = true })
			end, { desc = "[?] Evaluate Value" })

			-- Step through debugger
			vim.keymap.set("n", "<F1>", dap.continue)
			vim.keymap.set("n", "<F2>", dap.step_into)
			vim.keymap.set("n", "<F3>", dap.step_over)
			vim.keymap.set("n", "<F4>", dap.step_out)
			vim.keymap.set("n", "<F5>", dap.step_back)
			vim.keymap.set("n", "<F12>", dap.restart)

			-- Stylize breakpoints
			vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "Error", linehl = "", numhl = "" })
			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = "🔶", texthl = "WarningMsg", linehl = "", numhl = "" }
			)
			vim.fn.sign_define("DapStopped", { text = "🟩", texthl = "String", linehl = "DiffAdd", numhl = "" })

			-- DAP-UI
			dap.listeners.before.attach.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				ui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				ui.close()
			end
		end,
	},
}
