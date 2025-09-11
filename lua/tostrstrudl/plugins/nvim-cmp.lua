return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"onsails/lspkind.nvim",
		"saadparwaiz1/cmp_luasnip",
	},

	config = function()
		local cmp = require("cmp")

        local luasnip = require("luasnip")

		local lspkind = require("lspkind")

		local function concat(str)
			if str == "Field" then
				return "FLD "
			elseif str == "Property" then
				return "PROP"
			elseif str == "Event" then
				return "EVNT"
			elseif str == "Text" then
				return "TXT "
			elseif str == "Enum" then
				return "ENUM"
			elseif str == "Keyword" then
				return "KWRD"
			elseif str == "Constant" then
				return "CNST"
			elseif str == "Constructor" then
				return "CSTR"
			elseif str == "Reference" then
				return "REF "
			elseif str == "Function" then
				return "FUNC"
			elseif str == "Struct" then
				return "STRC"
			elseif str == "Class" then
				return "CLS "
			elseif str == "Module" then
				return "MOD "
			elseif str == "Operator" then
				return "OPR8"
			elseif str == "Variable" then
				return "VAR "
			elseif str == "File" then
				return "FILE"
			elseif str == "Unit" then
				return "UNT "
			elseif str == "Snippet" then
				return "SNPT"
			elseif str == "Folder" then
				return "FLDR"
			elseif str == "Method" then
				return "MTHD"
			elseif str == "Value" then
				return "VAL "
			elseif str == "EnumMember" then
				return "EMEM"
			elseif str == "Interface" then
				return "INTF"
			elseif str == "Color" then
				return "CLR "
			elseif str == "TypeParameter" then
				return "TYPE"
			else
				return ""
			end
		end

		require("luasnip.loaders.from_lua").load({
            paths = {"~/.config/nvim/lua/tostrstrudl/snippets"}
        })

		-- Cmp Config
		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noinsert,noselect",
			},

			window = {
				completion = cmp.config.window.bordered({
					border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
					scrollbar = "║",
					winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
					scrolloff = 3,
					col_offset = -1,
					side_padding = 1,
				}),
				documentation = {
					border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
					scrollbar = "║",
					winhighlight = "Normal:NormalNC,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
				},
			},

			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			-- Keymaps
			mapping = {
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- SHOWS COMPLETIONS AVAILABLE
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Insert,
					select = false,
				}),
			},

			-- Sourcing
			sources = cmp.config.sources({
				{ name = "lazydev", group_index = 0 },
				{ name = "nvim_lsp", max_item_count = 30 },
				{ name = "luasnip" },
				{ name = "emoji" },
				{ name = "buffer", keyword_length = 5 },
				{ name = "path" },
			}),

			-- LspKind
			formatting = {
				fields = {
                    "icon",
					"abbr",
                    "kind",
					"menu",
				},
				format = function(entry, vim_item)
					local kind = lspkind.cmp_format({
                    mode = "text",
                    menu = {
                            lazydev = "[LZD]",
                            nvim_lsp = "[LSP]",
                            luasnip = "[SNP]",
                            emoji = "[EJI]",
                            buffer = "[BUF]",
                            path = "[PTH]",
                    },
                    maxwidth = {menu = 50, abbr = 50},
                    show_labelDetails = true,
					})(entry, vim_item)
					local strings = kind.kind
                    kind.icon = " " .. kind.icon .. " "
                    kind.abbr = " " .. kind.abbr .. "    "
                    kind.kind = " " .. concat(strings) .. " "
					local function set_colors(str)
						local color = vim.api.nvim_get_hl(0, {
							name = "CmpItemKind" .. str,
						})

						vim.api.nvim_set_hl(0, "CmpItemKind" .. str .. "Icon", { fg = color.fg, bg = color.bg, italic = true })
					end

					set_colors(strings)

					return kind
				end,
			},

			experimental = {
				ghost_text = false,
			},
		})

		-- Customization for Pmenu
		vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#383444", fg = "#c6c6c6" })
		vim.api.nvim_set_hl(0, "Pmenu", { fg = "#383444", bg = "NONE" })

		vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#e06c75", bg = "NONE", strikethrough = true })
		vim.api.nvim_set_hl(0, "CmpItemAbbr", { fg = "#5a5a5a" })
		vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#61afef", bg = "NONE", bold = true })
		vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#61afef", bg = "NONE", bold = true })
		vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#5a5a5a", bg = "NONE" })

		-- Icon highlights
		vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#ffffff", bg = "#ff2942" })
		vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#ffffff", bg = "#ff2942" })
		vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#ffffff", bg = "#ff2942" })

		vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#ffffff", bg = "#98c379" })
		vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#ffffff", bg = "#98c379" })
		vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#ffffff", bg = "#98c379" })

		vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#ffffff", bg = "#D4BB6C" })
		vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#ffffff", bg = "#D4BB6C" })
		vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#ffffff", bg = "#D4BB6C" })

		vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#ffffff", bg = "#c678dd" })
		vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#ffffff", bg = "#c678dd" })
		vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#ffffff", bg = "#c678dd" })
		vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#ffffff", bg = "#c678dd" })
		vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#ffffff", bg = "#c678dd" })

		vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#ffffff", bg = "#6c6c6c" })
		vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#ffffff", bg = "#6c6c6c" })

		vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#ffffff", bg = "#d19a66" })
		vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#ffffff", bg = "#d19a66" })
		vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#ffffff", bg = "#d19a66" })

		vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#ffffff", bg = "#6C8ED4" })
		vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#ffffff", bg = "#6C8ED4" })
		vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#ffffff", bg = "#6C8ED4" })

		vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#ffffff", bg = "#58B5A8" })
		vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#ffffff", bg = "#58B5A8" })
		vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#ffffff", bg = "#58B5A8" })
	end,
}
