return {
  "L3MON4D3/LuaSnip",

  config = function()
    if vim.g.snippets == "luasnip" then
      return
    end

    local ls = require "luasnip"
    local types = require "luasnip.util.types"

    ls.config.set_config {
      -- This tells LuaSnip to remember to keep around the last snippet
      -- You can jump back into it even if you move outside of the selection
      -- history = true,
      keep_roots = true,
      link_roots = true,
      link_children = true,

      -- treesitter-hl has 100, use something higher (default is 200).
      ext_base_prio = 300,
      ext_prio_increase = 1,
      store_selection_keys = "<Tab>",

      --this one is cool cause if you have dynamic snippets, it updates as you
      --type!
      updateevents = "TextChanged,TextChangedI",

      -- Autosnippets:
      enable_autosnippets = true,

      -- Crazy highlights!
      -- ext_opts = nil,
      delete_check_events = "TextChanged",
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { "choiceNode", "Comment" } },
          },
        },
      },
      ft_func = function()
        return vim.split(vim.bo.filetype, ".", true)
      end
    }

    vim.keymap.set({ "i", "s" }, "<c-k>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, { silent = true })

    vim.keymap.set({ "i", "s" }, "<c-j>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { silent = true })

    vim.keymap.set({ "i", "s" }, "<c-l>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end)

    vim.keymap.set("n", "<leader><leader>s",
      "<cmd>source ~/.config/nvim/lua/graham/lazy/luasnip.lua<CR>")

    local snippet_path = vim.fn.stdpath("config") .. "/lua/graham/snippets"
    ls.cleanup()
    require("luasnip.loaders.from_lua").load({ paths = snippet_path, clean = true })
  end
}
