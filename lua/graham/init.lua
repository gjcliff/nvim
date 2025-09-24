require("graham.set")
require("graham.remap")
require("graham.lazy_init")

local gram_group = vim.api.nvim_create_augroup("gram_group", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre",
  {
    group = gram_group,
    pattern = "*",
    callback = function()
      vim.lsp.buf.format({ async = false })
    end
  }
)

vim.api.nvim_create_autocmd('TextYankPost', {
  group = gram_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 50,
    })
  end,
})

-- vim.cmd("colorscheme kanagawa-dragon")
vim.cmd("colorscheme nightfox")
ColorMyPencils()
