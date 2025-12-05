return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-neotest/nvim-nio", -- Required by nvim-dap-ui
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-telescope/telescope-dap.nvim",
    "williamboman/mason.nvim",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- Setup DAP UI
    dapui.setup({
      icons = { expanded = "", collapsed = "", current_frame = "" },
      mappings = {
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      element_mappings = {},
      expand_lines = vim.fn.has("nvim-0.7") == 1,
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.25 },
            "breakpoints",
            "stacks",
            "watches",
          },
          size = 40,
          position = "left",
        },
        {
          elements = {
            "repl",
            "console",
          },
          size = 0.25,
          position = "bottom",
        },
      },
      controls = {
        enabled = true,
        element = "repl",
        icons = {
          pause = "",
          play = "",
          step_into = "",
          step_over = "",
          step_out = "",
          step_back = "",
          run_last = "",
          terminate = "",
        },
      },
      floating = {
        max_height = nil,
        max_width = nil,
        border = "rounded",
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
    })

    -- Setup virtual text
    require("nvim-dap-virtual-text").setup({
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = false,
      show_stop_reason = true,
      commented = false,
      only_first_definition = true,
      all_references = false,
      filter_references_pattern = '<module',
      virt_text_pos = 'eol',
      all_frames = false,
      virt_lines = false,
      virt_text_win_col = nil
    })

    -- Extension is loaded in main telescope.lua file

    -- DAP event listeners
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- DAP Configurations for different languages

    -- Node.js debugging
    dap.adapters.node2 = {
      type = 'executable',
      command = 'node',
      args = {os.getenv('HOME') .. '/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodeDebug.js'},
    }

    dap.configurations.javascript = {
      {
        name = 'Launch',
        type = 'node2',
        request = 'launch',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        console = 'integratedTerminal',
      },
      {
        name = 'Attach to process',
        type = 'node2',
        request = 'attach',
        processId = require'dap.utils'.pick_process,
      },
    }

    dap.configurations.typescript = dap.configurations.javascript

    -- Python debugging
    dap.adapters.python = {
      type = 'executable',
      command = 'python3',
      args = { '-m', 'debugpy.adapter' },
    }

    dap.configurations.python = {
      {
        type = 'python',
        request = 'launch',
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
          return '/usr/bin/python3'
        end,
      },
    }

    -- Easy to remember keybindings for debugging
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dB", function()
      dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
    end, { desc = "Debug: Conditional Breakpoint" })

    vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: Continue" })
    vim.keymap.set("n", "<leader>ds", dap.step_over, { desc = "Debug: Step Over" })
    vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
    vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Debug: Step Out" })
    vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Debug: Open REPL" })
    vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Debug: Run Last" })
    vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Debug: Terminate" })

    -- DAP UI keybindings
    vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
    vim.keymap.set("n", "<leader>dh", dapui.eval, { desc = "Debug: Eval Hover" })

    -- Telescope DAP keybindings
    vim.keymap.set("n", "<leader>dC", function()
      require('telescope').extensions.dap.configurations()
    end, { desc = "Debug: Configurations" })

    vim.keymap.set("n", "<leader>dL", function()
      require('telescope').extensions.dap.list_breakpoints()
    end, { desc = "Debug: List Breakpoints" })

    vim.keymap.set("n", "<leader>dv", function()
      require('telescope').extensions.dap.variables()
    end, { desc = "Debug: Variables" })

    vim.keymap.set("n", "<leader>df", function()
      require('telescope').extensions.dap.frames()
    end, { desc = "Debug: Frames" })

    vim.keymap.set("n", "<leader>dq", function()
      require('telescope').extensions.dap.commands()
    end, { desc = "Debug: Commands" })

    -- Signs for breakpoints
    vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})
    vim.fn.sign_define('DapBreakpointCondition', {text='🟡', texthl='', linehl='', numhl=''})
    vim.fn.sign_define('DapLogPoint', {text='📝', texthl='', linehl='', numhl=''})
    vim.fn.sign_define('DapStopped', {text='▶️', texthl='', linehl='debugPC', numhl=''})
    vim.fn.sign_define('DapBreakpointRejected', {text='❌', texthl='', linehl='', numhl=''})
  end,
}