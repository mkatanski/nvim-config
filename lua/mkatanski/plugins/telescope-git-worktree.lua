return {
  "ThePrimeagen/git-worktree.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("git-worktree").setup({
      change_directory_command = "cd", -- default: "cd"
      update_on_change = true, -- default: true, updates files/buffers when changing worktrees
      update_on_change_command = "e .", -- default: "e .", command to run after changing worktrees
      clearjumps_on_change = true, -- default: true, clears jumps when changing worktrees
      autopush = false, -- default: false, auto push when creating new worktree
    })

    -- Extension is loaded in main telescope.lua file

    -- Easy to remember keybindings for git worktree
    vim.keymap.set("n", "<leader>gw", function()
      require('telescope').extensions.git_worktree.git_worktrees()
    end, { desc = "Git Worktrees" })

    vim.keymap.set("n", "<leader>gW", function()
      require('telescope').extensions.git_worktree.create_git_worktree()
    end, { desc = "Create Git Worktree" })

    -- Note: Hooks functionality removed due to API changes
    -- The basic worktree functionality works without hooks
  end,
}