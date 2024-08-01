-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    -- use "luk400/vim-jukit"
    use {
        rocks = { "magick" }
    }
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    })

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use "nvim-lua/plenary.nvim" -- don't forget to add this one if you don't have it yet!
    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { { "nvim-lua/plenary.nvim" } }
    }
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            --- Uncomment the two plugins below if you want to manage the language servers from neovim
            -- {'williamboman/mason.nvim'},
            -- {'williamboman/mason-lspconfig.nvim'},

            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        },
        use {
            "windwp/nvim-autopairs",
            config = function() require("nvim-autopairs").setup {} end
        },
        use {
            "github/copilot.vim"
        },
        use {
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup({
                    toggler = { line = 'cc', block = '<leader>bb' },
                    opleader = { line = '<leader>c', block = '<leader>b' },
                }
                )
            end
        },
        -- install without yarn or npm
        -- use({
        --     "iamcco/markdown-preview.nvim",
        --     run = function() vim.fn["mkdp#util#install"]() end,
        -- }),

        use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = {
                "markdown" } end, ft = { "markdown" }, }),
        use { 'rcarriga/nvim-notify' },
        -- use {
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
        use { "kwakzalver/duckytype.nvim",
            config = function()
                require('duckytype').setup({})
            end
        },

        use {
            'nvim-lualine/lualine.nvim',
            requires = { 'nvim-tree/nvim-web-devicons', opt = true }
        }

    }
end)
