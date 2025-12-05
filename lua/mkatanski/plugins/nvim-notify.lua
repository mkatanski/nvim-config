return {
  "rcarriga/nvim-notify",
  config = function()
    local notify = require("notify")

    notify.setup({
      -- Animation style
      stages = "fade_in_slide_out",

      -- Position notifications in top-right corner
      top_down = true,

      -- Timeout for notifications (in milliseconds)
      timeout = 3000,

      -- Maximum width and height
      max_width = 50,
      max_height = 10,

      -- Minimum width
      minimum_width = 20,

      -- Background transparency
      background_colour = "#000000",

      -- Icons for different levels
      icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "✎",
      },

      -- Level configuration
      level = 2, -- show info and above

      -- Render function
      render = "default",

      -- On open callback
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,

      -- On close callback
      on_close = function() end,
    })

    -- Set as default notify function
    vim.notify = notify

    -- Key mappings for notification management
    vim.keymap.set("n", "<leader>nd", function()
      notify.dismiss({ silent = true, pending = true })
    end, { desc = "Dismiss all notifications" })

    vim.keymap.set("n", "<leader>nh", "<cmd>Telescope notify<cr>", { desc = "Show notification history" })

    -- Override the default action for opening notifications from telescope
    -- This ensures error details can be dismissed with q/Esc
    local original_open = require("telescope._extensions.notify").exports.notify
    require("telescope._extensions.notify").exports.notify = function(opts)
      opts = opts or {}
      opts.attach_mappings = function(_, map)
        map('n', '<CR>', function(prompt_bufnr)
          local selection = require('telescope.actions.state').get_selected_entry(prompt_bufnr)
          require('telescope.actions').close(prompt_bufnr)
          if selection then
            -- Show notification details in a dismissable popup
            vim.schedule(function()
              local content = selection.value
              local buf = vim.api.nvim_create_buf(false, true)
              vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(content, '\n'))
              vim.api.nvim_buf_set_option(buf, 'modifiable', false)
              vim.api.nvim_buf_set_option(buf, 'filetype', 'text')

              local win = vim.api.nvim_open_win(buf, true, {
                relative = 'editor',
                width = math.min(80, vim.o.columns - 4),
                height = math.min(20, vim.o.lines - 4),
                col = math.floor((vim.o.columns - math.min(80, vim.o.columns - 4)) / 2),
                row = math.floor((vim.o.lines - math.min(20, vim.o.lines - 4)) / 2),
                style = 'minimal',
                border = 'rounded',
                title = ' Notification Details ',
                title_pos = 'center',
              })

              -- Add keymaps to close the popup
              vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '<cmd>close<cr>', { silent = true })
              vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', '<cmd>close<cr>', { silent = true })
            end)
          end
        end)
        return true
      end
      return original_open(opts)
    end
  end,
}