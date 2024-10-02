require("obsidian").setup({
	ui = {
		enable = false,
	},
	workspaces = {
		{
			name = "playground",
			path = "~/Documents/obsidian/playground/",
		},
		{
			name = "oceancomm",
			path = "~/Documents/obsidian/oceancomm/",
		},
		{
			name = "home",
			path = "~/Documents/obsidian/home/",
		},
	},
	completion = {
		nvim_cmp = true,
		min_chars = 2,
	},
	mappings = {
		["gf"] = {
			action = function()
				return require("obsidian").util.gf_passthrough()
			end,
			opts = { noremap = false, expr = true, buffer = true },
		},
		-- Toggle check-boxes.
		["<leader>ch"] = {
			action = function()
				return require("obsidian").util.toggle_checkbox()
			end,
			opts = { buffer = true },
		},
		-- Smart action depending on context, either follow link or toggle checkbox.
		["<cr>"] = {
			action = function()
				return require("obsidian").util.smart_action()
			end,
			opts = { buffer = true, expr = true },
		},
	},
	picker = {
		-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
		name = "telescope.nvim",
		-- Optional, configure key mappings for the picker. These are the defaults.
		-- Not all pickers support all mappings.
		note_mappings = {
			-- Create a new note from your query.
			new = "<C-x>",
			-- Insert a link to the selected note.
			insert_link = "<C-;>",
		},
		tag_mappings = {
			-- Add tag(s) to current note.
			tag_note = "<C-x>",
			-- Insert a tag at the current location.
			insert_tag = "<C-;>",
		},
	},
	---@param url string
	follow_url_func = function(url)
		-- Open the URL in the default web browser.
		-- vim.fn.jobstart({ "open", url }) -- Mac OS
		vim.fn.jobstart({ "xdg-open", url }) -- linux
		-- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
		-- vim.ui.open(url) -- need Neovim 0.10.0+
	end,
	templates = {
		folder = "templates",
		date_format = "%Y-%m-%d",
		time_format = "%H:%M",
		default_template = "Default.md",
		-- A map for custom variables, the key should be the variable and the value a function
		-- substitutions = {
		--     yesterday = function()
		--         return os.date("%Y-%m-%d", os.time() - 86400)
		--     end
		-- }
	},
	notes_subdir = "playground",
	new_notes_location = "notes_subdir",
	log_level = vim.log.levels.INFO,
	open_notes_in = "vsplit",
	note_id_func = function(title)
		return title
	end,
})
