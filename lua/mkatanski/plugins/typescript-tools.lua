return {
  "pmizio/typescript-tools.nvim",
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  config = function()
    require("typescript-tools").setup({
      settings = {
        -- Enable detailed type information for better-type-hover
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
          displayPartsForJSDoc = true,
          generateReturnInDocTemplate = true,
          includeCompletionsForModuleExports = true,
          includeCompletionsWithInsertText = true,
          includeAutomaticOptionalChainCompletions = true,
          allowIncompleteCompletions = false,
          provideRefactorNotApplicableReason = true,
        },
      },
    })
  end,
}