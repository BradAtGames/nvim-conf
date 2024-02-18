return {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "black" },
                go = { "goimports", "goimports-reviser", "golines", "gofumpt" }
            },
            format_on_save = {
                timeout_ms = 1000,
                lsp_fallback = true,
            }
        })
    end,
}
