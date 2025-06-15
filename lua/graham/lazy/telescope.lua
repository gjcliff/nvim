return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    requires = { { "nvim-lua/plenary.nvim" } },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") });
        end)

        vim.keymap.set('n', 'gr', function()
            builtin.lsp_references()
        end, { desc = "LSP: [G]oto [R]eferences" });

        -- vim.keymap.set('n', 'gd', function()
        --     builtin.lsp_definitions()  -- Trigger Telescope LSP definitions
        -- end, { desc = "Telescope: Go to Definition" })

        vim.keymap.set('n', 'gI', function()
            builtin.lsp_implementations()
        end, { desc = "LSP: [G]oto [I]mplementation" });
    end
}
