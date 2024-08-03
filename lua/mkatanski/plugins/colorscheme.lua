return {
	{
		"0xstepit/flow.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("flow").setup({
				transparent = true, -- Set transparent background.
				fluo_color = "pink", --  Fluo color: pink, yellow, orange, or green.
				mode = "normal", -- Intensity of the palette: normal, bright, desaturate, or dark. Notice that dark is ugly!
				aggressive_spell = false, -- Display colors for spell check.
			})

			-- load the colorscheme here
			vim.cmd([[colorscheme flow]])
		end,
	},
}
