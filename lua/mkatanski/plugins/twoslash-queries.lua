return {
  "marilari88/twoslash-queries.nvim",
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  config = function()
    require("twoslash-queries").setup({
      multi_line = true,
      highlight = "Type",
    })

    -- Keybinding to inspect type at cursor
    vim.keymap.set("n", "<leader>ti", "<cmd>TwoslashQueriesInspect<cr>", { desc = "TypeScript: Inspect Type" })
    vim.keymap.set("n", "<leader>tr", "<cmd>TwoslashQueriesRemove<cr>", { desc = "TypeScript: Remove Queries" })
  end,
}