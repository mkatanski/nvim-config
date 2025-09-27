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
  end,
}