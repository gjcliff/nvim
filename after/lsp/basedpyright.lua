return {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
    ".git",
  },
  settings = {
    basedpyright = {
      analysis = {
        -- ignorePatterns = { "*.pyi" },
        diagnosticSeverityOverrides = {
          reportArgumentType = "warning", -- or "none" to disable
          reportAttributeAccessIssue = "none",
          -- reportCallIssue = "warning",
          -- reportUnreachable = "warning",
          -- reportUnusedImport = "none",
          -- reportUnusedCoroutine = "warning",
        },
        -- diagnosticMode = "workspace",
        diagnosticMode = "openFilesOnly",
        typeCheckingMode = "basic",
        -- reportCallIssue = "none",
        -- disableOrganizeImports = true,
      },
      -- analysis = {
      --   autoSearchPaths = true,
      --   diagnosticMode = "workspace", -- Changed from default "openFilesOnly" for better protobuf support
      --   useLibraryCodeForTypes = true,
      --   -- Uncomment and adjust if your _pb2.py files are in a non-standard location:
      --   -- extraPaths = { "./path/to/proto/output" },
      -- },
    },
  },
}
