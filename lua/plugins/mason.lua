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

		local makesure_install = function(name)
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
			["clangd"] = {
                cmd = {
                    "clangd",
                    "--query-driver=" .. (function()
                        local globs = {}
                        for _, name in ipairs({ "g++", "gcc", "clang++" }) do
                            local dir = vim.fn.exepath(name):gsub("\\", "/"):match("^(.*)/")
                            if dir then globs[#globs + 1] = dir .. "/*" end
                        end
                        return table.concat(globs, ",")
                    end)(),
                },
                init_options = {
                    fallbackFlags = {"-std=c++17"}
                },
                root_dir = function(bufnr, on_dir)
                    local markers = { "compile_commands.json", "xmake.lua", ".git" }
                    local name = vim.api.nvim_buf_get_name(bufnr)
                    on_dir(vim.fs.root(name, markers) or vim.fs.root(vim.fn.getcwd(), markers) or vim.fn.getcwd())
                end,
                before_init = function(params, config)
                    params.initializationOptions = params.initializationOptions or {}
                    params.initializationOptions.compilationDatabasePath = config.root_dir
                end,
            },
			["tombi"] = {},
			["rust-analyzer"] = {
				settings = {
					["rust-analyzer"] = {
						-- 控制类型提示的显示
						diagnostics = {
							enable = true,
						},
						init_options = {
							publishDiagnostics = {
								relatedInformation = true,
							},
						},
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
		vim.api.nvim_exec_autocmds("User", { pattern = "MasonLoaded" })
	end,
}
