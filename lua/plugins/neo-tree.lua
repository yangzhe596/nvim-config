-- File explorer
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer NeoTree" },
    { "<leader>be", "<cmd>Neotree toggle buffers<cr>", desc = "Buffer Explorer" },
    { "<leader>ge", "<cmd>Neotree toggle git_status<cr>", desc = "Git Explorer" },
  },
  config = function()
    require("neo-tree").setup({
      filesystem = {
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ["<space>"] = "none",
        },
      },
    })
  end,
}
