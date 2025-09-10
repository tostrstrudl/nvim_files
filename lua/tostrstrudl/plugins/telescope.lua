return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-s>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
		})

		telescope.load_extension("fzf")

		-- Keymaps
		local keymap = vim.keymap

		keymap.set("n", "<leader>fo", "<cmd>Telescope find_files<CR>", { desc = "Find files in CWD" })
		keymap.set("n", "<C-f>", "<cmd>Telescope git_files<CR>", { desc = "Search through Git Repo" })
		keymap.set("n", "<leader>fl", "<cmd>Telescope oldfiles<CR>", { desc = "Find recent files" })
		keymap.set("n", "<leader>fi", "<cmd>Telescope live_grep<CR>", { desc = "Find string in CWD" })
		keymap.set("n", "<leader>fu", "<cmd>Telescope grep_string<CR>", { desc = "Find string under cursor in CWD" })
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find todos" })
	end,
}
