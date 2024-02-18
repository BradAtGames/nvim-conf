function PickTheme()
    -- If it's before 9AM or after 9PM I'm probably in a darker room. Use a dark theme.
    -- Otherwise, use a light theme, since I don't live in a cave.
    
    -- TODO: It'd be nice to set up auto-switching an existing terminal, but my nvim sessions aren't that long lasting so it isn't pressing.

    local time = tonumber(os.date("%H", os.time()))

    if time >= 9 and time < 21 then
        vim.cmd [[colorscheme catppuccin-latte]]
        vim.opt.background = 'light'
    else
        vim.cmd [[colorscheme catppuccin-macchiato]]
        vim.opt.background = 'dark'
    end
end

return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({})
            PickTheme()
        end
    }
}
