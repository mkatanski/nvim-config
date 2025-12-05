return {
  "nvim-telescope/telescope-media-files.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require('telescope').setup {
      extensions = {
        media_files = {
          -- File types to preview
          filetypes = {
            "png", "jpg", "jpeg", "gif", "webp", "svg",
            "mp4", "webm", "avi", "mov", "mkv",
            "pdf", "epub",
            "wav", "mp3", "flac", "ogg"
          },
          -- Command to find files (use rg for better performance)
          find_cmd = "rg",
          -- Show hidden files
          hidden = false,
          -- Respect .gitignore
          respect_gitignore = true,
        }
      },
    }

    -- Extension is loaded in main telescope.lua file

    -- Easy to remember keybindings for media files
    vim.keymap.set("n", "<leader>fm", function()
      require('telescope').extensions.media_files.media_files()
    end, { desc = "Find Media Files" })

    -- Additional useful media file operations
    vim.keymap.set("n", "<leader>fM", function()
      require('telescope').extensions.media_files.media_files({
        cwd = vim.fn.expand("~/Pictures"), -- Search in Pictures directory
        hidden = true,
      })
    end, { desc = "Find Media in Pictures" })

    -- Search for specific media types
    vim.keymap.set("n", "<leader>fi", function()
      require('telescope.builtin').find_files({
        find_command = { "rg", "--files", "--type-add", "img:*.{png,jpg,jpeg,gif,webp,svg}", "--type", "img" },
        prompt_title = "Find Images",
      })
    end, { desc = "Find Images Only" })

    vim.keymap.set("n", "<leader>fv", function()
      require('telescope.builtin').find_files({
        find_command = { "rg", "--files", "--type-add", "video:*.{mp4,webm,avi,mov,mkv}", "--type", "video" },
        prompt_title = "Find Videos",
      })
    end, { desc = "Find Videos Only" })
  end,
}