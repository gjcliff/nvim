-- ============================================================================
-- Custom Functions
-- ============================================================================

-- Helper: Get next Friday from a given date
local function get_next_friday(from_date)
  from_date = from_date or os.time()
  local day_of_week = tonumber(os.date("%w", from_date)) -- 0=Sunday, 5=Friday
  local days_until_friday = (5 - day_of_week) % 7
  if days_until_friday == 0 then
    days_until_friday = 7 -- If today is Friday, get next Friday
  end
  return os.date("%Y-%m-%d", from_date + (days_until_friday * 86400))
end

-- Helper: Get Monday of current week
local function get_week_start()
  local now = os.time()
  local day_of_week = tonumber(os.date("%w", now))
  local days_since_monday = (day_of_week - 1) % 7
  if day_of_week == 0 then -- Sunday
    days_since_monday = 6
  end
  return os.date("%Y-%m-%d", now - (days_since_monday * 86400))
end

-- Create task with due date and long-running flag
local function create_task_with_metadata(opts)
  local args = vim.split(opts.args, "|")
  local title = args[1] and args[1]:gsub('"', '\\"') or ""
  local due_date = args[2] or get_next_friday()
  local is_long_running = args[3] == "true" or args[3] == "t"

  if title == "" then
    print("Task title cannot be empty")
    return
  end

  vim.cmd("normal! O")
  local flag = is_long_running and " #long-running" or ""
  local link = string.format("[[@{%s} %s]]%s 📅 %s", os.date("%Y-%m-%d"), title,
    flag, due_date)
  vim.api.nvim_put({ link }, "c", true, true)
  vim.cmd("normal! V")
  vim.cmd("ObsidianLinkNew")
  vim.cmd("normal! l")
  vim.defer_fn(function()
    vim.cmd("normal! d0")
  end, 1)
end

-- Original simple task function (keeping for compatibility)
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

-- Refresh tasks in weekly note
local function refresh_weekly_tasks()
  local current_file = vim.fn.expand("%:t")

  -- Validate we're in a weekly note
  if not current_file:match("^Week%-") then
    print("Not in a weekly note")
    return
  end

  local week_start = current_file:match("Week%-(%d%d%d%d%-%d%d%-%d%d)")
  if not week_start then
    print("Could not parse week date from filename")
    return
  end

  -- Read and parse tasks
  local client = require("obsidian").get_client()
  local task_file = io.open(client.dir.filename .. "/Tasks.md", "r")
  if not task_file then
    print("Could not open Tasks.md")
    return
  end

  local content = task_file:read("*all")
  task_file:close()

  -- Calculate week boundaries
  local year, month, day = tonumber(week_start:sub(1, 4)) or 0,
      tonumber(week_start:sub(6, 7)) or 0,
      tonumber(week_start:sub(9, 10)) or 0
  local week_start_time = os.time({ year = year, month = month, day = day, hour = 0 })
  local week_end_time = week_start_time + (6 * 86400)

  -- Filter tasks
  local weekly_tasks, long_running_tasks = {}, {}
  for line in content:gmatch("[^\r\n]+") do
    local date_str = line:match("%[%[@{([%d-]+)}%s+")
    if date_str then
      local task_time = os.time({
        year = tonumber(date_str:sub(1, 4)) or 0,
        month = tonumber(date_str:sub(6, 7)) or 0,
        day = tonumber(date_str:sub(9, 10)) or 0,
        hour = 0
      })

      if line:match("#long%-running") then
        table.insert(long_running_tasks, line)
      elseif task_time >= week_start_time and task_time <= week_end_time then
        table.insert(weekly_tasks, line)
      end
    end
  end

  -- Build new tasks section
  local new_section = { "## Tasks", "", "### Due This Week" }
  if #weekly_tasks > 0 then
    vim.list_extend(new_section, weekly_tasks)
  else
    table.insert(new_section, "_No tasks due this week_")
  end

  table.insert(new_section, "")
  table.insert(new_section, "### Long Running")

  if #long_running_tasks > 0 then
    vim.list_extend(new_section, long_running_tasks)
  else
    table.insert(new_section, "_No long-running tasks_")
  end

  table.insert(new_section, "")
  table.insert(new_section, "[[Tasks|View All Tasks]]")

  -- Find Tasks section boundaries
  local buf_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local tasks_start, tasks_end

  for i, line in ipairs(buf_lines) do
    if line:match("^## Tasks$") then
      tasks_start = i
    elseif tasks_start and line:match("^##%s") then
      tasks_end = i - 1
      break
    end
  end

  if not tasks_start then
    print("Could not find Tasks section")
    return
  end

  tasks_end = tasks_end or #buf_lines

  -- Extract current tasks section
  local current_section = {}
  for i = tasks_start, tasks_end do
    table.insert(current_section, buf_lines[i])
  end

  -- Only update if changed
  if table.concat(current_section, "\n") ~= table.concat(new_section, "\n") then
    vim.api.nvim_buf_set_lines(0, tasks_start - 1, tasks_end, false, new_section)
    print("Weekly tasks refreshed!")
  else
    print("Tasks already up to date")
  end
