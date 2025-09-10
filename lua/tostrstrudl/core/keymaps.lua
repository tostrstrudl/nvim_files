vim.g.mapleader = " "

local keymap = vim.keymap

-- Terminal
keymap.set("n", "<C-CR>", "<C-w>s<cmd>terminal<CR>", { desc = "Show Terminal" })

-- Easy Cheezy
keymap.set("i", "qi", "<ESC>", { desc = "Quit Insert mode" })
keymap.set("n", "<leader><leader>s", "<cmd>source %<CR>", { desc = "SOURCE THOSE FILES!!" })
keymap.set(
	"n",
	"<leader><leader>l",
	"<cmd>source ~/.config/nvim/lua/tostrstrudl/plugins/luasnip.lua<CR>",
	{ desc = "Source LuaSnip" }
)

-- UndoTree
keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Highlighting
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear highlights" })

-- Move VL selection
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Static cursor when...
-- appending
keymap.set("n", "J", "mzJ`z")
-- jumping
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
-- searching
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- Preserve pastebuffer
keymap.set("x", "<leader>p", '"_dP')

-- Delete to void
keymap.set("n", "<leader>d", '"_d')
keymap.set("v", "<leader>d", '"_d')

-- Replace word under cursor global
keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left>")

-- Make file executable
keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Number juggling
keymap.set("n", "<leader>=", "<C-a>", { desc = "++" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "--" })

-- Splitting
keymap.set("n", "<leader>sl", "<C-w>v", { desc = "Split win to right" })
keymap.set("n", "<leader>sj", "<C-w>s", { desc = "Split win to bottom" })
keymap.set("n", "<leader>s=", "<C-w>=", { desc = "Make split equal" })
keymap.set("n", "<leader>so", "<cmd>close<CR>", { desc = "Close current split" })

-- Tabbing
keymap.set("n", "<leader>ti", "<cmd>tabnew<CR>", { desc = "New tab" })
keymap.set("n", "<leader>to", "<cmd>tabclose<CR>", { desc = "Close tab" })
keymap.set("n", "<leader>tl", "<cmd>tabn<CR>", { desc = "Next tab" })
keymap.set("n", "<leader>th", "<cmd>tabp<CR>", { desc = "Prev tab" })
keymap.set("n", "<leader>tw", "<cmd>tabnew %<CR>", { desc = "Dupl tab" })

-- Compiling
keymap.set("n", "<leader>b", "<cmd>!gcc %<CR>", { desc = "Compile using GCC" })

-- Kitty Integration
vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, {
	group = vim.api.nvim_create_augroup("KittySetVarVimEnter", { clear = true }),
	callback = function()
		io.stdout:write("\x1b]1337;SetUserVar=in_editor=MQo\007")
	end,
})

vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
	group = vim.api.nvim_create_augroup("KittyUnsetVarVimLeave", { clear = true }),
	callback = function()
		io.stdout:write("\x1b]1337;SetUserVar=in_editor\007")
	end,
})
