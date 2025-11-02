-- ============================================================================
-- Custom Functions
-- ============================================================================

local function create_note_with_template(opts)
  local title = opts.args:gsub('"', '\\"')
  if title == "" then
    print("Task title cannot be empty")
    return
  end

  vim.cmd("normal! O")
  local link = string.format("@{%s} %s", os.date("%Y-%m-%d"), title)
  vim.api.nvim_put({ link }, "c", true, true)
  vim.cmd("normal! V")
  vim.cmd("ObsidianLinkNew")
  vim.cmd("normal! l")
  vim.defer_fn(function()
    vim.cmd("normal! d0")
  end, 1)
end

local function create_journal_entry()
  -- local link = string.format("[[%s]]", os.date("%Y-%m-%d"))
  -- vim.api.nvim_put({ link }, "c", true, true)
  local command = string.format("ObsidianNewFromTemplate %s.md",
    os.date("%Y-%m-%d"))
  vim.cmd(command)
  -- vim.api.nvim_put({ os.date("%Y-%m-%d") }, "l", true, true)
  -- vim.cmd("write")
  -- vim.cmd("normal! <C-o>")
end

local function create_link_to_index()
  local link = "[[Index]]"
  vim.api.nvim_put({ link }, "c", true, true)
end

local function create_daily_note()
  local link = string.format("[[%s]]", os.date("%Y-%m-%d"))
  vim.api.nvim_put({ link }, "c", true, true)
  vim.cmd("ObsidianToday")
end

-- Register custom commands
vim.api.nvim_create_user_command("ObsidianTask", create_note_with_template,
  { nargs = 1 })
vim.api.nvim_create_user_command("ObsidianJournal", create_journal_entry, {})
vim.api.nvim_create_user_command("ObsidianIndex", create_link_to_index, {})
vim.api.nvim_create_user_command("ObsidianDailyNote", create_daily_note, {})

-- ============================================================================
-- Plugin Configuration
-- ============================================================================

return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  cmd = {
    "ObsidianOpen",
    "ObsidianNew",
    "ObsidianQuickSwitch",
    "ObsidianToday",
    "ObsidianYesterday",
    "ObsidianTomorrow",
    "ObsidianDailies",
    "ObsidianSearch",
    "ObsidianLink",
    "ObsidianLinkNew",
    "ObsidianWorkspace",
    "ObsidianBacklinks",
    "ObsidianTags",
    "ObsidianTemplate",
    "ObsidianNewFromTemplate",
  },
  keys = {
    -- Workspace switching
    { "<leader>ow",  "<cmd>ObsidianWorkspace<CR>",   desc = "Switch workspace" },

    -- Quick navigation
    { "<leader>oq",  "<cmd>ObsidianQuickSwitch<CR>", desc = "Quick switch to note" },
    { "<leader>os",  "<cmd>ObsidianSearch<CR>",      desc = "Search notes" },
    { "<leader>ob",  "<cmd>ObsidianBacklinks<CR>",   desc = "Show backlinks" },

    -- Daily notes
    { "<leader>od",  "<cmd>ObsidianToday<CR>",       desc = "Today's note" },
    { "<leader>oy",  "<cmd>ObsidianYesterday<CR>",   desc = "Yesterday's note" },
    { "<leader>om",  "<cmd>ObsidianTomorrow<CR>",    desc = "Tomorrow's note" },

    -- Link management
    { "<leader>ol",  "<cmd>ObsidianLink<CR>",        mode = { "n", "v" },          desc = "Link to note" },
    { "<leader>on",  "<cmd>ObsidianLinkNew<CR>",     mode = { "n", "v" },          desc = "Create linked note" },

    -- Templates
    { "<leader>ote", "<cmd>ObsidianTemplate<CR>",    desc = "Insert template" },

    -- Special notes (workspace-aware)
    {
      "<leader>oo",
      function()
        local client = require("obsidian").get_client()
        vim.cmd("edit " .. client.dir.filename .. "/Index.md")
      end,
      desc = "Open Index",
    },
    {
      "<leader>ot",
      function()
        local client = require("obsidian").get_client()
        vim.cmd("edit " .. client.dir.filename .. "/Tasks.md")
      end,
      desc = "Open Tasks",
    },
    {
      "<leader>oj",
      function()
        local client = require("obsidian").get_client()
        vim.cmd("edit " .. client.dir.filename .. "/Job Search.md")
      end,
      desc = "Open Job Search",
    },
    {
      "<leader>ok",
      function()
        local client = require("obsidian").get_client()
        vim.cmd("edit " .. client.dir.filename .. "/Knowledge Base.md")
      end,
      desc = "Open Knowledge Base",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },

  config = function()
    require("obsidian").setup({
      -- UI Configuration
      ui = {
        enable = true,
        update_debounce = 200,
        max_file_length = 5000,
        checkboxes = {
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { char = "", hl_group = "ObsidianDone" },
          [">"] = { char = "", hl_group = "ObsidianRightArrow" },
          ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
        },
      },

      -- Workspaces
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

      -- Daily Notes Configuration
      daily_notes = {
        date_format = "%Y-%m-%d",
        alias_format = "%B %-d, %Y",
      },

      -- Completion
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },

      -- Buffer Mappings (only active in markdown files)
      mappings = {
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        ["<leader>ch"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
        ["<cr>"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
      },

      -- Picker Configuration
      picker = {
        name = "telescope.nvim",
        note_mappings = {
          new = "<C-x>",
          insert_link = "<C-l>",
        },
        tag_mappings = {
          tag_note = "<C-x>",
          insert_tag = "<C-l>",
        },
      },

      -- URL Handler
      follow_url_func = function(url)
        vim.fn.jobstart({ "xdg-open", url })
      end,

      -- Templates
      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        default_template = "Default.md",
        substitutions = {
          yesterday = function()
            return os.date("%Y-%m-%d", os.time() - 86400)
          end,
          tomorrow = function()
            return os.date("%Y-%m-%d", os.time() + 86400)
          end,
        },
      },

      -- Behavior
      log_level = vim.log.levels.INFO,
      open_notes_in = "current", -- Changed from vsplit
      sort_by = "modified",
      sort_reversed = true,

      -- Note Naming
      note_id_func = function(title)
        return title
      end,

      -- Link Style
      preferred_link_style = "wiki",
    })
  end,
}