end

-- Create weekly note with initial tasks
-- Create weekly note directly (no template)
local function create_weekly_note()
  local week_start = get_week_start()
  local filename = string.format("Week-%s.md", week_start)

  local client = require("obsidian").get_client()
  local note_path = client.dir.filename .. "/" .. filename

  -- Check if note already exists
  local file = io.open(note_path, "r")
  if file then
    file:close()
    vim.cmd("edit " .. note_path)
    print("Weekly note already exists, opening...")
    vim.defer_fn(refresh_weekly_tasks, 100)
    return
  end

  -- Parse week_start date
  local year = tonumber(week_start:sub(1, 4)) or 0
  local month = tonumber(week_start:sub(6, 7)) or 0
  local day = tonumber(week_start:sub(9, 10)) or 0

  -- Create note with initial structure
  local week_display = os.date("%B %d, %Y", os.time({
    year = year,
    month = month,
    day = day
  }))

  local content = {
    "---",
    "id: " .. filename:gsub("%.md$", ""),
    "aliases: []",
    "tags:",
    "  - weekly",
    "date: \"" .. os.date("%Y-%m-%d") .. "\"",
    "week: Week of " .. week_start,
    "---",
    "",
    "# Week of " .. week_display,
    "",
    "## Tasks",
    "",
    "### Due This Week",
    "_No tasks due this week_",
    "",
    "### Long Running",
    "_No long-running tasks_",
    "",
    "[[Tasks|View All Tasks]]",
    "",
    "---",
    "",
    "## Notes",
    "",
    "## Goals",
    "",
    "## Reflections",
  }

  -- Write file
  local new_file = io.open(note_path, "w")
  if new_file then
    new_file:write(table.concat(content, "\n"))
    new_file:close()
    vim.cmd("edit " .. note_path)
    -- Refresh tasks immediately
    vim.defer_fn(refresh_weekly_tasks, 100)
    print("Weekly note created!")
  else
    print("Error creating weekly note")
  end
end

-- Get tasks for current week
-- Get tasks for current week
local function get_weekly_tasks()
  local client = require("obsidian").get_client()
  local tasks_path = client.dir.filename .. "/Tasks.md"

  local week_start = get_week_start()

  -- Parse week_start string properly
  local year = tonumber(week_start:sub(1, 4)) or 0
  local month = tonumber(week_start:sub(6, 7)) or 0
  local day = tonumber(week_start:sub(9, 10)) or 0

  local week_start_time = os.time({
    year = year,
    month = month,
    day = day,
    hour = 0,
    min = 0,
    sec = 0
  })

  local week_end_time = week_start_time + (6 * 86400)

  -- Read tasks file and filter by date
  local file = io.open(tasks_path, "r")
  if not file then
    print("Could not open Tasks.md")
    return
  end

  local content = file:read("*all")
  file:close()

  local weekly_tasks = {}
  local long_running_tasks = {}

  -- Parse tasks
  for line in content:gmatch("[^\r\n]+") do
    local date_str, task = line:match("%[%[@{([%d-]+)}%s+(.-)%]%]")
    if date_str and task then
      local task_year = tonumber(date_str:sub(1, 4)) or 0
      local task_month = tonumber(date_str:sub(6, 7)) or 0
      local task_day = tonumber(date_str:sub(9, 10)) or 0

      local task_time = os.time({
        year = task_year,
        month = task_month,
        day = task_day,
        hour = 0,
        min = 0,
        sec = 0
      })

      -- Check if task has #long-running flag
      local is_long_running = line:match("#long%-running")

      if is_long_running then
        table.insert(long_running_tasks, line)
      elseif task_time >= week_start_time and task_time <= week_end_time then
        table.insert(weekly_tasks, line)
      end
    end
  end

  -- Display results
  local results = {}
  if #weekly_tasks > 0 then
    table.insert(results, "=== Due This Week ===")
    for _, task in ipairs(weekly_tasks) do
      table.insert(results, task)
    end
  end

  if #long_running_tasks > 0 then
    table.insert(results, "")
    table.insert(results, "=== Long Running ===")
    for _, task in ipairs(long_running_tasks) do
      table.insert(results, task)
    end
  end

  if #results == 0 then
    print("No tasks for this week")
    return
  end

  -- Show in a floating window or use telescope
  vim.api.nvim_echo({ { table.concat(results, "\n"), "Normal" } }, false, {})
