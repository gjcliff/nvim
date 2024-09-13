local function create_note_with_template(opts)
    -- Prompt the user for the note title
    local title = opts.args
    title = title:gsub('"', '\\"') -- Escape double quotes

    if title == "" then
        print("Task title cannot be empty")
        return
    end

    -- Define the directory where notes are stored (optional)
    -- local notes_dir = "~/Documents/obsidian/oceancomm/Oceancomm" -- Update as needed

    -- Create a link in the current file
    vim.cmd("normal! O")
    local link = string.format("[[@{%s} %s]]", os.date("%Y-%m-%d", os.time()), title)
    vim.api.nvim_put({ link }, 'c', true, true) -- Insert the link at cursor position

    -- Create the note with the specific template
    local command = string.format(
        'ObsidianNewFromTemplate %s',
        string.format('@{%s} %s.md', os.date("%Y-%m-%d"), title, title)
    )
    vim.cmd(command)
    vim.api.nvim_put({ title }, 'l', true, true) -- Insert the title at the beginning of the note
end
-- Create a Neovim command that runs the function
vim.api.nvim_create_user_command('ObsidianTask', function(opts)
    create_note_with_template(opts)
end, { nargs = 1 })

-- Create a new link from template from highlighted text
vim.api.nvim_create_user_command('ObsidianFromSelection', function()
    -- Get the selected text positions
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local line_start = start_pos[2]
    local line_end = end_pos[2]
    local start_row, start_col = start_pos[2], start_pos[3]
    local end_row, end_col = end_pos[2], end_pos[3]
    -- Get the selected text
    local selected_text = vim.fn.getline(line_start,line_end)
    -- local selected_text = vim.fn.getline(start_row, start_row):sub(start_col, end_col)

    -- Escape quotes in the selected text
    local title = selected_text:gsub('"', '\\"')

    -- Create the note using the template
    local command = string.format(
        'ObsidianNewFromTemplate "@{%s} %s.md"',
        os.date("%Y-%m-%d", os.time()),
        title
    )
    vim.cmd(command)

    -- Create the link to the new note
    local link = string.format("[[%s]]", title)

    -- Replace the selected text with the link
    vim.api.nvim_buf_set_text(0, start_row - 1, start_col - 1, end_row - 1, end_col, { link })
end, {})
