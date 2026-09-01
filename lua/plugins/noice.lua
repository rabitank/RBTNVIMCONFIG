-- lazy.nvim
return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		notify = {
			view = "mini",
		},
		messages = {
			view = "mini",
			view_warn = "mini",
			view_error = "notify",
			timeout = 4000,
		},
		popupmenu = {
			enabled = false, -- enables the Noice popupmenu UI
			---@type 'nui'|'cmp'
			backend = "cmp", -- backend to use to show regular cmdline completions
			---@type NoicePopupmenuItemKind|false
			-- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
			kind_icons = false -- {}, -- set to `false` to disable icons
		},
		views = {
			cmdline_popup = {
				position = {
					row = 20,
					col = "40%",
				},
				size = {
					width = 60,
					height = "auto",
				},
			},
			popupmenu = {
				relative = "editor",
				position = {
					row = 23,
					col = "40%",
				},
				size = {
					width = 65,
					height = 18,
				},
				border = {
					style = "rounded",
					padding = { 0, 1 },
				},
				win_options = {
					winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
				},
			},
			notify = {
				-- 使用 mini 预设，实现小型化显示 (类似 nvim-notify 风格)
				level = "warn", -- 只显示警告和错误级别的通知
				-- 强制固定在右下角
				position = {
					row = "bottom",
					col = "right",
				},
				-- 可选：调整大小，mini 模式下通常不需要太大
				size = { width = 40, height = 5 },
			},
		},

		-- add any options here
		lsp = {
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
			},
		},
		-- you can enable a preset for easier configuration
		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
			command_palette = true, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = false, -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = false, -- add a border to hover docs and signature help
		},
		cmdline = {
			view = "cmdline_popup", -- "cmdline_popup",
		},
	},
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		"rcarriga/nvim-notify",
	},
}
