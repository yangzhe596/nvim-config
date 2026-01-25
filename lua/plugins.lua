-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim with plugins
require("lazy").setup({
  spec = {
    { import = "plugins.tokyonight" },
    { import = "plugins.mini" },
    { import = "plugins.autopairs" },
    { import = "plugins.comment" },
    { import = "plugins.gitsigns" },
    { import = "plugins.neo-tree" },
    { import = "plugins.telescope" },
    { import = "plugins.treesitter" },
    { import = "plugins.conform" },
    { import = "plugins.mason" },
    { import = "plugins.fidget" },
    { import = "plugins.cmp" },
    { import = "plugins.rainbow-delimiters" },
  },
  defaults = {
    lazy = false,
  },
})
