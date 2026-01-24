return {
	"mason-org/mason.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"mason-org/mason-lspconfig.nvim",
	},
	opts = {},
	event = "VeryLazy",
	config = function(_, opts)
		require("mason").setup(opts)
		local registry = require("mason-registry")


        local makesure_install = function (name)
			local success, package = pcall(registry.get_package, name)
			if success and not package:is_installed() then
				package:install()
			end
        end

		local function setup(mason_lsp_name, configs)
            makesure_install(mason_lsp_name)
			local nvim_lsp = require("mason-lspconfig").get_mappings().package_to_lspconfig[mason_lsp_name]
			configs.capabilities = require("blink.cmp").get_lsp_capabilities()
			-- forbiden ls format func, use nnls format
			local use_native_lsp_format = {
				["rust-analyzer"] = {},
			}
			if use_native_lsp_format[mason_lsp_name] == nil then
				configs.on_attach = function(server)
					server.server_capabilities.documentFormattingProvider = false
					server.server_capabilities.documentRangeFormattingProvider = false
				end
			end
			vim.lsp.config(nvim_lsp, configs)
			vim.lsp.enable(nvim_lsp)
		end

		local servers = {
			["lua-language-server"] = {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			},
			pyright = {},
			["emmet-ls"] = {},
			["json-lsp"] = {},
			["tombi"] = {},
			["rust-analyzer"] = {
				settings = {
					["rust-analyzer"] = {
						-- 控制类型提示的显示
						inlayHints = {
							-- 显示参数的类型提示
							parameterHints = {
								enable = true,
							},
							-- 显示返回值的类型提示
							returnTypeHints = {
								enable = true,
							},
							typeHints = {
								showExpanded = false,
							},
						},
					},
				},
			},
		}

		for server, config in pairs(servers) do
			setup(server, config)
		end
		--        vim.cmd("LspStart")
        
        makesure_install("codelldb")

		vim.diagnostic.config({
			virtual_text = true,
            signs = false,
			update_in_insert = true,
		})
		vim.api.nvim_exec_autocmds("User", { pattern = "MasonLoaded" })
	end,
}
