return {
    cmd = { "diagnostic-languageserver", "--stdio" },
    filetypes = { "python" },
    root_markers = { '.git' },
    init_options = {
        documentFormatting = true,
        formatters = {
            black = {
                command = "black",
                args = { "-" },
                -- rootPatterns = { "pyproject.toml" },
                isStdout = true,
                requiresFile = false,
            },
        },
        formatFiletypes = {
            python = "black",
        },
    },
}
