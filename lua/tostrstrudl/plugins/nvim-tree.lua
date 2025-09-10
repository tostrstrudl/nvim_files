return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local nvimtree = require("nvim-tree")

        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        nvimtree.setup({
            view = {
                width = 35,
                relativenumber = true,
            },

            -- Folder arrows
            renderer = {
                indent_markers = {
                    enable = false,
                },
                icons = {
                    glyphs = {
                        folder = {
                            arrow_closed = "",
                            arrow_open = "",
                        },
                    },
                },
            },

            actions = {
                open_file = {
                    window_picker = {
                        enable = false,
                    },
                },
            },

            filters = {
                custom = { ".DS_Store" },
            },

            git = {
                ignore = false,
            },
        })

        -- Keymaps
        local keymap = vim.keymap

        keymap.set("n", "<leader>ov", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle File View" } )
        keymap.set("n", "<leader>of", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle CWD File View" } )
        keymap.set("n", "<leader>oc", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse all open folders" } )
        keymap.set("n", "<leader>or", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh NvimTree" } )

    end
}
