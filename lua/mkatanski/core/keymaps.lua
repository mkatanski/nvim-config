vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with 'jk' keys" })
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- editor navigation

-- Map Ctrl-E as CMD-right to move to the end of the line
vim.api.nvim_set_keymap("n", "<C-e>", "$", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-e>", "<Esc>A", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-e>", "<Esc>g_", { noremap = true, silent = true })

-- Map Ctrl-A as CMD-left to move to the beginning of the line
vim.api.nvim_set_keymap("n", "<C-a>", "^", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-a>", "<Esc>I", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-a>", "<Esc>^", { noremap = true, silent = true })
