-- Line numbering
vim.opt.nu = true
vim.opt.relativenumber = true

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
