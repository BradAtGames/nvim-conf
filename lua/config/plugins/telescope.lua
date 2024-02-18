return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    -- Not sure if I love setting keymaps this way. Now I have to remember two
    -- ways to do it.
    config = function()
        require("telescope").setup({})
        local builtin = require("telescope.builtin")
        -- find files
        vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
        -- find git
        vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
        -- find with search
        vim.keymap.set("n", "<leader>fs", function()
            builtin.grep_string({ search = vim.fn.input("Search > ") })
        end, {})
        -- find word at cursor
        vim.keymap.set("n", "<leader>fc", function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end, {})
        -- find expanded word at cursor
        vim.keymap.set("n", "<leader>fC", function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end, {})
    end
}
