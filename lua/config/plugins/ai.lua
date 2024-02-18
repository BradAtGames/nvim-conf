return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = "Copilot auth",
    event = "InsertEnter",
    config = function()
        require("copilot").setup({
            panel = {
                enabled = true,
                auto_refresh = true,
            },
            suggestion = {
                enabled = true,
                auto_trigger = true,
                accept = false,
            },
            settings = {
                -- Num completions for panel
                listCount = 10,
                -- Num compleons for getCompletions
                inlineSuggestionCount = 5,
            }
        })

        local c_status, c = pcall(require, "cmp")
        if c_status then
            c.event:on("menu_opened", function()
                vim.b.copilot_suggestion_hidden = true
            end)

            c.event:on("menu_closed", function()
                vim.b.copilot_suggestion_hidden = false
            end)
        end
    end,
}
