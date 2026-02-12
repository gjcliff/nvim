return {
  "nvim-treesitter/nvim-treesitter",
  run = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "cpp", "python", "c", "lua", "vim", "vimdoc", "query", "norg" },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
      },
    })
  end
}
