-- debug
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
			pcall(vim.keymap.del, "n", "<C-Down>")
			pcall(vim.keymap.del, "n", "<C-Right>")
			pcall(vim.keymap.del, "n", "<C-Left>")
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
			vim.keymap.set("n", "<F5>", ":DapNew<CR>", { silent = true })
			pcall(vim.keymap.del, "n", "<C-Down>")
			pcall(vim.keymap.del, "n", "<C-Right>")
			pcall(vim.keymap.del, "n", "<C-Left>")
		end

		dap.adapters.remote_codelldb = {
			type = "server", -- 使用 'server' 类型通常比 'executable' 更稳定[reference:2]
			port = "${port}", -- port 是codelldb启动server所需的,用于和客户端nvim-dap通信
			executable = {
				command = "codelldb", -- 或者 "lldb-dap"
				args = { "--port", "${port}" },
			},
		}

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
		-- 添加远程调试选项
		dap.configurations.rust = {
			{
				name = "Attach to Remote Process",
				type = "remote_codelldb", -- 确保这与你上面配置的适配器名称一致
				request = "attach",
				-- 使用 nvim-dap 内置的进程选择器
				pid = function()
					-- 方案 B：使用函数过滤，只保留 PID 大于 1000 的进程
					return require("dap.utils").pick_process({
						filter = function(proc)
							return proc.pid > 1000
						end,
						prompt = "选择要附加的 Rust 进程: ",
					})
				end, -- 如果你的代码需要源码映射，可以在这里配置
				-- sourceMap = { ... },
			},
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
		{ "<Leader>b", ":DapToggleBreakpoint<CR>", { silent = true } },
		{ "<Leader>de", ":DapEval<CR>", { silent = true } },
		{ "<Leader>df", ":lua require('dapui').float_element()<CR>", { silent = true } },
	},
}
