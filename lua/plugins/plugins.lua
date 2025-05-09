return {
	-- {
	-- 	"luk400/vim-jukit",
	-- },

	{
		"kawre/leetcode.nvim",
		build = ":TSUpdate html",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim", -- required by telescope
			"MunifTanjim/nui.nvim",

			-- optional
			"nvim-treesitter/nvim-treesitter",
			"rcarriga/nvim-notify",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			---@type string
			arg = "leetcode.nvim",

			---@type lc.lang
			lang = "cpp",

			cn = { -- leetcode.cn
				enabled = false, ---@type boolean
				translator = true, ---@type boolean
				translate_problems = true, ---@type boolean
			},

			---@type lc.storage
			storage = {
				home = vim.fn.stdpath("data") .. "/leetcode",
				cache = vim.fn.stdpath("cache") .. "/leetcode",
			},

			---@type table<string, boolean>
			plugins = {
				non_standalone = false,
			},

			---@type boolean
			logging = true,

			injector = {}, ---@type table<lc.lang, lc.inject>

			cache = {
				update_interval = 60 * 60 * 24 * 7, ---@type integer 7 days
			},

			console = {
				open_on_runcode = true, ---@type boolean

				dir = "row", ---@type lc.direction

				size = { ---@type lc.size
					width = "90%",
					height = "75%",
				},

				result = {
					size = "60%", ---@type lc.size
				},

				testcase = {
					virt_text = true, ---@type boolean

					size = "40%", ---@type lc.size
				},
			},

			description = {
				position = "left", ---@type lc.position

				width = "40%", ---@type lc.size

				show_stats = true, ---@type boolean
			},

			hooks = {
				---@type fun()[]
				["enter"] = {},

				---@type fun(question: lc.ui.Question)[]
				["question_enter"] = {},

				---@type fun()[]
				["leave"] = {},
			},

			keys = {
				toggle = { "q" }, ---@type string|string[]
				confirm = { "<CR>" }, ---@type string|string[]

				reset_testcases = "r", ---@type string
				use_testcase = "U", ---@type string
				focus_testcases = "H", ---@type string
				focus_result = "L", ---@type string
			},

			---@type lc.highlights
			theme = {},

			---@type boolean
			image_support = false,
		},
	},

	{
		"MunifTanjim/nui.nvim",
	},

	{
		"mhartington/formatter.nvim",
	},

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

	{
		"L3MON4D3/LuaSnip",
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
	},

	{ "rafamadriz/friendly-snippets" },

	{
		"windwp/nvim-autopairs",
		-- config = function() require("nvim-autopairs").setup {} end
		event = "InsertEnter",
		config = true,
	},

	-- { "github/copilot.vim" },

	{
		"numToStr/Comment.nvim",
		opts = {
			toggler = { line = "cc", block = "<leader>bb" },

			opleader = { line = "<leader>c", block = "<leader>b" },
		},
	},

	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},

	{ "rcarriga/nvim-notify" },

	-- {
	-- 	"3rd/image.nvim",
	-- 	build = false,
	-- 	-- opts = {},
	-- },
	-- {
	-- 	"kwakzalver/duckytype.nvim",
	-- 	config = function()
	-- 		require("duckytype").setup({})
	-- 	end,
	-- },

	{
		"nvzone/typr",
		dependencies = "nvzone/volt",
		opts = {},
		cmd = { "Typr", "TyprStats" },
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		-- event = {
		--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
		--   -- refer to `:h file-pattern` for more examples
		--   "BufReadPre path/to/my-vault/*.md",
		--   "BufNewFile path/to/my-vault/*.md",
		-- },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
}
