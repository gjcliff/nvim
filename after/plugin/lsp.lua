-- if vim.env.VIRTUAL_ENV then
-- 	local venv_site_packages = vim.env.VIRTUAL_ENV .. "/lib/python3.10/site-packages"
-- 	vim.env.PYTHONPATH = vim.env.PYTHONPATH .. ":" .. venv_site_packages
-- end

local lspconfig = require("lspconfig")
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "cmake", "clangd", "lua_ls", "pylsp", "dockerls" },
	dependenies = {
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					-- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},
	handlers = {
		function(server)
			lspconfig[server].setup({})
		end,
		["pylsp"] = function()
			print("[lsp-zero] Configuring pylsp!")
			lspconfig.pylsp.setup({
				settings = {
					pylsp = {
						configurationSources = { "flake8" },
						plugins = {
							-- formatter options
							black = {
								enabled = true,
								line_length = 79,
								preview = true,
							},
							autopep8 = { enabled = false },
							yapf = { enabled = false },
							-- linter options
							pylint = { enabled = false, executable = "pylint" },
							pyflakes = { enabled = false },
							mccabe = { enabled = false },
							pycodestyle = { enabled = false },
							flake8 = {
								enabled = true,
								config = "/home/graham/.config/flake8/setup.cfg",
							},
							-- type checker
							pylsp_mypy = { enabled = false },
							-- auto-completion options
							jedi_completion = {
								enabled = true,
								fuzzy = true,
							},
							-- import sorting
							pyls_isort = { enabled = true },
						},
					},
				},
				flags = {
					debounce_text_changes = 200,
				},
			})
		end,
		["clangd"] = function()
			lspconfig.clangd.setup({
				cmd = {
					"clangd",
					"--query-driver=/opt/gcc-arm-none-eabi-10-2020-q4-major/bin/arm-none-eabi-g*",
					-- "-I/opt/gcc-arm-none-eabi-10-2020-q4-major/lib/gcc/arm-none-eabi/10.2.1/include",
					-- "-I/opt/gcc-arm-none-eabi-10-2020-q4-major/arm-none-eabi/include",
					"--log=verbose",
				},
			})
		end,
		["rust_analyzer"] = function()
			lspconfig.rust_analyzer.setup({
				on_attach = function(client, bufnr)
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				end,
				settings = {
					["rust-analyzer"] = {
						diagnostics = {
							enable = true,
						},
					},
				},
			})
		end,
		["cmake"] = function()
			lspconfig.cmake.setup({
				settings = {
					CMake = {
						filetypes = { "cmake", "CMakeLists.txt" },
					},
				},
			})
		end,
	},
})
