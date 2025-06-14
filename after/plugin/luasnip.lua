local luasnip = require("luasnip")
local lsp_zero = require("lsp-zero")
-- require("luasnip.loaders.from_vscode").lazy_load()
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({

	-- ... Your other configuration ...
	sources = {
		{ name = "nvim_lsp" }, -- Ensure LSP has highest priority
		{ name = "path" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "buffer" },
	},

	formatting = lsp_zero.cmp_format(),

	mapping = {

		-- ... Your other mappings ...
		["<CR>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				if luasnip.expandable() then
					luasnip.expand()
				else
					cmp.confirm({
						select = true,
					})
				end
			else
				fallback()
			end
		end),

		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.locally_jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),

		-- ... Your other mappings ...
	},

	-- ... Your other configuration ...
})
-- local ls = require("luasnip")
--
-- vim.keymap.set({ "i" }, "<C-K>", function()
-- 	ls.expand()
-- end, { silent = true })
-- vim.keymap.set({ "i", "s" }, "<C-L>", function()
-- 	ls.jump(1)
-- end, { silent = true })
-- vim.keymap.set({ "i", "s" }, "<C-J>", function()
-- 	ls.jump(-1)
-- end, { silent = true })
--
-- vim.keymap.set({ "i", "s" }, "<C-E>", function()
-- 	if ls.choice_active() then
-- 		ls.change_choice(1)
-- 	end
-- end, { silent = true })
--
-- cmp.setup({
-- 	sources = {
-- 		{ name = "nvim_lsp" }, -- Ensure LSP has highest priority
-- 		{ name = "path" },
-- 		{ name = "nvim_lua" },
-- 		{ name = "luasnip" },
-- 		{ name = "buffer" },
-- 	},
--
-- 	formatting = lsp_zero.cmp_format(),
-- 	mapping = cmp.mapping.preset.insert({
-- 		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
-- 		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
-- 		["<C-y>"] = cmp.mapping.confirm({ select = true }),
-- 		["<C-Space>"] = cmp.mapping.complete(),
-- 	}),
-- })
