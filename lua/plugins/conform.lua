-- Formatting
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      python = { "black", "isort" },
      cpp = { "clang-format" },
      json = { "prettier" },
      yaml = { "prettier" },
      lua = { "stylua" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)
    vim.keymap.set({ "n", "v" }, "<leader>=", function()
      require("conform").format({ async = true, lsp_fallback = true })
    end, { desc = "Format buffer" })
  end,
}
