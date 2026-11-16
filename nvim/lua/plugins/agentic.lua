return {
  "carlos-algms/agentic.nvim",

  --- @type agentic.PartialUserConfig
  opts = {
    -- Any ACP-compatible provider works. Built-in: "claude-agent-acp" | "gemini-acp" | "codex-acp" | "opencode-acp" | "cursor-acp" | "copilot-acp" | "auggie-acp" | "mistral-vibe-acp" | "cline-acp" | "goose-acp" | "kiro-acp" | "pi-acp"
    provider = "codex-acp", -- setting the name here is all you need to get started
    acp_providers = {
      ["codex-acp"] = {
        command = "ssh",
        args = {
          "-T",
          "srv-sandbox",
          "~/.local/bin/mise",
          "exec",
          "--",
          "codex-acp",
        },
      },
    },
  },

  -- these are just suggested keymaps; customize as desired
  keys = {
    {
    "<leader>aa",
    function()
      require("agentic").toggle()
    end,
    desc = "Agent: toggle chat",
    },
    {
      "<leader>ac",
      function()
        require("agentic").add_selection_or_file_to_context()
      end,
      mode = { "n", "x" },
      desc = "Agent: add file or selection",
    },
    {
      "<leader>an",
      function()
        require("agentic").new_session()
      end,
      desc = "Agent: new session",
    },
    {
      "<leader>ar",
      function()
        require("agentic").restore_session()
      end,
      desc = "Agent: restore session",
    },
    {
      "<leader>ax",
      function()
        require("agentic").stop_generation()
      end,
      desc = "Agent: stop generation",
    },
    {
      "<leader>ap",
      function()
        require("agentic").switch_provider()
      end,
      desc = "Agent: switch provider",
    },
    {
      "<leader>ad",
      function()
        require("agentic").add_current_line_diagnostics()
      end,
      desc = "Agent: add line diagnostics",
    },
    {
      "<leader>aD",
      function()
        require("agentic").add_buffer_diagnostics()
      end,
      desc = "Agent: add buffer diagnostics",
    },
    {
      "<leader>a<space>",
      function()
        require("agentic").rotate_layout()
      end,
      desc = "Agent: rotate layout",
    },
    {
      "<leader>at",
      function()
        vim.cmd("tabnew")
        require("agentic").open({ auto_add_to_context = false })
      end,
      desc = "Agentic Chat in New Tab",
    },
  },
}
