return {
	"Ernest1338/termplug.nvim",
	config = function()
		require("termplug").setup({ size = 0.5, shell = "zsh" })

		local keymap = vim.keymap

		keymap.set("n", "<leader>tt", "<cmd>Term<CR>", { desc = "Toggle terminal overlay" })
	end,
}
