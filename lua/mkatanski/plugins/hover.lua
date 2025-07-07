return {
	"lewis6991/hover.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"neovim/nvim-lspconfig",
	},
	config = function()
		require("hover").setup({
			init = function()
				-- Require providers
				require("hover.providers.lsp")
				require("hover.providers.diagnostic")
				-- Optional providers you might want to enable later:
				-- require('hover.providers.gh') -- GitHub issues/PRs
				-- require('hover.providers.man') -- Man pages
				-- require('hover.providers.dictionary') -- Dictionary
			end,
			preview_opts = {
				border = "rounded", -- Match your other floating windows
			},
			-- Whether the contents of a currently open hover window should be moved
			-- to a :h preview-window when pressing the hover keymap.
			preview_window = false,
			title = true, -- Show title indicating which provider is being used
			mouse_providers = {
				"LSP",
			},
			mouse_delay = 1000,
		})

		-- Setup keymaps
		vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
		vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
		vim.keymap.set("n", "<C-p>", function()
			require("hover").hover_switch("previous")
		end, { desc = "hover.nvim (previous source)" })
		vim.keymap.set("n", "<C-n>", function()
			require("hover").hover_switch("next")
		end, { desc = "hover.nvim (next source)" })

		-- Optional: Mouse support
		-- vim.keymap.set('n', '<MouseMove>', require('hover').hover_mouse, { desc = "hover.nvim (mouse)" })
		-- vim.o.mousemoveevent = true
	end,
}