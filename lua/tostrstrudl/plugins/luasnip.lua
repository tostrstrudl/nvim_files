return {
	"L3MON4D3/LuaSnip",
	dependencies = {
		"saadparwaiz1/cmp_luasnip",
	},
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = "make install_jsregexp",

	config = function()
		local ls = require("luasnip")
		local ls_types = require("luasnip.util.types")

		ls.setup({
			history = true,
			updateevents = "TextChanged,TextChangedI",

			require("luasnip.loaders.from_lua").load({
				paths = {
					"~/.config/nvim/lua/tostrstrudl/snippets",
				},
			}),

			vim.keymap.set({ "i", "s" }, "sj", function()
				if ls.expand_or_jumpable() then
					ls.expand_or_jump()
				end
			end, { silent = true }),
			vim.keymap.set({ "i", "s" }, "slj", function()
				ls.jump(-1)
			end, { silent = true }),
			vim.keymap.set({ "i", "s" }, "slf", require("luasnip.extras.select_choice")),
			vim.keymap.set({ "i", "s" }, "soj", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true }),
		})
	end,
}
