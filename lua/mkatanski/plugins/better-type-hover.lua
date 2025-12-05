return {
	"Sebastian-Nielsen/better-type-hover",
	ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	dependencies = {
		"neovim/nvim-lspconfig",
	},
	config = function()
		require("better-type-hover").setup({
			-- Use gk as the key to open the enhanced type hover
			openTypeDocKeymap = "gk",
			-- Fall back to standard LSP hover for non-interface/type elements
			fallback_to_old_on_anything_but_interface_and_type = true,
			-- Fold long type definitions after 20 lines
			fold_lines_after_line = 20,
			-- Keys to open nested types within the hover window
			keys_that_open_nested_types = { "a", "s", "b", "i", "e", "u", "r", "x" },
			-- Don't expand these basic types
			types_to_not_expand = { "string", "number", "boolean", "Date" },
		})

		-- Optional: Set custom colors for the key hints
		vim.cmd("highlight key_hint_color guifg=#FFFFFF guibg=NONE")
		vim.cmd("highlight selected_key_hint_color guifg=#BC0000 guibg=NONE")
	end,
}