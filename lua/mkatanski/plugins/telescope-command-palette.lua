return {
  "LinArcX/telescope-command-palette.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require('telescope').setup {
      extensions = {
        command_palette = {
          {"File Operations",
            { "Save current file", ':w' },
            { "Save all files", ':wa' },
            { "Quit current buffer", ':q' },
            { "Quit all", ':qa' },
            { "Force quit", ':q!' },
            { "New file", ':enew' },
            { "Reload current file", ':e!' },
          },

          {"Navigation",
            { "Go to definition", ':lua vim.lsp.buf.definition()' },
            { "Go to references", ':Telescope lsp_references' },
            { "Go to implementations", ':Telescope lsp_implementations' },
            { "Go to type definition", ':Telescope lsp_type_definitions' },
            { "Jump to line", ':' },
            { "Jump list", ':jumps' },
            { "Change list", ':changes' },
          },

          {"Search & Find",
            { "Find files", ':Telescope find_files' },
            { "Find recent files", ':Telescope oldfiles' },
            { "Find text (live grep)", ':Telescope live_grep' },
            { "Find word under cursor", ':Telescope grep_string' },
            { "Find TODO comments", ':TodoTelescope' },
            { "Find media files", ':Telescope media_files' },
            { "Search frecency", ':Telescope frecency' },
          },

          {"Git Operations",
            { "Git status", ':Telescope git_status' },
            { "Git commits", ':Telescope git_commits' },
            { "Git branches", ':Telescope git_branches' },
            { "Git worktrees", ':Telescope git_worktree git_worktrees' },
            { "Create git worktree", ':Telescope git_worktree create_git_worktree' },
            { "LazyGit", ':lua require("toggleterm.terminal").Terminal:new({cmd="lazygit", direction="float"}):toggle()' },
          },

          {"LSP & Diagnostics",
            { "Show line diagnostics", ':lua vim.diagnostic.open_float()' },
            { "Show workspace diagnostics", ':Telescope diagnostics' },
            { "Show buffer diagnostics", ':Telescope diagnostics bufnr=0' },
            { "Code actions", ':lua vim.lsp.buf.code_action()' },
            { "Rename symbol", ':lua vim.lsp.buf.rename()' },
            { "Format document", ':lua vim.lsp.buf.format()' },
            { "Restart LSP", ':LspRestart' },
            { "Toggle inlay hints", ':lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())' },
          },

          {"Session Management",
            { "Search sessions", ':Telescope session-lens search_session' },
            { "Save session", ':SessionSave' },
            { "Restore session", ':SessionRestore' },
            { "Delete session", ':SessionDelete' },
          },

          {"Terminal & External",
            { "Toggle floating terminal", ':ToggleTerm direction=float' },
            { "Toggle horizontal terminal", ':ToggleTerm direction=horizontal' },
            { "Toggle vertical terminal", ':ToggleTerm direction=vertical' },
            { "Node REPL", ':lua require("toggleterm.terminal").Terminal:new({cmd="node", direction="float"}):toggle()' },
            { "Python REPL", ':lua require("toggleterm.terminal").Terminal:new({cmd="python3", direction="float"}):toggle()' },
          },

          {"Neovim System",
            { "Reload config", ':source $MYVIMRC' },
            { "Check health", ':checkhealth' },
            { "Lazy plugin manager", ':Lazy' },
            { "Mason package manager", ':Mason' },
            { "Show keymaps", ':Telescope keymaps' },
            { "Show commands", ':Telescope commands' },
            { "Show help tags", ':Telescope help_tags' },
            { "Show highlights", ':Telescope highlights' },
            { "Command history", ':Telescope command_history' },
          },

          {"Debugging",
            { "Debug configurations", ':Telescope dap configurations' },
            { "List breakpoints", ':Telescope dap list_breakpoints' },
            { "Debug variables", ':Telescope dap variables' },
            { "Debug frames", ':Telescope dap frames' },
            { "Toggle breakpoint", ':DapToggleBreakpoint' },
            { "Start debugging", ':DapContinue' },
            { "Step over", ':DapStepOver' },
            { "Step into", ':DapStepInto' },
            { "Step out", ':DapStepOut' },
          },

          {"Docker",
            { "Docker containers", ':Telescope docker containers' },
            { "Docker images", ':Telescope docker images' },
            { "Docker networks", ':Telescope docker networks' },
            { "Docker volumes", ':Telescope docker volumes' },
          },

          {"UI & Appearance",
            { "Toggle trouble diagnostics", ':Trouble diagnostics toggle' },
            { "Toggle symbols outline", ':Trouble symbols toggle' },
            { "Toggle neotree", ':Neotree toggle' },
            { "Dismiss notifications", ':lua require("notify").dismiss({silent = true, pending = true})' },
            { "Notification history", ':Telescope notify' },
            { "Color picker", ':Colortils picker' },
            { "Toggle line blame", ':Gitsigns toggle_current_line_blame' },
          },
        }
      }
    }

    -- Extension is loaded in main telescope.lua file

    -- Easy to remember keybinding for command palette
    vim.keymap.set("n", "<leader>cp", function()
      require('telescope').extensions.command_palette.command_palette()
    end, { desc = "Command Palette" })

    -- Alternative with Ctrl+Shift+P (VS Code style) if terminal supports it
    vim.keymap.set("n", "<C-S-p>", function()
      require('telescope').extensions.command_palette.command_palette()
    end, { desc = "Command Palette (VS Code style)" })
  end,
}