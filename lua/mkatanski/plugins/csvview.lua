return {
  "hat0uma/csvview.nvim",
  config = function()
    require("csvview").setup({
      parser = {
        -- Async parsing for better performance
        async = true,
        -- Delimiter detection (auto-detect by default)
        delimiter = {
          default = ",",
          ft = {
            tsv = "\t",
          },
        },
      },
      view = {
        -- Display configuration
        min_column_width = 5,
        spacing = 2,
        -- Show row numbers
        display_mode = "border", -- "border" | "highlight"
      },
    })

    -- Keymaps for CSV files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "csv", "tsv" },
      callback = function()
        local opts = { buffer = true, silent = true }
        vim.keymap.set("n", "<leader>ct", ":CsvViewToggle<CR>", vim.tbl_extend("force", opts, { desc = "Toggle CSV view" }))
        vim.keymap.set("n", "<leader>ce", ":CsvViewEnable<CR>", vim.tbl_extend("force", opts, { desc = "Enable CSV view" }))
        vim.keymap.set("n", "<leader>cd", ":CsvViewDisable<CR>", vim.tbl_extend("force", opts, { desc = "Disable CSV view" }))
      end,
    })
  end,
  ft = { "csv", "tsv" },
}