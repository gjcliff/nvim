# Neovim

<!--toc:start-->
1. [Neovim](#neovim)  
2. [Introduction](#introduction)  
3. [Installation](#installation)
<!--toc:end-->

## Installation
1. Follow Neovim's installation instructions here:
https://github.com/neovim/neovim/blob/master/INSTALL.md
    * Don't install from apt, you're gonna want the most recent version

2. Clone this repo into your ~/.config/ directory
3. Type ```nvim``` into your terminal to open Neovim

## Usage
* Look at the nvim/lua/remap/remap.lua file to see the keybindings I have setup.
* Change configuration options for nvim in nvim/lua/remap/set.lua
* See what plugins I have installed in nvim/lua/plugins/plugins.lua
    * "nvim-telescope/telescope.nvim",
    * "rose-pine/neovim"
    * "nvim-treesitter/nvim-treesitter"
    * "ThePrimeagen/harpoon"
    * "mbbill/undotree"
    * "tpope/vim-fugitive"
    * "VonHeikemen/lsp-zero.nvim"
    * "neovim/nvim-lspconfig"
    * "williamboman/mason.nvim"
    * "williamboman/mason-lspconfig.nvim"
    * "hrsh7th/nvim-cmp"
    * "hrsh7th/cmp-nvim-lsp"
    * "hrsh7th/cmp-buffer"
    * "hrsh7th/cmp-path"
    * "saadparwaiz1/cmp_luasnip"
    * "hrsh7th/cmp-nvim-lua"
    * "L3MON4D3/LuaSnip"
    * "rafamadriz/friendly-snippets"
    * "windwp/nvim-autopairs"
    * "numToStr/Comment.nvim"
    * "iamcco/markdown-preview.nvim"
    * "rcarriga/nvim-notify"
    * "kwakzalver/duckytype.nvim"
    * "nvim-lualine/lualine.nvim"

The configurations for some of these plugins can be found in the after/plugins
directory.
