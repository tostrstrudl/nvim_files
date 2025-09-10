return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status")

		local colors = {
			bg = "#080808",
			fg = "#c6c6c6",
			purple = "#c678dd",
			yellow = "#e5c07b",
			red = "#e06c75",
			cyan = "#56b6c2",
			green = "#98c379",
			blue = "#61afef",
			orange = "#d19a66",
			grey = "#303030",
		}

		local custom_theme = {
			normal = {
				a = { fg = colors.bg, bg = colors.green, gui = "bold" },
				b = { fg = colors.fg, bg = colors.grey },
				c = { fg = colors.fg },
			},
			insert = {
				a = { fg = colors.bg, bg = colors.blue, gui = "bold" },
				b = { fg = colors.fg, bg = colors.grey },
				c = { fg = colors.fg },
			},
			visual = {
				a = { fg = colors.bg, bg = colors.purple, gui = "bold" },
				b = { fg = colors.fg, bg = colors.grey },
				c = { fg = colors.fg },
			},
			replace = {
				a = { fg = colors.bg, bg = colors.orange, gui = "bold" },
				b = { fg = colors.fg, bg = colors.grey },
				c = { fg = colors.fg },
			},
			command = {
				a = { fg = colors.bg, bg = colors.red, gui = "bold" },
				b = { fg = colors.fg, bg = colors.grey },
				c = { fg = colors.fg },
			},
			inactive = {
				a = { fg = colors.fg, bg = colors.bg },
				b = { fg = colors.fg, bg = colors.bg },
				c = { fg = colors.fg, bg = colors.bg },
			},
		}

		lualine.setup({
			options = {
				icons_enabled = true,
				theme = custom_theme,
				section_separators = { left = "", right = "" },
				component_separators = { left = "|", right = "|" },
			},
			sections = {
				lualine_a = {
					{
						"mode",
						separator = {
							left = "",
						},
						right_padding = 2,
					},
				},
				lualine_b = { "branch", "diff" },
				lualine_c = {
					{ "filename" },
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = { error = " ", warn = " ", info = " " },
						diagnostics_color = {
							error = { fg = colors.red },
							warn = { fg = colors.yellow },
							info = { fg = colors.cyan },
						},
					},
				},
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						fg = { "#ff9e64" },
					},
				},
				lualine_y = { "encoding", "filetype", "progress" },
				lualine_z = {
					{
						"location",
						separator = {
							right = "",
						},
						left_padding = 2,
					},
				},
			},
			inactive_sessions = {
				lualine_a = {},
				lualine_b = { "filename" },
				lualine_c = {},
				lualine_x = {},
				lualine_y = { "location" },
				lualine_z = {},
			},
		})
	end,
}
