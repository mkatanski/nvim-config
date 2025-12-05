return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
          -- Let telescope handle its default mappings for normal mode
        },
      },
      extensions = {
        notify = {
          previewer = false, -- Disable preview to avoid popup issues
        },
      },
    })

    -- Load all telescope extensions in one place to avoid conflicts
    local extensions_to_load = {
      "fzf",
      "notify",
      "dap",
      "git_worktree",
      "media_files",
      "frecency",
      "command_palette"
    }

    -- Note: telescope-docker extension removed due to bugs

    -- Load each extension with error handling
    for _, ext in ipairs(extensions_to_load) do
      local success, err = pcall(telescope.load_extension, ext)
      if not success then
        vim.notify("Failed to load telescope extension: " .. ext .. " - " .. (err or ""), vim.log.levels.WARN)
      end
    end

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
  end,
}
