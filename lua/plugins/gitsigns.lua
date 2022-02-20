local present, gitsigns = pcall(require, "gitsigns")
if not present then
	return
end

gitsigns.setup({
	signs = {
		add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
		change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
		delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		changedelete = {
			hl = "GitSignsChange",
			text = "▎",
			numhl = "GitSignsChangeNr",
			linehl = "GitSignsChangeLn",
		},
	},
	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
	watch_gitdir = {
		interval = 1000,
		follow_files = true,
	},
	attach_to_untracked = true,
	current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
	},
	current_line_blame_formatter_opts = {
		relative_time = false,
	},
	sign_priority = 6,
	status_formatter = nil, -- Use default
	max_file_length = 40000,
	preview_config = {
		-- Options passed to nvim_open_win
		border = "single",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
	yadm = {
		enable = false,
	},
	keymaps = {
		-- Default keymap options
		noremap = true,

		["n ]c"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'" },
		["n [c"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'" },

		["n <leader>;s"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
		["v <leader>;s"] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
		["n <leader>;u"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
		["n <leader>;r"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
		["v <leader>;r"] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
		["n <leader>;R"] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
		["n <leader>;p"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
		["n <leader>;b"] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
		["n <leader>;S"] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
		["n <leader>;U"] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',

		-- Text objects
		["o ih"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
		["x ih"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
	},
	update_debounce = 200,
})
