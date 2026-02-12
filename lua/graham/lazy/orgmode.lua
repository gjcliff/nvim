return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  ft = { 'org' },
  config = function()
    -- setup orgmode
    require('orgmode').setup({
      org_agenda_files = { '~/Documents/orgfiles/**/*' },
      org_default_notes_file = '~/Documents/orgfiles/refile.org',
      org_capture_templates = {
        t = {
          description = 'Task',
          template = '* TODO %?\n',
          target = '~/Documents/orgfiles/refile.org',
        },
        j = {
          description = 'Journal',
          template = '* %<%Y-%m-%d %a>\n  %?',
          target = '~/Documents/orgfiles/journal.org',
          headline = 'Journal',
        },
        n = {
          description = 'Note',
          template = '* %?\n  %<%Y-%m-%d %a>',
          target = '~/Documents/orgfiles/notes.org',
        },
        d = {
          description = 'Daily',
          template = '* %<%Y-%m-%d %a>\n  %?',
          target = '~/Documents/orgfiles/notes.org',
        },
      },
    })

    -- experimental lsp support
    vim.lsp.enable('org')
  end,
}
