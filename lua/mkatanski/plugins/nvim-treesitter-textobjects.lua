return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	lazy = true,
	config = function()
		require("nvim-treesitter.configs").setup({
			textobjects = {
				select = {
					enable = true,
					lookahead = true,

					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
						["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
						["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
						["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

						["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
						["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

						["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
						["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

						["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
						["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

						["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
						["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

						["am"] = {
							query = "@function.outer",
							desc = "Select outer part of a method/function definition",
						},
						["im"] = {
							query = "@function.inner",
							desc = "Select inner part of a method/function definition",
						},

						["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
						["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
						["<leader>nm"] = "@function.outer", -- swap function with next
					},
					swap_previous = {
						["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
						["<leader>pm"] = "@function.outer", -- swap function with previous
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]f"] = { query = "@call.outer", desc = "Next function call start" },
						-- ["]m"] removed - using custom top-level function navigation
						["]c"] = { query = "@class.outer", desc = "Next class start" },
						["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
						["]l"] = { query = "@loop.outer", desc = "Next loop start" },

						-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
						-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
						["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
						["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
					},
					goto_next_end = {
						["]F"] = { query = "@call.outer", desc = "Next function call end" },
						["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
						["]C"] = { query = "@class.outer", desc = "Next class end" },
						["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
						["]L"] = { query = "@loop.outer", desc = "Next loop end" },
					},
					goto_previous_start = {
						["[f"] = { query = "@call.outer", desc = "Prev function call start" },
						-- ["[m"] removed - using custom top-level function navigation
						["[c"] = { query = "@class.outer", desc = "Prev class start" },
						["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
						["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
					},
					goto_previous_end = {
						["[F"] = { query = "@call.outer", desc = "Prev function call end" },
						["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
						["[C"] = { query = "@class.outer", desc = "Prev class end" },
						["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
						["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
					},
				},
			},
		})

		local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

		-- vim way: ; goes to the direction you were moving.
		vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
		vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

		-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
		vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
		vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
		vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
		vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)

		-- Custom navigation for top-level functions only
		local ts_utils = require("nvim-treesitter.ts_utils")
		local parsers = require("nvim-treesitter.parsers")

		-- Language-specific function node types
		local function_node_types = {
			javascript = { "function_declaration", "method_definition", "arrow_function", "function_expression" },
			typescript = { "function_declaration", "method_definition", "arrow_function", "function_expression" },
			tsx = { "function_declaration", "method_definition", "arrow_function", "function_expression" },
			jsx = { "function_declaration", "method_definition", "arrow_function", "function_expression" },
			python = { "function_definition" },
			lua = { "function_declaration", "function_definition" },
			c = { "function_definition" },
			cpp = { "function_definition" },
			rust = { "function_item" },
			go = { "function_declaration", "method_declaration" },
			java = { "method_declaration" },
			php = { "function_definition", "method_declaration" },
			ruby = { "method", "singleton_method" },
			-- Add more languages as needed
		}

		local function get_function_query(lang)
			local types = function_node_types[lang]
			if not types then
				-- Fallback to generic function query
				return "@function.outer"
			end
			
			local query_parts = {}
			for _, node_type in ipairs(types) do
				table.insert(query_parts, "(" .. node_type .. ")")
			end
			
			return "[" .. table.concat(query_parts, " ") .. "] @function"
		end

		local function is_top_level_function(node, lang)
			if not node then return false end
			
			local types = function_node_types[lang] or {}
			local node_type = node:type()
			
			-- Check if this is a function node for this language
			local is_function = false
			for _, ftype in ipairs(types) do
				if node_type == ftype then
					is_function = true
					break
				end
			end
			
			if not is_function then return false end
			
			-- Check if any parent is also a function (making this nested)
			local parent = node:parent()
			while parent do
				local parent_type = parent:type()
				for _, ftype in ipairs(types) do
					if parent_type == ftype then
						return false -- This is a nested function
					end
				end
				parent = parent:parent()
			end
			
			return true -- This is a top-level function
		end

		local function goto_next_top_level_function()
			local parser = parsers.get_parser()
			if not parser then return end
			
			local lang = parser:lang()
			local tree = parser:parse()[1]
			local root = tree:root()
			
			local cursor = vim.api.nvim_win_get_cursor(0)
			local current_row = cursor[1] - 1
			
			-- Try to use language-specific query
			local query_string = get_function_query(lang)
			local ok, query = pcall(vim.treesitter.query.parse, lang, query_string)
			
			if not ok then
				-- Fallback to using textobjects query
				require("nvim-treesitter.textobjects.move").goto_next_start("@function.outer")
				return
			end
			
			local next_row = nil
			for _, node in query:iter_captures(root, 0) do
				local start_row = node:start()
				if start_row > current_row and is_top_level_function(node, lang) then
					if not next_row or start_row < next_row then
						next_row = start_row
					end
				end
			end
			
			if next_row then
				vim.api.nvim_win_set_cursor(0, {next_row + 1, 0})
			end
		end

		local function goto_prev_top_level_function()
			local parser = parsers.get_parser()
			if not parser then return end
			
			local lang = parser:lang()
			local tree = parser:parse()[1]
			local root = tree:root()
			
			local cursor = vim.api.nvim_win_get_cursor(0)
			local current_row = cursor[1] - 1
			
			-- Try to use language-specific query
			local query_string = get_function_query(lang)
			local ok, query = pcall(vim.treesitter.query.parse, lang, query_string)
			
			if not ok then
				-- Fallback to using textobjects query
				require("nvim-treesitter.textobjects.move").goto_previous_start("@function.outer")
				return
			end
			
			local prev_row = nil
			for _, node in query:iter_captures(root, 0) do
				local start_row = node:start()
				if start_row < current_row and is_top_level_function(node, lang) then
					if not prev_row or start_row > prev_row then
						prev_row = start_row
					end
				end
			end
			
			if prev_row then
				vim.api.nvim_win_set_cursor(0, {prev_row + 1, 0})
			end
		end

		-- Override ]m and [m to use top-level navigation
		vim.keymap.set("n", "]m", goto_next_top_level_function, { desc = "Next top-level function" })
		vim.keymap.set("n", "[m", goto_prev_top_level_function, { desc = "Previous top-level function" })
		
		-- Keep ]M and [M for navigating all functions (including nested)
		vim.keymap.set("n", "]M", function()
			require("nvim-treesitter.textobjects.move").goto_next_start("@function.outer")
		end, { desc = "Next function (including nested)" })
		
		vim.keymap.set("n", "[M", function()
			require("nvim-treesitter.textobjects.move").goto_previous_start("@function.outer")
		end, { desc = "Previous function (including nested)" })
	end,
}
