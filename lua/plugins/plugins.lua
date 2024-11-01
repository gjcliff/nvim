return {
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		-- Optional dependencies
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		requires = { { "nvim-lua/plenary.nvim" } },
	},
	{
		"rose-pine/neovim",
		as = "rose-pine",
		config = function()
			vim.cmd("colorscheme rose-pine")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	},
	{
		"nvim-treesitter/playground",
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{ "mbbill/undotree" },
	{ "tpope/vim-fugitive" },
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		-- requires = {
		-- LSP Support
		-- }
	},
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	-- Autocompletion
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "hrsh7th/cmp-nvim-lua" },
	{ "L3MON4D3/LuaSnip" },
	{ "rafamadriz/friendly-snippets" },
	{
		"windwp/nvim-autopairs",
		-- config = function() require("nvim-autopairs").setup {} end
		event = "InsertEnter",
		config = true,
	},
	{ "github/copilot.vim" },
	{
		"numToStr/Comment.nvim",
		opts = {
			toggler = { line = "cc", block = "<leader>bb" },
			opleader = { line = "<leader>c", block = "<leader>b" },
		},
	},
	{ "rcarriga/nvim-notify" },
	-- {
	--     '3rd/image.nvim',
	--     config = function()
	--         require('image').setup({
	--             backend = "kitty",
	--             max_width = 100,
	--             max_height = 12,
	--             max_height_window_percentage = math.huge,
	--             max_width_window_percentage = math.huge,
	--             window_overlap_clear_enabled = true,
	--             window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
	--         })
	--     end,
	--
	-- },
	{
		"kwakzalver/duckytype.nvim",
		config = function()
			require("duckytype").setup({})
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
}
