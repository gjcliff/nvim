vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- my stuff - Graham
vim.keymap.set("i", "<S-Tab>", "<C-d>")
vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
-- vim.keymap.set("i", "<C-n>n", "")
vim.api.nvim_set_keymap('t', '<C-n>', '<C-\\><C-n>', { noremap = true, silent = true })

-- obsidian
vim.keymap.set("n", "<leader>oo", "<cmd>e ~/Work/notes/obsidian/work/Oceancomm.md<CR>")
vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>")
vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianNewFromTemplate<CR>")
vim.keymap.set("n", "<leader>od", "<cmd>ObsidianDailies<CR>")
vim.keymap.set("n", "<leader>oy", "<cmd>ObsidianDailiesYesterday<CR>")
<<<<<<< HEAD
vim.keymap.set("n", "<leader>oh", "<cmd>ObsidianTemplate<CR>")
=======
vim.keymap.set("n", "<leader>ol", "<cmd>ObsidianLink<CR>")

>>>>>>> home
-- vim.keymap.set("n", "<leader>oy", function()
    --     )

-- formatting
vim.keymap.set("n", "<leader>bb", "<cmd>!black %<CR>")




-- -- jukit
-- -- Opens a new output window and executes the command specified in `g:jukit_shell_cmd`
-- vim.keymap.set("n", "<leader>os", ":call jukit#splits#output()<cr>", {noremap=true})
-- -- Opens a new output window and executes the command specified in `g:jukit_shell_cmd`
-- vim.keymap.set("n", "<leader>ts", ":call jukit#splits#term()<cr>", {noremap=true})
-- -- Opens a new output window without executing any command
-- vim.keymap.set("n", "<leader>hs", ":call jukit#splits#history()<cr>", {noremap=true})
-- -- Opens a new output-history window, where saved ipython outputs are displayed
-- vim.keymap.set("n", "<leader>ohs", ":call jukit#splits#output_and_history()<cr>", {noremap=true})
-- -- Shortcut for opening output terminal and output-history
-- vim.keymap.set("n", "<leader>hd", ":call jukit#splits#close_history()<cr>", {noremap=true})
-- -- Close output-history window
-- vim.keymap.set("n", "<leader>od", ":call jukit#splits#close_output_split()<cr>", {noremap=true})
-- -- Close output window
-- vim.keymap.set("n", "<leader>ohd", ":call jukit#splits#close_output_and_history(1)<cr>", {noremap=true})
-- -- Close both windows. Argument: Whether or not to ask you to confirm before closing.
-- vim.keymap.set("n", "<leader>so", ":call jukit#splits#show_last_cell_output(1)<cr>", {noremap=true})
-- -- Show output of current cell (determined by current cursor position) in output-history window. Argument: Whether or not to reload outputs if cell id of outputs to display is the same as the last cell id for which outputs were displayed
-- vim.keymap.set("n", "<leader>j", ":call jukit#splits#out_hist_scroll(1)<cr>", {noremap=true})
-- -- Scroll down in output-history window. Argument: whether to scroll down (1) or up (0)
-- vim.keymap.set("n", "<leader>k", ":call jukit#splits#out_hist_scroll(0)<cr>", {noremap=true})
-- -- Scroll up in output-history window. Argument: whether to scroll down (1) or up (0)
-- vim.keymap.set("n", "<leader>ah", ":call jukit#splits#toggle_auto_hist()<cr>", {noremap=true})
-- -- Create/delete autocmd for displaying saved output on CursorHold. Also, see explanation for `g:jukit_auto_output_hist`
-- vim.keymap.set("n", "<leader>sl", ":call jukit#layouts#set_layout()<cr>", {noremap=true})
-- -- Apply layout (see `g:jukit_layout`) to current splits - NOTE: it is expected that this function is called from the main file buffer/split
-- vim.keymap.set("n", "<leader><space>", ":call jukit#send#section(0)<cr>", {noremap=true})
-- -- Send code within the current cell to output split (also saves the output if ipython is used and `g:jukit_save_output==1`). Argument: if 1, will move the cursor to the next cell below after sending the code to the split, otherwise cursor position stays the same.
-- vim.keymap.set("n", "<cr>", ":call jukit#send#line()<cr>", {noremap=true})
-- -- Send current line to output split
-- vim.keymap.set("v", "<cr>", ":<C-U>call jukit#send#selection()<cr>", {noremap=true})
-- -- Send visually selected code to output split
-- vim.keymap.set("n", "<leader>ccc", ":call jukit#send#until_current_section()<cr>", {noremap=true})
-- -- Execute all cells until the current cell
-- vim.keymap.set("n", "<leader>all", ":call jukit#send#all()<cr>", {noremap=true})
-- -- Execute all cells
-- vim.keymap.set("n", "<leader>co", ":call jukit#cells#create_below(0)<cr>", {noremap=true})
-- -- Create new code cell below. Argument: Whether to create code cell (0) or markdown cell (1)
-- vim.keymap.set("n", "<leader>cO", ":call jukit#cells#create_above(0)<cr>", {noremap=true})
-- -- Create new code cell above. Argument: Whether to create code cell (0) or markdown cell (1)
-- vim.keymap.set("n", "<leader>ct", ":call jukit#cells#create_below(1)<cr>", {noremap=true})
-- -- Create new textcell below. Argument: Whether to create code cell (0) or markdown cell (1)
-- vim.keymap.set("n", "<leader>cT", ":call jukit#cells#create_above(1)<cr>", {noremap=true})
-- -- Create new textcell above. Argument: Whether to create code cell (0) or markdown cell (1)
-- vim.keymap.set("n", "<leader>cd", ":call jukit#cells#delete()<cr>", {noremap=true})
-- -- Delete current cell
-- vim.keymap.set("n", "<leader>cs", ":call jukit#cells#split()<cr>", {noremap=true})
-- -- Split current cell (saved output will then be assigned to the resulting cell above)
-- vim.keymap.set("n", "<leader>cM", ":call jukit#cells#merge_above()<cr>", {noremap=true})
-- -- Merge current cell with the cell above
-- vim.keymap.set("n", "<leader>cm", ":call jukit#cells#merge_below()<cr>", {noremap=true})
-- -- Merge current cell with the cell below
-- vim.keymap.set("n", "<leader>ck", ":call jukit#cells#move_up()<cr>", {noremap=true})
-- -- Move current cell up
-- vim.keymap.set("n", "<leader>cj", ":call jukit#cells#move_down()<cr>", {noremap=true})
-- -- Move current cell down
-- vim.keymap.set("n", "<leader>J", ":call jukit#cells#jump_to_next_cell()<cr>", {noremap=true})
-- -- Jump to the next cell below
-- vim.keymap.set("n", "<leader>K", ":call jukit#cells#jump_to_previous_cell()<cr>", {noremap=true})
-- -- Jump to the previous cell above
-- vim.keymap.set("n", "<leader>ddo", ":call jukit#cells#delete_outputs(0)<cr>", {noremap=true})
-- -- Delete saved output of current cell. Argument: Whether to delete all saved outputs (1) or only saved output of current cell (0)
-- vim.keymap.set("n", "<leader>dda", ":call jukit#cells#delete_outputs(1)<cr>", {noremap=true})
-- -- Delete saved outputs of all cells. Argument: Whether to delete all saved outputs (1) or only saved output of current cell (0)
-- vim.keymap.set("n", "<leader>np", ":call jukit#convert#notebook_convert('jupyter-notebook')<cr>", {noremap=true})
-- -- Convert from ipynb to py or vice versa. Argument: Optional. If an argument is specified, then its value is used to open the resulting ipynb file after converting script.
-- vim.keymap.set("n", "<leader>ht", ":call jukit#convert#save_nb_to_file(0,1,'html')<cr>", {noremap=true})
-- -- Convert file to html (including all saved outputs) and open it using the command specified in `g:jukit_html_viewer'. If `g:jukit_html_viewer` is not defined, then will default to `g:jukit_html_viewer='xdg-open'`. Arguments: 1.: Whether to rerun all cells when converting 2.: Whether to open it after converting 3.: filetype to convert to
-- vim.keymap.set("n", "<leader>rht", ":call jukit#convert#save_nb_to_file(1,1,'html')<cr>", {noremap=true})
-- -- Same as above, but will (re-)run all cells when converting to html
-- vim.keymap.set("n", "<leader>pd", ":call jukit#convert#save_nb_to_file(0,1,'pdf')<cr>", {noremap=true})
-- -- Convert file to pdf (including all saved outputs) and open it using the command specified in `g:jukit_pdf_viewer'. If `g:jukit_pdf_viewer` is not defined, then will default to `g:jukit_pdf_viewer='xdg-open'`. Arguments: 1.: Whether to rerun all cells when converting 2.: Whether to open it after converting 3.: filetype to convert to. NOTE: If the function doesn't work there may be issues with your nbconvert or latex version - to debug, try converting to pdf using `jupyter nbconvert --to pdf --allow-errors --log-level='ERROR' --HTMLExporter.theme=dark </abs/path/to/ipynb> && xdg-open </abs/path/to/pdf>` in your terminal and check the output for possible issues.
-- vim.keymap.set("n", "<leader>rpd", ":call jukit#convert#save_nb_to_file(1,1,'pdf')<cr>", {noremap=true})
-- -- Same as above, but will (re-)run all cells when converting to pdf. NOTE: If the function doesn't work there may be issues with your nbconvert or latex version - to debug, try converting to pdf using `jupyter nbconvert --to pdf --allow-errors --log-level='ERROR' --HTMLExporter.theme=dark </abs/path/to/ipynb> && xdg-open </abs/path/to/pdf>` in your terminal and check the output for possible issues.
-- vim.keymap.set("n", "<leader>pos", ":call jukit#ueberzug#set_default_pos()<cr>", {noremap=true})
-- -- Set position and dimension of überzug window
--
-- -- molten
-- vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>",
--     { silent = true, desc = "Initialize the plugin" })
-- vim.keymap.set("n", "<leader>e", ":MoltenEvaluateOperator<CR>",
--     { silent = true, desc = "run operator selection" })
-- vim.keymap.set("n", "<leader>rl", ":MoltenEvaluateLine<CR>",
--     { silent = true, desc = "evaluate line" })
-- vim.keymap.set("n", "<leader>rr", ":MoltenReevaluateCell<CR>",
--     { silent = true, desc = "re-evaluate cell" })
-- vim.keymap.set("v", "<leader>r", ":<C-u>MoltenEvaluateVisual<CR>gv",
--     { silent = true, desc = "evaluate visual selection" })
-- vim.keymap.set("n", "<leader>rd", ":MoltenDelete<CR>",
--     { silent = true, desc = "molten delete cell" })
-- vim.keymap.set("n", "<leader>oh", ":MoltenHideOutput<CR>",
--     { silent = true, desc = "hide output" })
-- vim.keymap.set("n", "<leader>es", ":noautocmd MoltenEnterOutput<CR>",
--     { silent = true, desc = "show/enter output" })

-- end of my stuff

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux new tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-h>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-l>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>h", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>l", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)

vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
