return {
    "akinsho/bufferline.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    version = "*",
    opts = {
        options = {
            mode = "tabs",
            separator_style = "thick",
            numbers = "id",
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Overview",
                    highlight = "Directory",
                    separator = true
                }
            },
        },
    },
}
