-- LSP keymaps
local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- Keymaps for LSP
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, opts)

  -- Diagnostics
  vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, opts)
end

-- Setup LSP servers using new vim.lsp.config API (Neovim 0.11+)
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Python (pyright)
vim.lsp.config.pyright = {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
}

-- C/C++ (clangd) - Enhanced configuration for Bazel projects
vim.lsp.config.clangd = {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    "clangd-18",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--header-insertion=iwyu",
    "--all-scopes-completion",
    "--log=error",
    "--pretty",
    "--limit-results=100",
    "--limit-references=1000",
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  root_dir = function(fname)
    return vim.fs.dirname(vim.fs.find({ "WORKSPACE", "MODULE.bazel", ".bazelrc" }, {
      path = vim.fs.dirname(fname),
      upward = true,
    })[1])
  end,
  settings = {
    clangd = {
      semanticHighlighting = true,
      compilationDatabaseSearchPaths = {
        ".",
        "build",
        "bazel-bin",
        "bazel-out",
        "bazel-mipilot_root",
      },
      fallbackFlags = {
        "-std=c++17",
        "-I/usr/include",
        "-I/usr/local/include",
        "-I/home/yz/code/mipilot_root",
        "-I/home/yz/code/mipilot_root/mipilot/proto",
        "-I/home/yz/code/mipilot_root/mipilot/eng/simulation",
        "-I/home/yz/code/mipilot_root/mipilot/modules",
      },
      index = {
        background = true,
      },
      diagnostics = {
        enable = true,
        suppress = {
          "unused_private_field",
          "unused_variable",
          "unused_function",
        },
      },
    },
  },
}

-- YAML
vim.lsp.config.yamlls = {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "yaml", "yml" },
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/yaml-language-server", "--stdio" },
  settings = {
    yaml = {
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
      hover = true,
      completion = true,
      validate = true,
    },
  },
}

-- Lua (for Neovim config)
vim.lsp.config.lua_ls = {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "lua" },
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/lua-language-server" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          "${3rd}/luv/library",
        },
      },
      completion = { callSnippet = "Replace" },
      telemetry = { enable = false },
    },
  },
}

-- Enable all configured LSP servers
vim.lsp.enable("pyright")
vim.lsp.enable("clangd")
vim.lsp.enable("yamlls")
vim.lsp.enable("lua_ls")

-- Diagnostics configuration
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- Folding configuration
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevelstart = 99
vim.opt.foldnestmax = 10
vim.opt.foldminlines = 1

-- Enhanced folding for JSON files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  callback = function()
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.opt_local.foldlevel = 99
    vim.opt_local.foldenable = true
  end,
})
