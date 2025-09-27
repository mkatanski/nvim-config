return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			-- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
			ensure_installed = {
				"vtsls",
				"html",
				"cssls",
				"tailwindcss",
				"svelte",
				"lua_ls",
				"graphql",
				"emmet_ls",
				"prismals",
				"pyright",
				"eslint",
			},
			-- Exclude ts_ls from automatic enabling to prevent conflicts with vtsls
			automatic_enable = {
				exclude = { "ts_ls", "tsserver" },
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				-- Formatters
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
				"biome", -- modern JS/TS formatter (faster than prettier)

				-- Linters
				"eslint_d", -- js linter
				"pylint", -- python linter

				-- Language Servers
				"typescript-language-server", -- backup for vtsls
				"tailwindcss-language-server", -- Tailwind CSS support
				"emmet-ls", -- HTML/CSS expansion

				-- Additional Tools
				"rustywind", -- Tailwind class sorter
				"markdownlint", -- Markdown linting
			},
		})
	end,
}
