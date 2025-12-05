return {
  "echasnovski/mini.animate",
  event = "VeryLazy",
  config = function()
    local animate = require("mini.animate")

    animate.setup({
      -- Cursor path animation
      cursor = {
        -- Whether to enable cursor path animation
        enable = true,
        -- Timing of animation (how long it lasts)
        timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
        -- Path generator for cursor movement
        path = animate.gen_path.line({
          predicate = function() return true end,
        }),
      },

      -- Scrolling animation
      scroll = {
        -- Whether to enable scroll animation
        enable = true,
        -- Timing of animation
        timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
        -- Subscroll generator
        subscroll = animate.gen_subscroll.equal({
          predicate = function(total_scroll) return total_scroll > 1 end,
        }),
      },

      -- Window resize animation
      resize = {
        -- Whether to enable resize animation
        enable = true,
        -- Timing of animation
        timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
        -- Subresize generator
        subresize = animate.gen_subresize.equal({
          predicate = function(total_resize) return total_resize > 3 end,
        }),
      },

      -- Window open/close animation
      open = {
        -- Whether to enable open animation
        enable = true,
        -- Timing of animation
        timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
        -- How to animate window open
        winconfig = animate.gen_winconfig.wipe({ direction = "from_edge" }),
        -- Whether to animate window blend
        winblend = animate.gen_winblend.linear({ from = 80, to = 0 }),
      },

      -- Window close animation
      close = {
        -- Whether to enable close animation
        enable = true,
        -- Timing of animation
        timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
        -- How to animate window close
        winconfig = animate.gen_winconfig.wipe({ direction = "to_edge" }),
        -- Whether to animate window blend
        winblend = animate.gen_winblend.linear({ from = 0, to = 80 }),
      },
    })

    -- Optional: Add keybinding to toggle animations
    vim.keymap.set("n", "<leader>ta", function()
      local config = require("mini.animate").config
      local new_state = not config.cursor.enable

      -- Toggle all animations
      config.cursor.enable = new_state
      config.scroll.enable = new_state
      config.resize.enable = new_state
      config.open.enable = new_state
      config.close.enable = new_state

      if new_state then
        vim.notify("Animations enabled", vim.log.levels.INFO)
      else
        vim.notify("Animations disabled", vim.log.levels.INFO)
      end
    end, { desc = "Toggle Animations" })

    -- Optional: Faster animations for specific operations
    vim.keymap.set("n", "<leader>tf", function()
      local config = require("mini.animate").config
      local fast_timing = animate.gen_timing.linear({ duration = 50, unit = "total" })

      config.cursor.timing = fast_timing
      config.scroll.timing = fast_timing
      config.resize.timing = fast_timing
      config.open.timing = fast_timing
      config.close.timing = fast_timing

      vim.notify("Switched to fast animations", vim.log.levels.INFO)
    end, { desc = "Fast Animations" })

    -- Optional: Slower, more dramatic animations
    vim.keymap.set("n", "<leader>ts", function()
      local config = require("mini.animate").config
      local slow_timing = animate.gen_timing.linear({ duration = 300, unit = "total" })

      config.cursor.timing = slow_timing
      config.scroll.timing = slow_timing
      config.resize.timing = slow_timing
      config.open.timing = slow_timing
      config.close.timing = slow_timing

      vim.notify("Switched to slow animations", vim.log.levels.INFO)
    end, { desc = "Slow Animations" })
  end,
}