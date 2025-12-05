return {
  "nvim-telescope/telescope-frecency.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "kkharji/sqlite.lua", -- Optional: for persistent storage
  },
  config = function()
    require('telescope').setup {
      extensions = {
        frecency = {
          -- Show unindexed files
          show_unindexed = true,
          -- Ignore patterns (lua patterns)
          ignore_patterns = {
            "*.git/*",
            "*/tmp/*",
            "*/node_modules/*",
            "*/.cache/*",
            "*/build/*",
            "*/dist/*",
          },
          -- Database location for persistence
          db_root = vim.fn.stdpath("data") .. "/frecency",
          -- Show scores in the display
          show_scores = false,
          -- Show filter indicator in prompt
          show_filter_column = true,
          -- Workspace patterns for different projects
          workspaces = {
            ["conf"] = vim.fn.expand("~/.config"),
            ["data"] = vim.fn.expand("~/.local/share"),
            ["project"] = vim.fn.expand("~/Projects"),
            ["wiki"] = vim.fn.expand("~/wiki"),
          },
          -- Default workspace if no match found
          default_workspace = 'CWD',
          -- Disable devicons if you don't want file type icons
          disable_devicons = false,
          -- Use the default telescope configuration
          use_default_telescope_config = true,
        }
      },
    }

    -- Extension is loaded in main telescope.lua file

    -- Easy to remember keybinding for frecency
    vim.keymap.set("n", "<leader>fr", function()
      require('telescope').extensions.frecency.frecency()
    end, { desc = "Find Recent (Frecency)" })

    -- Search in specific workspaces
    vim.keymap.set("n", "<leader>fC", function()
      require('telescope').extensions.frecency.frecency({
        workspace = "conf",
        prompt_title = "Config Files (Frecency)",
      })
    end, { desc = "Frecency: Config Files" })

    vim.keymap.set("n", "<leader>fp", function()
      require('telescope').extensions.frecency.frecency({
        workspace = "project",
        prompt_title = "Project Files (Frecency)",
      })
    end, { desc = "Frecency: Project Files" })

    -- Filter by file type
    vim.keymap.set("n", "<leader>fR", function()
      require('telescope').extensions.frecency.frecency({
        prompt_title = "Recent Files with Scores",
        show_scores = true,
      })
    end, { desc = "Frecency: Show Scores" })

    -- Frecency with live grep integration
    vim.keymap.set("n", "<leader>fF", function()
      vim.ui.input({ prompt = "Grep in frecent files: " }, function(input)
        if input then
          require('telescope').extensions.frecency.frecency({
            prompt_title = "Frecency + Grep: " .. input,
            attach_mappings = function(_, map)
              local actions = require('telescope.actions')
              map('i', '<CR>', function(prompt_bufnr)
                local selection = require('telescope.actions.state').get_selected_entry()
                actions.close(prompt_bufnr)
                if selection then
                  vim.cmd('edit ' .. selection.path)
                  vim.schedule(function()
                    vim.fn.search(input)
                  end)
                end
              end)
              return true
            end,
          })
        end
      end)
    end, { desc = "Frecency: Find and Grep" })
  end,
}