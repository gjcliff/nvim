local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>vws", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)
	vim.keymap.set("n", "<leader>vd", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>vca", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<leader>vrr", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "<leader>vrn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)
end)

-- lsp_zero.setup_servers({'jedi_language_server, clangd'}) -- throwing errors when sourcing (:so)

-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md

local lspconfig = require("lspconfig")
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "cmake", "clangd" },
	handlers = {
		-- ["jedi_language_server"] = function()
		-- 	require("lspconfig").jedi_language_server.setup({
		-- 		-- capabilities = lsp_zero.capabilities,
		-- 		filetypes = { "python" },
		-- 	})
		-- end,
		function(server_name)
			if server_name == "pylsp" then
				lspconfig.pylsp.setup({
					-- on_attach = custom_attach,
					settings = {
						pylsp = {
							plugins = {
								-- formatter options
								black = {
									enabled = true,
									line_length = 88,
									preview = true,
								},
								autopep8 = { enabled = false },
								yapf = { enabled = false },
								-- linter options
								pylint = { enabled = true, executable = "pylint" },
								pyflakes = { enabled = false },
								pycodestyle = { enabled = false },
								-- type checker
								pylsp_mypy = { enabled = true },
								-- auto-completion options
								jedi_completion = { fuzzy = true },
								-- import sorting
								pyls_isort = { enabled = true },
							},
						},
					},
					flags = {
						debounce_text_changes = 200,
					},
					-- capabilities = capabilities,
					-- before_init = function(_, config)
					-- 	config.settings.python.pythonPath = "/usr/bin/python3"
					-- 	-- vim.env.PYTHONPATH = vim.env.PYTHONPATH .. ":" .. "/usr/lib/python3.10/site-packages"
					-- end,
				})
			-- all this other stuff is for developing C code for the pico. I had
			-- all of these crazy errors with "'stdio.h' file not found". I just
			-- had to literally hand the location of the headers to clangd so
			-- the lsp would work. Everything would still compile fine
			elseif server_name == "clangd" then
				lspconfig.clangd.setup({
					cmd = {
						"clangd",
						"--query-driver=/opt/gcc-arm-none-eabi-10-2020-q4-major/bin/arm-none-eabi-g*",
						-- "-I/opt/gcc-arm-none-eabi-10-2020-q4-major/lib/gcc/arm-none-eabi/10.2.1/include",
						-- "-I/opt/gcc-arm-none-eabi-10-2020-q4-major/arm-none-eabi/include",
						"--log=verbose",
					},
				})
			else
				require("lspconfig")[server_name].setup({})
			end
		end,
	},
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip", keyword_length = 2 },
		{ name = "buffer", keyword_length = 3 },
	},
	formatting = lsp_zero.cmp_format(),
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
})
