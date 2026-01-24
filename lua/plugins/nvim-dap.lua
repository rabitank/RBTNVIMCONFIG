return {
	"rcarriga/nvim-dap-ui",
	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	event = "VeryLazy",
	config = function(_, opt)
		require("dapui").setup(opt)
		-- set rust/c/cpp
		local dapui = require("dapui")
		local dap = require("dap")
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
			vim.keymap.set("n", "<F5>", ":DapContinue<CR>", { silent = true })
			vim.keymap.set("n", "<C-Down>", ":DapStepOver<CR>", { silent = true })
			vim.keymap.set("n", "<C-Right>", ":DapStepInto<CR>", { silent = true })
			vim.keymap.set("n", "<C-Left>", ":DapStepOut<CR>", { silent = true })
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
			vim.keymap.set("n", "<F5>", ":DapContinue<CR>", { silent = true })
			vim.keymap.set("n", "<C-Down>", ":DapStepOver<CR>", { silent = true })
			vim.keymap.set("n", "<C-Right>", ":DapStepInto<CR>", { silent = true })
			vim.keymap.set("n", "<C-Left>", ":DapStepOut<CR>", { silent = true })
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
			vim.keymap.set("n", "<F5>", ":DapNew<CR>", { silent = true })
			pcall(vim.keymap.del,"n", "<C-Down>")
			pcall(vim.keymap.del,"n", "<C-Right>")
			pcall(vim.keymap.del,"n", "<C-Left>")
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
			vim.keymap.set("n", "<F5>", ":DapNew<CR>", { silent = true })
			pcall(vim.keymap.del,"n", "<C-Down>")
			pcall(vim.keymap.del,"n", "<C-Right>")
			pcall(vim.keymap.del,"n", "<C-Left>")
		end

		dap.adapters.codelldb = {
			type = "executable",
			command = "codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"
			-- On windows you may have to uncomment this:
			-- detached = false,
		}
		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}
		dap.configurations.c = dap.configurations.cpp
		dap.configurations.rust = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}
	end,
	keys = {
		{ "<F5>", ":DapNew<CR>" },
		{ "<Leader>b", ":DapToggleBreakpoint<CR>", {silent = true} },
		{ "<Leader>de", ":DapEval<CR>", {silent = true} },
		{ "<Leader>df", ":lua require('dapui').float_element()<CR>", {silent = true} },
	},
}
