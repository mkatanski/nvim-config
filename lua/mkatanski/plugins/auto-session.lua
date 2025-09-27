return {
	"rmagatti/auto-session",
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
			auto_restore_enabled = false,
			auto_session_suppress_dirs = {
				"~/",
				"~/Downloads",
				"~/Documents",
				"~/Desktop/",
				"/tmp",
				"/",
			},

			-- Enhanced session management
			pre_save_cmds = {
				function()
					-- Close NeoTree if available
					if vim.fn.exists(":Neotree") > 0 then
						vim.cmd("Neotree close")
					end
				end,
				function()
					-- Close Trouble if available
					if vim.fn.exists(":Trouble") > 0 then
						vim.cmd("Trouble close")
					end
				end,
			},

			post_restore_cmds = {
				function()
					-- Reopen NeoTree if available
					if vim.fn.exists(":Neotree") > 0 then
						vim.cmd("Neotree reveal")
					end
				end,
			},

			-- Session lens for better session discovery
			session_lens = {
				load_on_setup = true,
				theme_conf = { border = true },
				previewer = false,
			},

			-- Auto save session on exit
			auto_save_enabled = true,

			-- Log level for debugging
			log_level = "error",
		})

		local keymap = vim.keymap
		keymap.set("n", "<leader>sr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
		keymap.set("n", "<leader>ss", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" })
		keymap.set("n", "<leader>sl", "<cmd>SessionSearch<CR>", { desc = "Search sessions" })
		keymap.set("n", "<leader>sd", "<cmd>SessionDelete<CR>", { desc = "Delete session" })
	end,
}
