-- LSP 管理器
return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- Setup Mason
    require("mason").setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- Setup Mason LSP Config
    require("mason-lspconfig").setup({
      ensure_installed = {
        "pyright",
        "clangd",
        "yamlls",
        "lua_ls",
      },
      automatic_installation = true,
    })
  end,
}

