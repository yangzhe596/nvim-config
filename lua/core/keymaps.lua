-- 通用按键映射
local M = {}

function M.setup()
  -- 基础按键映射
  vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
  vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save" })
  vim.keymap.set("n", "<leader>/", ":nohlsearch<CR>", { desc = "Clear search highlight" })

  -- Git 相关按键映射
  vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>", { desc = "Git blame line" })
  vim.keymap.set("n", "<leader>gbl", ":Gitsigns blame<CR>", { desc = "Git blame full" })
end

return M
