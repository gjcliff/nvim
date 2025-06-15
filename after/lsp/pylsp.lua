return {
    cmd = { "pylsp" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
    telemetry = { enabled = false },
    formatters = {
        ignoreComments = false,
    },
    settings = {
        pylsp = {
            -- configurationSources = { "flake8" },
            plugins = {
                -- formatter options
                black = {
                    enabled = true,
                    line_length = 79,
                    preview = true,
                },
                autopep8 = { enabled = false },
                yapf = { enabled = false },
                -- linter options
                pylint = { enabled = false, executable = "pylint" },
                pyflakes = { enabled = false },
                mccabe = { enabled = false },
                pycodestyle = { enabled = false },
                flake8 = {
                    enabled = false,
                    config = "/home/graham/.config/flake8/setup.cfg",
                },
                ruff = {
                    enabled = true,
                    extendSelect = { "ALL" },
                    format = { "ALL" },
                },
                -- type checker
                pylsp_mypy = { enabled = false },
                -- auto-completion options
                jedi_completion = {
                    enabled = true,
                    fuzzy = true,
                },
                -- import sorting
                pyls_isort = { enabled = true },
            },
        },
    },
}
