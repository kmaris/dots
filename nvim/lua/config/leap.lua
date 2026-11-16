-- See `:h leap-mappings`, `:h leap.visit-mappings` for more.

-- Jump
vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
vim.keymap.set("n", "S", "<Plug>(leap-from-window)")

-- Visit (jump - operate - jump back)
vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-visit)")
vim.keymap.set({ "x", "o" }, "ar", "<Plug>(leap-visit-text-object)")
vim.keymap.set({ "x", "o" }, "ir", "<Plug>(leap-visit-inner-text-object)")

vim.keymap.set("o", "rr", function() -- "visit line" shortcut
  return (vim.v.count == 0 and "1" or "") .. "<Plug>(leap-visit)"
end, { expr = true })

vim.api.nvim_create_autocmd("User", { -- automatic paste on return
  pattern = "VisitDone",
  group = vim.api.nvim_create_augroup("Visit", {}),
  callback = function(event)
    if (event.data.mode:match("^[vV\22]") or (vim.v.operator == "y")) and event.data.register == '"' then
      vim.cmd("normal! p")
    end
  end,
})

-- Treeselect
vim.keymap.set({ "x", "o" }, "an", function()
  require("leap.treesitter").select({
    opts = require("leap.user").with_traversal_keys("n", "N"),
  })
end)
