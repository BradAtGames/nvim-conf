require("config.settings")
require("config.bootstrap")

local PreWriteCleanup = vim.api.nvim_create_augroup("Cleanup", {})

-- Trim trailing whitespace on save.
vim.api.nvim_create_autocmd({"BufWritePre"}, {
    group = PreWriteCleanup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})
