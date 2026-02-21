# ⚡ My Neovim Configuration

Welcome to my personal Neovim configuration! This setup is designed for speed, aesthetics, and efficiency, featuring a custom key layout and a comprehensive suite of plugins for modern development.

![Neovim Showcase](assets/nvim.png)

## ✨ Features

- **🚀 Fast & Lazy**: optimized startup time with `lazy.nvim`.
- **🎨 Aesthetic UI**: Beautiful colorscheme, transparent background support, and polished UI components (`Noice`, `Lualine`, `Dressing`).
- **🧠 Intelligent Coding**: Full LSP support (Java, Swift, Python, Rust, etc.), `Blink.cmp` for completion, and `Conform` for formatting.
- **🛠️ Powerful Tools**: Integrated Terminal (`ToggleTerm`), Git integration (`LazyGit`, `Gitsigns`), and Fuzzy Finding (`Telescope`).
- **⌨️ Custom Layout**: A unique keymapping scheme optimized for ergonomic typing.

## ⚡ Keymaps (Important!)

**⚠️ Note:** This configuration uses a custom movement layout.

| Action | Key | Description |
| :--- | :--- | :--- |
| **Movement** | `u` / `e` | Move **Up** / **Down** |
| | `n` / `i` | Move **Left** / **Right** |
| | `U` / `E` | Move 5 lines Up / Down |
| | `h` | Jump to end of word |
| **Editing** | `k` | **Insert** mode (instead of `i`) |
| | `l` | **Undo** (instead of `u`) |
| | `K` | Insert at line start |
| | `Q` | Quit |
| **Window** | `<Space> w` | Cycle window |
| | `<Space> n/e/u/i` | Jump to window Left/Down/Up/Right |
| **Search** | `=` / `-` | Next / Previous result (centered) |
| | `<Space> <Enter>` | Clear search highlight |

## 📦 Plugins Overview

### 🧩 Core & UI
- **Plugin Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim)
- **Status Line**: `lualine.nvim`
- **Notifications**: `noice.nvim`
- **Icons**: `mini.icons`, `nvim-web-devicons`
- **Explorer**: `mini.files`, `yazi` (via terminal)

### 💻 Development
- **LSP**: `nvim-lspconfig`, `mason.nvim`, `mason-lspconfig`
- **Completion**: `blink.cmp`, `luasnip`
- **Formatting**: `conform.nvim`
- **Languages**: Python (`ruff`), Java (`nvim-java`), Rust, Swift, etc.

### 🛠️ Tools
- **Telescope**: Fuzzy finder for files, buffers, and text.
- **ToggleTerm**: Manage horizontal/vertical terminals easily.
- **Multicursor**: Edit multiple lines simultaneously.
- **Git**: `gitsigns.nvim`, `neogit`, `diffview.nvim`.

## 📥 Installation

```bash
# Backup your existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone this repository
git clone <your-repo-url> ~/.config/nvim

# Start Neovim
nvim
```
