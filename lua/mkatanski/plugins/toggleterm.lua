return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    })

    -- Custom terminal configurations
    local Terminal = require("toggleterm.terminal").Terminal

    -- Lazygit integration
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = {
        border = "double",
      },
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
      end,
      on_close = function(term)
        vim.cmd("startinsert!")
      end,
    })

    -- Node REPL
    local node = Terminal:new({
      cmd = "node",
      direction = "float",
      float_opts = {
        border = "double",
      },
    })

    -- Python REPL
    local python = Terminal:new({
      cmd = "python3",
      direction = "float",
      float_opts = {
        border = "double",
      },
    })

    -- Keymaps
    vim.keymap.set("n", "<leader>tf", ":ToggleTerm direction=float<CR>", { desc = "Toggle floating terminal" })
    vim.keymap.set("n", "<leader>th", ":ToggleTerm direction=horizontal<CR>", { desc = "Toggle horizontal terminal" })
    vim.keymap.set("n", "<leader>tv", ":ToggleTerm direction=vertical<CR>", { desc = "Toggle vertical terminal" })
    vim.keymap.set("n", "<leader>gg", function() lazygit:toggle() end, { desc = "Toggle LazyGit" })
    vim.keymap.set("n", "<leader>tn", function() node:toggle() end, { desc = "Toggle Node REPL" })
    vim.keymap.set("n", "<leader>tp", function() python:toggle() end, { desc = "Toggle Python REPL" })

    -- Terminal mode keymaps
    function _G.set_terminal_keymaps()
      local opts = {buffer = 0}
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    end

    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
  end,
}