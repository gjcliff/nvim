return {
  "anurag3301/nvim-platformio.lua",
  -- cmd = { 'Pioinit', 'Piorun', 'Piocmdh', 'Piocmdf', 'Piolib', 'Piomon', 'Piodebug', 'Piodb' },

  -- dependencies are always lazy-loaded unless specified otherwise
  dependencies = {
    { "akinsho/toggleterm.nvim" },
    { "nvim-telescope/telescope.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-lua/plenary.nvim" },
    -- { "folke/which-key.nvim",                   enabled = false }, -- Add this
  },
  config = function()
    require("platformio").setup({
      lsp = "clangd", --default: ccls, other option: clangd
      -- If you pick clangd, it also creates compile_commands.json

      menu_key = "<leader>h",
    })
  end,
}
