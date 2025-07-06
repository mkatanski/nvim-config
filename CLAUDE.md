# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a modular Neovim configuration using Lua and the lazy.nvim plugin manager. The configuration emphasizes clean organization, lazy loading, and modern Neovim features.

## Architecture

### Entry Point
- `init.lua`: Main entry that loads core settings and initializes the plugin manager
- Loading sequence: `init.lua` → `mkatanski.core` → `mkatanski.lazy`

### Directory Structure
```
lua/mkatanski/
├── core/           # Core Neovim settings
│   ├── init.lua    # Loads options and keymaps
│   ├── options.lua # Editor options (tabs, UI, clipboard)
│   └── keymaps.lua # Key mappings (leader = space)
├── lazy.lua        # Plugin manager setup
└── plugins/        # Individual plugin configurations
    └── lsp/        # LSP-specific configurations
```

### Plugin Management
- Uses lazy.nvim with automatic installation
- Plugins defined in `lua/mkatanski/plugins/` and `lua/mkatanski/plugins/lsp/`
- Each plugin has its own configuration file following this pattern:
  ```lua
  return {
    "author/plugin-name",
    dependencies = { ... },
    event = { ... },  -- for lazy loading
    config = function() ... end,
  }
  ```
- Plugin versions locked in `lazy-lock.json`

### Key Components

1. **LSP Setup**: Mason-based LSP management in `plugins/lsp/`
   - Mason installs and manages language servers
   - nvim-lspconfig for LSP configuration
   - nvim-cmp for completion

2. **Notable Plugins**:
   - Telescope for fuzzy finding
   - Neo-tree as file explorer
   - Gitsigns and lazygit for Git integration
   - Copilot and CodeCompanion for AI assistance
   - Auto-session for session management

3. **Key Mappings Philosophy**:
   - `<space>` as leader key
   - Consistent prefixes: `<leader>s` (splits), `<leader>t` (tabs)
   - Standard LSP bindings (gd, gr, K, etc.)

## Development Commands

Since this is a Neovim configuration, there are no build/test commands. Common operations:

- **Update plugins**: `:Lazy update` in Neovim
- **Install new plugin**: Add new file in `lua/mkatanski/plugins/` and restart Neovim
- **Check plugin status**: `:Lazy` in Neovim
- **Debug loading**: `:Lazy profile` to see plugin load times

## Important Patterns

1. **Adding a new plugin**: Create a new file in `lua/mkatanski/plugins/` with the standard return format
2. **Modifying keymaps**: Edit `lua/mkatanski/core/keymaps.lua`
3. **Changing editor options**: Edit `lua/mkatanski/core/options.lua`
4. **LSP configuration**: Add/modify files in `lua/mkatanski/plugins/lsp/`

## Session Management

Auto-session is configured to save and restore sessions automatically. Sessions are restored on VimEnter if no arguments are provided.