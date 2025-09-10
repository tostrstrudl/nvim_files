return {
	"rmagatti/auto-session",
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
			auto_restore_enabled = false,
			auto_session_repress_dirs = { "~/", "~/Downloads", "~Documents" },
		})

		local keymap = vim.keymap

		keymap.set("n", "<leader>wo", "<cmd>AutoSession restore<CR>", { desc = "Restore session for CWD" })
		keymap.set("n", "<leader>wp", "<cmd>AutoSession save<CR>", { desc = "Save session" })
		keymap.set("n", "<leader>wi", "<cmd>AutoSession search<CR>", { desc = "Open session picker" })
	end,
}
