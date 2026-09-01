return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	event = "VeryLazy",
	config = function(_, _)
		require("lualine").setup({
			options = {
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			extensions = { "nvim-tree", "nvim-dap-ui" },
			sections = {
				lualine_b = {
					"branch",
					"diff",
					{
						require("noice").api.statusline.mode.get,
						cond = require("noice").api.statusline.mode.has,
						color = { fg = "#ff9e64" },
					},
				},
				lualine_x = {
					"filesize",
					"encoding",
					"filetype",
				},
			},
		})
	end,
}
