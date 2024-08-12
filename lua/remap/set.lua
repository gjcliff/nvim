-- Example for configuring Neovim to load user-installed installed Lua rocks:
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/magick/init.lua;"
-- package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"

vim.opt.spell = false
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

vim.g.mapleader = " "

vim.lsp.buf.code_action()

-- Automatically format Python files using Black upon saving
-- vim.cmd([[autocmd FileType python autocmd BufWritePre <buffer> :!black %]])

-- Set indenting options for C++ files
vim.cmd([[
  autocmd FileType cpp setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab smartindent
]], false)

-- Set indenting options for C++ files
vim.cmd([[
  autocmd FileType c setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab smartindent
]], false)

-- Set indenting options for Python files
vim.cmd([[
  autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab smartindent
]], false)
