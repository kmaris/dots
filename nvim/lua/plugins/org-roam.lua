return {
  "chipsenkbeil/org-roam.nvim",
  lazy = false,
  dependencies = {
    "nvim-orgmode/orgmode",
    main = "orgmode",
    opts = {
      org_directory = "~/org",
      org_agenda_files = { "~/org/**/*.org" },
      org_default_notes_file = "~/org/refile.org",
      org_log_done = "time",
      org_log_into_drawer = "LOGBOOK",
      org_todo_keywords = {
        "TODO(t)",
        "PROJ(p)",
        "LOOP(l)",
        "STRT(s)",
        "WAIT(w)",
        "HOLD(h)",
        "IDEA(i)",
        "|",
        "DONE(d)",
        "KILL(k)",
      },
    },
  },
  config = function()
    require("org-roam").setup({
      directory = "~/org",
      org_files = {
        "~/org/daily"
      }
    })
  end,
}

