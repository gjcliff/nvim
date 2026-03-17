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
        diagnosticSeverityOverrides = {
          reportArgumentType = "none", -- "none" or "warning"
          reportAttributeAccessIssue = "none",
          reportGeneralTypeIssues = "none",
        },
        diagnosticMode = "openFilesOnly",
        typeCheckingMode = "basic",
      },
    },
  },
}
