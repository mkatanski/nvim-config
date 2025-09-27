vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & indentation

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

-- search settings

opt.ignorecase = true
opt.smartcase = true

-- turn on termgui colors

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

-- performance optimizations
opt.updatetime = 250  -- Faster CursorHold events
opt.timeoutlen = 300  -- Faster which-key triggers
opt.swapfile = false  -- Disable swap files for better performance
opt.backup = false    -- Disable backup files
opt.undofile = true   -- Enable persistent undo
opt.undodir = vim.fn.stdpath("cache") .. "/undo"
