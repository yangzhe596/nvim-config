-- Core UI
return {
  "echasnovski/mini.nvim",
  version = false,
  lazy = false,
  priority = 1000,
  config = function()
    require("mini.icons").setup()
  end,
}
