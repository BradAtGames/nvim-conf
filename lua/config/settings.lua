-- Line numbering
vim.opt.nu = true
vim.opt.relativenumber = true

-- Sanity
vim.opt.fileformat="unix"
vim.opt.fileformats="unix,dos"

-- Indentation
-- Default to spaces, rely on formatters to go back to tabs for languages that
-- prefer them (e.g. go)
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search
-- Show match while typing, but to leave distracting highlights everywhere.
vim.opt.incsearch = true
vim.opt.hlsearch = false

-- Color
vim.opt.termguicolors = true

-- Turn off swap files
vim.opt.swapfile = false
vim.opt.backup = false

-- Global remaps
vim.g.mapleader = " "
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
