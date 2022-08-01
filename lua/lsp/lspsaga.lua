local saga = require("lspsaga")

saga.init_lsp_saga({
	border_style = "rounded",
	diagnostic_header = { " 😡", " 😬", " 👁️", " 🌚" },
	max_preview_lines = 30,
	code_action_icon = "*",
	code_action_lightbulb = {
		sign = false,
	},
	finder_icons = {
		def = "🐔 ",
		ref = "🐤 ",
	},
	finder_action_keys = {
		open = "<cr>",
		vsplit = "<c-v>",
		split = "<c-s>",
		scroll_down = "<C-f>",
		scroll_up = "<C-e>",
		quit = "<c-j>",
	},
	code_action_keys = {
		quit = "<c-j>",
	},
	rename_action_quit = "<c-j>",
	definition_preview_icon = "🛰️ ",
})

-- go    implementation
-- g<cr> formatting
vim.keymap.set("n", "gi", "<cmd>Lspsaga lsp_finder<CR>", { silent = true, noremap = true }) --definition and reference
vim.keymap.set("n", "gp", "<cmd>Lspsaga preview_definition<CR>", { silent = true })
vim.keymap.set("n", "gh", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
vim.keymap.set("n", "gs", "<Cmd>Lspsaga signature_help<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "ga", "<cmd>Lspsaga code_action<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true, noremap = true })
vim.cmd([[
  nnoremap \e <CMD>Lspsaga diagnostic_jump_prev<CR>
  nnoremap \f <CMD>Lspsaga diagnostic_jump_next<CR>
]])

-- LSP methods learned:
-- implementation, formatting, finder (def/ref), preview_definition, signature_help, code_action, rename
--       1              2             3                  4                 5              6          7
