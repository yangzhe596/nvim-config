# Mi Code Agent Briefing

## Project Overview
This directory contains a personal Neovim 0.11+ configuration built on the **lazy.nvim** plugin manager. The setup focuses on Python, C/C++, YAML, JSON, and Lua development with first-class LSP, completion, diagnostics, and formatting support. Core goals are fast startup, reproducible plugin installs (via `lazy-lock.json`), and opinionated defaults that mirror the user's workflow.

## Directory Map
- `init.lua` – entry point; loads baseline options, keymaps, plugin specs, and LSP wiring.
- `lua/basic-options.lua` – UI/editor defaults (leader keys, 2-space indentation, relative numbers, clipboard, etc.).
- `lua/keymaps.lua` – global mappings using `vim.keymap.set`; leader shortcuts for quit/save/search clear.
- `lua/plugins.lua` – bootstraps lazy.nvim if missing, then loads all plugin specs from `lua/plugins/`.
- `lua/lsp.lua` – central LSP setup using `vim.lsp.config` + `vim.lsp.enable`; defines keymaps, diagnostics, folds.
- `lua/plugins/*.lua` – one file per plugin (autopairs, Comment.nvim, Conform, Gitsigns, Mason/CMP, etc.); each returns a lazy spec table.
- `lazy-lock.json` – lockfile that pins plugin commits; keep it under version control to ensure reproducible installs.

## Tooling & Dependencies
- **Plugin manager:** [lazy.nvim](https://github.com/folke/lazy.nvim)
- **LSP & tooling:** mason.nvim + mason-lspconfig manage `pyright`, `clangd`, `yamlls`, `lua_ls`; custom `vim.lsp.config` tables unlock advanced flags (clangd Bazel roots, YAML schema store, Lua runtime hints).
- **Completion:** nvim-cmp + LuaSnip, `cmp-nvim-lsp`, buffer/path sources, Mini icons for LSP kinds.
- **Formatting:** conform.nvim runs formatter chains (Black/Isort, clang-format, prettier, stylua) with `<leader>=` binding and on-save hooks.
- **Git UX:** gitsigns.nvim shows diffs in the gutter with custom symbols.
- **Quality-of-life:** nvim-autopairs, Comment.nvim, fidget.nvim indicators, rainbow delimiters, neo-tree, telescope, etc. (see `lua/plugins/`).

## Common Workflows
1. **Bootstrap / Update Plugins**
   - First run: open Neovim or run `nvim --headless '+Lazy! sync' +qa` to clone lazy.nvim and all specs.
   - To update: `nvim --headless '+Lazy update' +qa`; review `lazy-lock.json` diffs before committing.

2. **Manage Language Servers**
   - Mason auto-installs the servers listed in `ensure_installed`. Manually trigger refresh with `nvim --headless '+MasonUpdate' +qa`.
   - clangd is customized for Bazel roots and uses `clangd-18`. Ensure that binary is on PATH.

3. **Adjust Keymaps / Options**
   - Place general editor tweaks in `lua/basic-options.lua` and `lua/keymaps.lua` for clarity.
   - For plugin-specific mappings, define them inside the plugin's `config` block so lazy.nvim loads them lazily.

4. **Add or Modify Plugins**
   - Create a new file under `lua/plugins/<name>.lua` returning a spec table. Keep configuration inline via `config = function()`.
   - Register dependencies within the spec when needed (e.g., mason.nvim pulls in cmp + fidget).
   - Update docs in `AGENTS.md` if the addition changes workflows.

5. **Formatting & Diagnostics**
   - Use `<leader>=` or `:lua require("conform").format()` for manual formatting; on-save formatting is already enabled with LSP fallback.
   - LSP diagnostics are configured with floating windows, signs, and fold-aware treesitter expressions. Use `<leader>do/dn/dp/dl` for quick triage.

## Development Conventions
- Lua files use two-space indentation, ASCII characters, and `return { ... }` plugin specs.
- Prefer `vim.keymap.set` with descriptive `desc` metadata for discoverability.
- Keep configuration modular: top-level modules should remain thin wrappers around `lua/plugins/*.lua` specs.
- When editing `lua/lsp.lua`, mirror the existing `vim.lsp.config.<server>` pattern and register the server name inside `vim.lsp.enable({ ... })`.
- Document non-obvious settings with short comments; avoid verbose explanations inline.
- Update `lazy-lock.json` only via lazy.nvim commands—do not hand-edit.

## Validation Checklist
- `nvim --headless '+Lazy doctor' +qa` – sanity-check lazy.nvim health after major changes.
- `nvim --headless '+Lazy sync' +qa` – ensure plugin graph resolves and lockfile updates cleanly.
- `nvim --headless '+Mason' +qa` – confirm tool installations and paths.
- `stylua lua` – format Lua modules (mirrors conform's formatter) before committing.
- Open Neovim interactively and verify LSP attachment for Python (`pyright`), C++ (`clangd-18`), YAML (`yamlls`), Lua (`lua_ls`).

## Outstanding Notes / TODOs
- No README is present; this AGENTS guide now serves as the primary documentation—expand it when new languages/plugins are introduced.
- Ensure `clangd-18` and Bazel paths referenced in `lua/lsp.lua` exist on the target machine; adjust commands if the environment changes.
- Keep `plugins/` directory alphabetized/logically grouped to make discovery easier for future agents.
