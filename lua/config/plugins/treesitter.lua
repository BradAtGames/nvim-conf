return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- Use a tag, typescript and json were broken at HEAD.
    tag = "v0.9.2",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "c",
                "cmake",
                "cpp",
                "glsl",
                "go",
                "gomod",
                "gosum",
                "gowork",
                "graphql",
                "hcl",
                "hlsl",
                "json",
                "lua",
                "make",
                "proto",
                "python",
                "rust",
                "terraform",
                "toml",
                "typescript",
                "vhs",
                "vimdoc",
                "yaml",
            },

            indent = {
                enable = true
            },

            auto_install = false,
        })
    end
}
