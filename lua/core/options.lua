-- Vim 基础选项配置
local M = {}

function M.setup()
  -- Leader 键设置
  vim.g.mapleader = " "
  vim.g.maplocalleader = "\\"

  -- 编辑器选项
  vim.opt.number = true
  vim.opt.relativenumber = true
  vim.opt.tabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.expandtab = true
  vim.opt.smartindent = true
  vim.opt.ignorecase = true
  vim.opt.smartcase = true
  vim.opt.cursorline = true
  vim.opt.termguicolors = true
  vim.opt.completeopt = "menu,menuone,noselect"
  vim.opt.clipboard = "unnamedplus"
end

return M
