--[[
require("neo-tree").setup({
  source_selector = {
    winbar = true,
    statusline = false,
    truncation_character = "…", -- character to use when truncating the tab label
  },
})
]]

return {
  "nvim-neo-tree/neo-tree.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    source_selector = {
      winbar = true,
      statusline = false,
      truncation_character = "…", -- character to use when truncating the tab label
    },
    filesystem = {
      hijack_netrw_behavior = "open_current",
      mappings = {
        ["Z"] = "expand_all_nodes",
      }
    }
  }
}

