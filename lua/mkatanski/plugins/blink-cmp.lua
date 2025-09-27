return {
  "saghen/blink.cmp",
  lazy = false, -- lazy loading handled internally
  dependencies = "rafamadriz/friendly-snippets",
  version = "v0.*",
  opts = {
    keymap = {
      preset = 'default',
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide' },
      ['<CR>'] = { 'accept', 'fallback' },
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      ['<Tab>'] = { 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono'
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    completion = {
      accept = { auto_brackets = { enabled = true } },
      menu = {
        border = 'none',
        max_height = 10,
        scrollbar = true,
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = 'rounded',
          max_width = 60,
          max_height = 20,
        }
      },
    },

    signature = {
      enabled = true,
      window = {
        border = 'rounded',
      }
    }
  },
}