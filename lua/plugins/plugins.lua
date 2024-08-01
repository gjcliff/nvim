return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        requires = { { "nvim-lua/plenary.nvim" } }
    },
    {
        "rose-pine/neovim",
        as = "rose-pine",
        config = function()
            vim.cmd("colorscheme rose-pine")
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    },
    {
        "nvim-treesitter/playground"
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { { "nvim-lua/plenary.nvim" } }
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
        config = function() require("nvim-autopairs").setup {} end
    },
    { "github/copilot.vim"},
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({
                toggler = { line = 'cc', block = '<leader>bb' },
                opleader = { line = '<leader>c', block = '<leader>b' },
            }
            )
        end
    },
    {
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = {
                "markdown" }
        end,
        ft = { "markdown" },
    },
    { 'rcarriga/nvim-notify' },
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
    { "kwakzalver/duckytype.nvim",
        config = function()
            require('duckytype').setup({})
        end
    },

    {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    },
}
