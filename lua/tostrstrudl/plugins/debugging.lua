return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"williamboman/mason.nvim",
		{
			"jay-babu/mason-nvim-dap.nvim",

			opts = {
				-- This line is essential to making automatic installation work
				-- :exploding-brain
				handlers = {},
				automatic_installation = {
					-- These will be configured by separate plugins.
					exclude = {
						"delve",
						"python",
					},
				},
				-- DAP servers: Mason will be invoked to install these if necessary.
				ensure_installed = {
					"bash",
					"codelldb",
					"php",
					"python",
				},
			},
		},
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
		{
			"mfussenegger/nvim-dap-python",
			lazy = true,
		},
		{
			"jbyuki/one-small-step-for-vimkind",
			keys = {
				{
					"<leader>dl",
					function()
						require("osv").launch({ port = 8086 })
					end,
					desc = "Launch Lua adapter",
				},
			},
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local dap_python = require("dap-python")
		local virtual_text = require("nvim-dap-virtual-text")

		local python = vim.fn.expand("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")

		dapui.setup()
		dap_python.setup(python)
		virtual_text.setup({
			enabled = true, -- enable this plugin (the default)
			enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
			highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
			highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
			show_stop_reason = true, -- show stop reason when stopped for exceptions
			commented = false, -- prefix virtual text with comment string
			only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
			all_references = false, -- show virtual text on all all references of the variable (not only definitions)
			clear_on_continue = false, -- clear virtual text on "continue" (might cause flickering when stepping)
			--- A callback that determines how a variable is displayed or whether it should be omitted
			--- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
			--- @param buf number
			--- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
			--- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
			--- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
			--- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
			display_callback = function(variable, buf, stackframe, node, options)
				-- by default, strip out new line characters
				if options.virt_text_pos == "inline" then
					return " = " .. variable.value:gsub("%s+", " ")
				else
					return variable.name .. " = " .. variable.value:gsub("%s+", " ")
				end
			end,
			-- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
			virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",

			-- experimental features:
			all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
			virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
			virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
		})

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		-- Debug Adapters
		dap.adapters.nlua = function(callback, config)
			callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
		end

		dap.configurations.lua = {
			{
				type = "nlua",
				request = "attach",
				name = "Attach to running Neovim instance",
			},
		}

		dap.adapters.codelldb = {
			type = "server",
			port = 1300,
			executable = {
				command = "codelldb",
				args = { "--port", "${port}" },
			},
		}

		-- Configurations
		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("codelldb", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stoponEntry = false,
			},
		}

		dap.configurations.lua = {
			{
				name = "Current file (local-lua-debug, lua)",
				type = "local-lua",
				request = "launch",
				cwd = "${workspaceFolder}",
				args = {},
			},
		}

		-- Keymaps
		vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Dap UI toggle" })
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Set breakpoint" })
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Start / Continue debugging" })
		vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate debugging" })
	end,
}
