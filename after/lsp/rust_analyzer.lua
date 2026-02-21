return {
  -- cmd = { "rust-analyzer" },

  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = true,
      },
    },
  },
}
-- return {
--   cmd = { "rust-analyzer" },
--   settings = {
--     ["rust-analyzer"] = {
--       cargo = {
--         allTargets = false,
--         allFeatures = false,               -- don’t pull in every optional dep
--         -- features = { "lite" },
--         buildScripts = { enable = false }, -- skip build.rs analysis
--       },
--       checkOnSave = true,
--       procMacro = { enable = true }, -- big memory saver if you can live without it
--       files = {
--         excludeDirs = { ".git", "target", "build" },
--         watcher = "client", -- smaller memory footprint
--       },
--       lruCapacity = 64,     -- cap cache size
--       diagnostics = { enable = true },
--     },
--   },
-- }
