vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- my stuff - Graham
vim.keymap.set("i", "<S-Tab>", "<C-d>")
vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")

vim.keymap.set("n", "<M-j>", "<C-w>5+", { noremap = true, silent = true })
vim.keymap.set("n", "<M-k>", "<C-w>5-", { noremap = true, silent = true })
vim.keymap.set("n", "<M-h>", "<C-w>5>", { noremap = true, silent = true })
vim.keymap.set("n", "<M-l>", "<C-w>5<", { noremap = true, silent = true })
vim.keymap.set("t", "<C-b>", "<C-\\><C-n>", { noremap = true, silent = true })

-- obsidian
vim.keymap.set("n", "<leader>oo", "<cmd>e ~/Documents/obsidian/modalic/Index.md<CR>")
vim.keymap.set("n", "<leader>od", "<cmd>ObsidianDailies<CR>")
vim.keymap.set({ "n", "v" }, "<leader>ol", "<cmd>ObsidianLink<CR>")
vim.keymap.set({ "n", "v" }, "<leader>on", "<cmd>ObsidianLinkNew<CR>")
vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<CR>")
vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>")
vim.keymap.set("n", "<leader>oj", "<cmd>e ~/Documents/obsidian/modalic/modalic/Job Search.md<CR>")
vim.keymap.set("n", "<leader>ot", "<cmd>e ~/Documents/obsidian/modalic/modalic/Tasks.md<CR>")
vim.keymap.set("n", "<leader>oi", "<cmd>ObsidianIndex<CR>")
vim.keymap.set("n", "<leader>ok", "<cmd>e ~/Documents/obsidian/modalic/modalic/Knowledge Base.md<CR>")

-- config
vim.keymap.set("n", "<leader>cc", "<cmd>e ~/.config/nvim/<CR>")

-- formatting
vim.keymap.set("n", "<leader>bb", "<cmd>!black --config ~/.config/black/pyproject.toml --preview %<CR>")

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
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !~/.config/nvim/lua/scripts/tmux.sh && vim .<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
-- vim.keymap.set("v", "<leader>f", vim.lsp.formatexpr) -- why no work

-- vim.keymap.set("n", "<C-h>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-l>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>h", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>l", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- amazing
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)
