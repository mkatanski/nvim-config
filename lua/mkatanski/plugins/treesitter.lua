return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		-- import nvim-treesitter plugin
		local treesitter = require("nvim-treesitter.configs")
		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

		parser_config.ejs = {
			install_info = {
				url = "https://github.com/tree-sitter/tree-sitter-embedded-template",
				files = { "src/parser.c" },
				requires_generate_from_grammar = true,
			},
			filetype = "ejs",
			used_by = { "html", "javascript", "typescript", "typescriptreact", "javascriptreact", "t", "ejs" },
		}

		-- configure treesitter
		treesitter.setup({ -- enable syntax highlighting
			highlight = {
				enable = true,
			},
			-- enable indentation
			indent = { enable = true },
			-- enable autotagging (w/ nvim-ts-autotag plugin)
			autotag = {
				enable = true,
			},
			-- ensure these language parsers are installed
			ensure_installed = {
				"json",
				"javascript",
				"typescript",
				"tsx",
				"yaml",
				"html",
				"css",
				"prisma",
				"markdown",
				"markdown_inline",
				"svelte",
				"graphql",
				"bash",
				"lua",
				"vim",
				"dockerfile",
				"gitignore",
				"query",
				"vimdoc",
				"c",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})

		local ts_utils = require("nvim-treesitter.ts_utils")

		function ToggleBooleanUnderCursor()
			local node = ts_utils.get_node_at_cursor()

			if not node then
				print("No node under cursor")
				return
			end

			-- Check if the node is a boolean literal
			if node:type() == "true" or node:type() == "false" or node:type() == "number" then
				local current_value = vim.treesitter.get_node_text(node, 0)
				local new_value

				if current_value == "true" then
					new_value = "false"
				elseif current_value == "false" then
					new_value = "true"
				elseif current_value == "1" then
					new_value = "0"
				elseif current_value == "0" then
					new_value = "1"
				else
					print("Not a boolean value")
					return
				end

				-- Replace the text in the buffer
				local start_row, start_col, end_row, end_col = node:range()
				vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, { new_value })
			else
				print("No boolean value under cursor")
			end
		end

		-- Function to move the current line up
		function MoveLineUp()
			local current_line = vim.fn.line(".")
			if current_line > 1 then
				vim.cmd("move " .. (current_line - 2))
			end
		end

		-- Function to move the current line down
		function MoveLineDown()
			local current_line = vim.fn.line(".")
			local total_lines = vim.fn.line("$")
			if current_line < total_lines then
				vim.cmd("move " .. current_line + 1)
			end
		end

		-- Key mappings to move lines up and down
		vim.api.nvim_set_keymap(
			"n",
			"<S-k>",
			":lua MoveLineUp()<CR>",
			{ noremap = false, silent = true, desc = "Move line up" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<S-j>",
			":lua MoveLineDown()<CR>",
			{ noremap = false, silent = true, desc = "Move line down" }
		)

		-- Key mapping to toggle boolean under cursor
		vim.api.nvim_set_keymap(
			"n",
			"<leader>tb",
			":lua ToggleBooleanUnderCursor()<CR>",
			{ noremap = true, silent = true, desc = "Toggle boolean under cursor" }
		)
	end,
}
