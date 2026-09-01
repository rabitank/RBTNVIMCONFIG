return {
	"stevearc/aerial.nvim",
	opts = {
		layout = {

			min_width = 12,
			default_direction = "prefer_left",
		},
	},
	lazy_load = true,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<leader>so", ":AerialOpen<CR>", silent = true }, -- symbool search
		{ "<leader>ss", ":AerialToggle<CR>", silent = true }, -- symbool search
	},
}
