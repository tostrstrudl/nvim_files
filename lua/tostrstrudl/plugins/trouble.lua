return {
	"folke/trouble.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {},
	cmd = "Trouble",
	keys = {
		{ "<leader>eo", "<cmd>Trouble diagnostics toggle<CR>", desc = "Toggle trouble list" },
		{ "<leader>ei", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Open cur file diags" },
		{ "<leader>ef", "<cmd>Trouble qflist toggle<CR>", desc = "Open quickfix diags" },
		{ "<leader>el", "<cmd>Trouble loclist toggle<CR>", desc = "Open loc list" },
		{ "<leader>et", "<cmd>Trouble todo toggle<CR>", desc = "Open todos" },
	},
}
