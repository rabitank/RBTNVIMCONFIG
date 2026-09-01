return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		actions = {
			open_file = {
				quit_on_open = true,
			},
		},
		sync_root_with_cwd = true,
		respect_buf_cwd = true,
		update_focused_file = {
			enable = true,
			update_root = true,
		},
	},
	keys = {
		{ "<leader>ft", ":NvimTreeToggle<CR>", silent = true },
	},
}
