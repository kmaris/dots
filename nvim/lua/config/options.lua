-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.autoformat = false
vim.opt.formatoptions:remove({ "r", "o" })
vim.opt.textwidth = 80
-- I generally dislike automatic folding unless I manually start using it
vim.opt.foldenable = false
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    vim.cmd("silent! %foldopen!")
  end,
})
