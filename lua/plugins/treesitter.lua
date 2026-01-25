-- Syntax highlighting
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    ensure_installed = { "json", "yaml", "lua", "python", "cpp", "c" },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
    fold = {
      enable = true,
    },
  },
  config = function(_, opts)
    local status, treesitter = pcall(require, "nvim-treesitter.configs")
    if status then
      treesitter.setup(opts)
    else
      vim.notify("nvim-treesitter not loaded yet", vim.log.levels.WARN)
    end
  end,
}
