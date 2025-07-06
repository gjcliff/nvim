local function create_note_with_template(opts)
  -- Prompt the user for the note title
  local title = opts.args
  title = title:gsub('"', '\\"')   -- Escape double quotes

  if title == "" then
    print("Task title cannot be empty")
    return
  end

  -- Define the directory where notes are stored (optional)
  -- local notes_dir = "~/Documents/obsidian/oceancomm/Oceancomm" -- Update as needed

  -- Create a link in the current file
  vim.cmd("normal! O")
  local link = string.format("@{%s} %s", os.date("%Y-%m-%d", os.time()), title)
  vim.api.nvim_put({ link }, "c", true, true)   -- insert the link at cursor position, that's what the "c" is

  vim.cmd("normal! V")
  vim.cmd("ObsidianLinkNew")

  vim.cmd("normal! l")
  vim.defer_fn(function()
    vim.cmd("normal! d0")
  end, 1)   -- without this 1ms of delay, this won't work for some reason
end
-- Create a Neovim command that runs the function
vim.api.nvim_create_user_command("ObsidianTask", function(opts)
  create_note_with_template(opts)
end, { nargs = 1 })

local function create_journal_entry()
  -- vim.cmd("normal! O")
  local link = string.format("[[%s]]", os.date("%Y-%m-%d", os.time()))
  vim.api.nvim_put({ link }, "c", true, true)   -- Insert the link at cursor position

  -- Create the note with the specific template
  local command = string.format("ObsidianNewFromTemplate %s",
    string.format("%s.md", os.date("%Y-%m-%d")))
  vim.cmd(command)
  vim.api.nvim_put({ os.date("%Y-%m-%d") }, "l", true, true)   -- Insert the date at the beginning of the note
  vim.cmd("write")
  vim.cmd("normal! <C-o>")
end
vim.api.nvim_create_user_command("ObsidianJournal", function()
  create_journal_entry()
end, {})

local function create_link_to_index()
  local link = "[[Index]]"
  vim.api.nvim_put({ link }, "c", true, true)   -- Insert the link at cursor position
end
vim.api.nvim_create_user_command("ObsidianIndex", function()
  create_link_to_index()
end, {})

local function create_daily_note()
  -- vim.cmd("normal! O")
  local link = string.format("[[%s]]", os.date("%Y-%m-%d", os.time()))
  vim.api.nvim_put({ link }, "c", true, true)   -- Insert the link at cursor position

  -- Create the note with the specific template
  -- local command = string.format("ObsidianNewFromTemplate %s", string.format("%s.md", os.date("%Y-%m-%d")))
  -- vim.cmd(command)
  -- vim.api.nvim_put({ os.date("%Y-%m-%d") }, "l", true, true) -- Insert the date at the beginning of the note
  vim.cmd("ObsidianToday")
end
vim.api.nvim_create_user_command("ObsidianDailyNote", function()
  create_daily_note()
end, {})

-- Create a new link from template from highlighted text
vim.api.nvim_create_user_command("ObsidianFromSelection", function()
  -- Get the selected text positions
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local line_start = start_pos[2]
  local line_end = end_pos[2]
  local start_row, start_col = start_pos[2], start_pos[3]
  local end_row, end_col = end_pos[2], end_pos[3]
  -- Get the selected text
  local selected_text = vim.fn.getline(line_start, line_end)
  -- local selected_text = vim.fn.getline(start_row, start_row):sub(start_col, end_col)

  -- Escape quotes in the selected text
  local title = selected_text:gsub('"', '\\"')

  -- Create the note using the template
  local command = string.format('ObsidianNewFromTemplate "@{%s} %s.md"',
    os.date("%Y-%m-%d", os.time()), title)
  vim.cmd(command)

  -- Create the link to the new note
  local link = string.format("[[%s]]", title)

  -- Replace the selected text with the link
  vim.api.nvim_buf_set_text(0, start_row - 1, start_col - 1, end_row - 1, end_col,
    { link })
end, {})

-- finish setting up obsidian
return
{
  "epwalsh/obsidian.nvim",
  version = "*",   -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },

  config = function()
    require("obsidian").setup({
      ui = {
        enable = false,
      },
      workspaces = {
        {
          name = "modalic",
          path = "~/Documents/obsidian/modalic/",
        },
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
        vim.fn.jobstart({ "xdg-open", url })         -- linux
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
      notes_subdir = "modalic",
      new_notes_location = "notes_subdir",
      log_level = vim.log.levels.INFO,
      open_notes_in = "vsplit",
      note_id_func = function(title)
        return title
      end,
    })
  end
}
