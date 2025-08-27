-- This file is automatically loaded by plugins.core
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt

opt.backup        = false
opt.swapfile      = false
opt.encoding      = "utf-8"
opt.fileencoding  = "utf-8"
opt.fileencodings = "utf-8,gbk,gb2312,big5"
opt.mouse         = "a"
opt.clipboard     = vim.env.SSH_TTY and "" or "unnamedplus"

-- tab
opt.tabstop       = 2
opt.shiftwidth    = 2
opt.softtabstop   = 2
opt.autoindent    = true
opt.scrolloff     = 5

-- ui config
opt.number         = true -- show line numbers
opt.relativenumber = true -- show relative line numbers
opt.cursorline     = true -- highlight current line
opt.colorcolumn    = "100" -- highlight column 100
opt.termguicolors  = true -- enable 24-bit color
-- opt.list           = true
-- opt.listchars      = 'tab:|\\ ,trail:▫'


opt.wrap        = true

-- set statusline && mode
opt.showcmd     = true
opt.showmode    = true
opt.wildmenu    = true
opt.laststatus  = 3
-- opt.inccommand  = "split"
opt.viewoptions = "cursor,folds,slash,unix"

-- Search
opt.incsearch  = true -- search as characters are entered
opt.hlsearch   = true -- highlight search results
opt.ignorecase = true -- ignore case when searching
opt.smartcase  = true -- ignore case if search pattern is all lowercase

-- indentation
vim.opt.timeoutlen = 500 -- time to wait for a mapped sequence to complete (in milliseconds)

-- no fold
opt.foldenable     = true
opt.foldmethod     = "manual"
-- vim.o.foldcolumn   = "1"
opt.foldlevel      = 99
opt.foldlevelstart = -1

