-- 核心配置入口
local M = {}

function M.setup()
  -- 加载基础选项
  require("core.options").setup()

  -- 加载按键映射
  require("core.keymaps").setup()
end

M.setup()

return M
