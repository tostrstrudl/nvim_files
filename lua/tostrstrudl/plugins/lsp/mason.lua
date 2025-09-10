return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},

	config = function()
		local mason = require("mason")

		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			automatic_installation = true,
			ensure_installed = {
				"basedpyright",
				"clangd",
				"cssls",
				"ts_ls",
				"html",
				"jsonls",
				"lua_ls",
				"sorbet",
				"sqlls",
				"yamlls",
				"vimls",
				"emmet_ls",
				"bashls",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier",
				"stylua",
				"isort",
				"black",
				"beautysh",
				"clang-format",
				"pylint",
				"eslint_d",
				"cpplint",
				"cspell",
			},
		})
	end,
}