end

local function create_journal_entry()
  local command = string.format("ObsidianNewFromTemplate %s.md",
    os.date("%Y-%m-%d"))
  vim.cmd(command)
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
vim.api.nvim_create_user_command("ObsidianTaskNew", create_task_with_metadata,
  { nargs = 1 })
vim.api.nvim_create_user_command("ObsidianWeekly", create_weekly_note, {})
vim.api.nvim_create_user_command("ObsidianWeeklyTasks", get_weekly_tasks, {})
vim.api.nvim_create_user_command("ObsidianWeeklyRefresh", refresh_weekly_tasks,
  {})
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
    { "<leader>oW",  "<cmd>ObsidianWorkspace<CR>",     desc = "Switch workspace" },
    --
    { "<leader>ow",  "<cmd>ObsidianWeekly<CR>",        desc = "Open/create weekly note" },
    { "<leader>owt", "<cmd>ObsidianWeeklyTasks<CR>",   desc = "View weekly tasks" },
    { "<leader>owr", "<cmd>ObsidianWeeklyRefresh<CR>", desc = "Refresh weekly tasks" },

    -- Quick navigation
    { "<leader>oq",  "<cmd>ObsidianQuickSwitch<CR>",   desc = "Quick switch to note" },
    { "<leader>os",  "<cmd>ObsidianSearch<CR>",        desc = "Search notes" },
    { "<leader>ob",  "<cmd>ObsidianBacklinks<CR>",     desc = "Show backlinks" },

    -- Daily notes
    { "<leader>od",  "<cmd>ObsidianToday<CR>",         desc = "Today's note" },
    { "<leader>oy",  "<cmd>ObsidianYesterday<CR>",     desc = "Yesterday's note" },
    { "<leader>om",  "<cmd>ObsidianTomorrow<CR>",      desc = "Tomorrow's note" },

    -- Link management
    { "<leader>ol",  "<cmd>ObsidianLink<CR>",          mode = { "n", "v" },             desc = "Link to note" },
    { "<leader>on",  "<cmd>ObsidianLinkNew<CR>",       mode = { "n", "v" },             desc = "Create linked note" },

    -- Templates
    { "<leader>ote", "<cmd>ObsidianTemplate<CR>",      desc = "Insert template" },

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
          name = "remodel",
          path = "~/Documents/obsidian/remodel/",
        },
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
      -- templates = {
      --   folder = "templates",
      --   date_format = "%Y-%m-%d",
      --   time_format = "%H:%M",
      --   default_template = "Default.md",
      --   substitutions = {
      --     yesterday = function()
      --       return os.date("%Y-%m-%d", os.time() - 86400)
      --     end,
      --     tomorrow = function()
      --       return os.date("%Y-%m-%d", os.time() + 86400)
      --     end,
      --   },
      -- },
      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        substitutions = {
          yesterday = function()
            return os.date("%Y-%m-%d", os.time() - 86400)
          end,
          tomorrow = function()
            return os.date("%Y-%m-%d", os.time() + 86400)
          end,
          week = function()
            local week_start = os.time()
            local day_of_week = tonumber(os.date("%w", week_start))
            local days_since_monday = (day_of_week - 1) % 7
            if day_of_week == 0 then days_since_monday = 6 end
            local monday = os.date("%Y-%m-%d",
              week_start - (days_since_monday * 86400))
            return "Week of " .. monday
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
