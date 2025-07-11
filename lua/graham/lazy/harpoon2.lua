return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        -- local harpoon = require("harpoon")
        local ok, harpoon = pcall(require, "harpoon")
        if not ok then
            return
        end

        -- REQUIRED
        harpoon:setup()
        -- REQUIRED

        vim.keymap.set("n", "<leader>a", function()
            harpoon:list():add()
        end)
        -- vim.keymap.set("n", "<leader>;",
        --     function() local state = require("telescope.actions.state")
        --         local selected_entry = state.get_selected_entry()
        --         harpoon:list():remove(selected_entry)
        -- end)
        vim.keymap.set("n", "<C-e>", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end)

        -- vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
        -- vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
        -- vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
        -- vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)
        -- vim.api.nvim_set_keymap('n', '<C-j>', '', { noremap = true, silent = true })
        -- vim.api.nvim_set_keymap('n', '<C-k>', '', { noremap = true, silent = true })
        -- vim.keymap.set("n", "<C-j>", function() harpoon:list():prev() end, { noremap = true, silent = true } )
        -- vim.keymap.set("n", "<C-k>", function() harpoon:list():next() end, { noremap = true, silent = true } )

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<C-S-P>", function()
            harpoon:list():prev()
        end)
        vim.keymap.set("n", "<C-S-N>", function()
            harpoon:list():next()
        end)

        -- basic telescope configuration
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers")
                .new({}, {
                    prompt_title = "Harpoon",
                    finder = require("telescope.finders").new_table({
                        results = file_paths,
                    }),
                    previewer = conf.file_previewer({}),
                    sorter = conf.generic_sorter({}),
                })
                :find()
        end

        vim.keymap.set("n", "<C-t>", function()
            toggle_telescope(harpoon:list())
        end, { desc = "Open harpoon window" })
    end
}
