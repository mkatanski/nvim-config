return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("codecompanion").setup({
			strategies = {
				chat = {
					adapter = "copilot",
				},
				inline = {
					adapter = "copilot",
				},
			},
		})
	end,
	keys = {
		{ "<leader>cc", "<cmd>CodeCompanionChat<CR>", desc = "Open Codecompanion chat window" },
		{ "<leader>cp", "<cmd>CodeCompanionActions<CR>", desc = "Open Codecompanion panel" },
	},
}
