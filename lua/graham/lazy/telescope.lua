return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  requires = { { "nvim-lua/plenary.nvim" } },
  config = function()
    local builtin = require('telescope.builtin')
    local telescope = require('telescope')

    vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
    vim.keymap.set('n', '<C-p>', builtin.git_files, {})
    vim.keymap.set('n', '<leader>ps', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") });
    end)

    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find buffers" })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = "Find keymaps" })
    vim.keymap.set('n', '<leader>fo', builtin.vim_options,
      { desc = "Find options" })

    vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find,
      { desc = "Search in buffer" })

    vim.keymap.set('n', '<leader>gc', builtin.git_commits,
      { desc = "Git commits" })
    vim.keymap.set('n', '<leader>gC', builtin.git_bcommits,
      { desc = "Git buffer commits" })
    vim.keymap.set('n', '<leader>gb', builtin.git_branches,
      { desc = "Git branches" })

    vim.keymap.set('n', 'gd', builtin.lsp_definitions,
      { desc = "LSP definitions" })
    vim.keymap.set('n', 'gr', function()
      builtin.lsp_references()
    end, { desc = "LSP: [G]oto [R]eferences" });
    vim.keymap.set('n', 'gi', builtin.lsp_implementations,
      { desc = "LSP implementations" })
    vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols,
      { desc = "Document symbols" })
    vim.keymap.set('n', '<leader>ws', builtin.lsp_workspace_symbols,
      { desc = "Workspace symbols" })
    vim.keymap.set('n', '<leader>D', builtin.diagnostics,
      { desc = "Diagnostics" })


    vim.keymap.set('n', 'gd', function()
      builtin.lsp_definitions() -- Trigger Telescope LSP definitions
    end, { desc = "Telescope: Go to Definition" })

    -- vim.keymap.set('n', 'gI', function()
    --   builtin.lsp_implementations()
    -- end, { desc = "LSP: [G]oto [I]mplementation" });
    -- Setup Telescope with better defaults
    telescope.setup({
      defaults = {
        -- Better layout
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = {
            preview_width = 0.55,
            results_width = 0.8,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        -- Better sorting
        file_ignore_patterns = { "node_modules", ".git/", "dist/", "build/" },
        -- Case-smart searching
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case'
        },
      },
      pickers = {
        find_files = {
          hidden = true, -- show hidden files
        },
        git_commits = {
          -- Custom mappings for commits (we'll enhance this!)
        },
      },
    })
  end
}
