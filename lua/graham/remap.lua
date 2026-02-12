vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- my stuff - Graham
vim.keymap.set("i", "<S-Tab>", "<C-d>")
vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")

vim.keymap.set(
  "n",
  "<leader>cd",
  ":cd %:p:h<CR>",
  { desc = "cd to current file dir" }
)

-- neorg
vim.keymap.set('n', '<localleader>sw',
  '<cmd>Telescope neorg switch_workspace<CR>',
  { desc = 'Switch neorg workspace' })
vim.keymap.set('n', '<localleader>ss',
  '<cmd>Telescope neorg find_linkable<CR>',
  { desc = 'Switch neorg workspace' })
vim.keymap.set('n', '<localleader>il',
  '<cmd>Telescope neorg insert_link<CR>',
  { desc = 'Switch neorg workspace' })
vim.keymap.set('n', '<localleader>ifl',
  '<cmd>Telescope neorg insert_file_link<CR>',
  { desc = 'Switch neorg workspace' })


vim.keymap.set("n", "<M-j>", "<C-w>5+", { noremap = true, silent = true })
vim.keymap.set("n", "<M-k>", "<C-w>5-", { noremap = true, silent = true })
vim.keymap.set("n", "<M-h>", "<C-w>5>", { noremap = true, silent = true })
vim.keymap.set("n", "<M-l>", "<C-w>5<", { noremap = true, silent = true })
vim.keymap.set("t", "<C-b>", "<C-\\><C-n>", { noremap = true, silent = true })

vim.keymap.set("n", "gd", function()
  vim.lsp.buf.definition()
end)
vim.keymap.set("n", "gD", function()
  vim.lsp.buf.declaration()
end)
vim.keymap.set("n", "K", function()
  vim.lsp.buf.hover()
end)
vim.keymap.set("n", "<leader>vws", function()
  vim.lsp.buf.workspace_symbol()
end)
vim.keymap.set("n", "<leader>vd", function()
  vim.diagnostic.open_float({ focusable = true })
end)
vim.keymap.set("n", "[d", function()
  vim.diagnostic.goto_next()
end)
vim.keymap.set("n", "]d", function()
  vim.diagnostic.goto_prev()
end)
vim.keymap.set("n", "<leader>vca", function()
  vim.lsp.buf.code_action()
end)
vim.keymap.set("n", "<leader>vrr", function()
  vim.lsp.buf.references()
end)
vim.keymap.set("n", "<leader>vrn", function()
  vim.lsp.buf.rename()
end)
vim.keymap.set("i", "<C-h>", function()
  vim.lsp.buf.signature_help()
end)

-- transfer
vim.keymap.set("n", "<leader>tu", "<cmd>TransferUpload<CR>")

-- formatting
vim.keymap.set(
  "n",
  "<leader>bb",
  "<cmd>!black --config ~/.config/black/pyproject.toml --preview %<CR>"
)

-- end of my stuff

-- --------- --
-- primeagen --
-- --------- --
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
-- vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !~/.config/nvim/lua/scripts/tmux.sh && vim .<CR>")
-- vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end)
-- vim.keymap.set("v", "<leader>f", vim.lsp.formatexpr) -- why no work

-- vim.keymap.set("n", "<C-h>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-l>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>h", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>l", "<cmd>lprev<CR>zz")

vim.keymap.set(
  "n",
  "<leader>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]
) -- amazing
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- vim.keymap.set("n", "<leader><leader>", function()
--   vim.cmd("so")
-- end)
