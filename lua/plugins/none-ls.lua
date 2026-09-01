return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	event = "User MasonLoaded",
	config = function()
		local registry = require("mason-registry")

		local function install(name)
			local success, package = pcall(registry.get_package, name)
			if success and not package:is_installed() then
				package:install()
			end
		end

		install("stylua")
		install("prettier")
		install("clang-format")
		--	install("leptosfmt")
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.clang_format.with({
					extra_args = { "--style={IndentWidth: 4}" },
				}),
				--			null_ls.builtins.formatting.leptosfmt,
			},
		})
	end,
	keys = {
		{
			"<leader>lf",
			vim.lsp.buf.format,
		},
	},
}
