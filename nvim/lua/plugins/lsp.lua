-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  {
    "nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false,
        signs = true,
      },
    },
  },
}
