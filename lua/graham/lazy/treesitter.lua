return {
  "nvim-treesitter/nvim-treesitter",
  run = ":TSUpdate",
  config = function()
<<<<<<< Updated upstream
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "cpp", "python", "c", "lua", "vim", "vimdoc", "query", "norg" },
=======
    require("nvim-treesitter").setup({
      ensure_installed = { "cpp", "python", "c", "lua", "vim", "vimdoc", "query" },
>>>>>>> Stashed changes
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
      },
    })
  end
}
