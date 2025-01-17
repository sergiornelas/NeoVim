return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	build = "make",
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{
			"crispgm/telescope-heading.nvim",
		},
		{
			"allaman/emoji.nvim",
			opts = {
				enable_cmp_integration = false,
			},
		},
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local actions = require("telescope.actions")

		local send_find_files_to_live_grep = function()
			local files = {}
			local prompt_bufnr = vim.api.nvim_get_current_buf()
			require("telescope.actions.utils").map_entries(prompt_bufnr, function(entry, _, _)
				table.insert(files, entry[0] or entry[1])
			end)
			builtin.live_grep({
				search_dirs = files,
			})
		end

		function Paste_image()
			builtin.find_files({
				attach_mappings = function(_, map)
					local function embed_image(prompt_bufnr)
						local entry = require("telescope.actions.state").get_selected_entry()
						local filepath = entry[1]
						actions.close(prompt_bufnr)
						local img_clip = require("img-clip")
						img_clip.paste_image(nil, filepath)
					end
					map("i", "<c-j>", embed_image)
					map("n", "<c-j>", embed_image)
					return true
				end,
			})
		end

		telescope.setup({
			defaults = {
				layout_strategy = "vertical", --horizontal/vertical/flex
				sorting_strategy = "ascending", --important
				winblend = 6,
				results_title = "",
				layout_config = {
					vertical = {
						width = 90,
						height = 60,
					},
				},
				-- previewer = false
				-- mirror = true,
				-- prompt_position = "top",
				-- preview_cutoff = 120,
				-- height = 0.60, (percentages)
				-- width = { 0.52, max = 0.52, min = 0.52 },
				-- initial_mode = "insert",
				prompt_prefix = "  ",
				selection_caret = "  ",
				path_display = { "smart" },
				mappings = {
					i = {
						["<c-i>"] = actions.move_selection_next,
						["<c-o>"] = actions.move_selection_previous,
						["<c-j>"] = actions.select_default,
						["<c-m>"] = actions.cycle_history_next,
						["<c-;>"] = actions.cycle_history_prev,
						["<c-z>"] = actions.to_fuzzy_refine,
						["<esc>"] = actions.close,
						["<c-space>"] = actions.close,
						["<c-n>"] = actions.toggle_selection + actions.move_selection_worse,
						["<c-p>"] = actions.toggle_selection + actions.move_selection_better,
						-- ["<c-q>"] = actions.send_to_qflist + actions.open_qflist,
						["<c-b>"] = actions.send_selected_to_qflist + actions.open_qflist,
						-- select_all, -- select all telescope results
						-- drop_all, -- deselect all telescope results
						-- select_drop, -- move to current current buffer position window, not new buffer. Drop deletes arglist
						-- git_rename_branch -- not added
						-- send_selected_to_loclist -- not added
						-- actions.delete_mark, -- eliminate element/s from telescope results
					},
				},
				file_ignore_patterns = {
					"%.sc",
					"%.png",
					"%.mp3",
					"%.wav",
					"%.oga",
					"%.ogg",
					-- https://www.squash.io/how-to-git-ignore-node-modules-folder-everywhere/
					-- "node_modules/.*",
				},
			},
			pickers = {
				find_files = {
					mappings = {
						i = {
							["<c-e>"] = send_find_files_to_live_grep,
						},
					},
				},
				colorscheme = {
					enable_preview = true,
					ignore_builtins = true,
				},
				buffers = {
					ignore_current_buffer = true, -- if true, don't show the current buffer in the list
					only_cwd = false, -- if true, only show buffers in the current working directory
					sort_lastused = true, -- Sorts current and last buffer to the top and selects the lastused
					sort_mru = true, -- Sorts all buffers after most recent used. Not just the current and last one
					mappings = {
						i = {
							["<c-e>"] = actions.delete_buffer,
						},
					},
				},
				git_status = {
					mappings = {
						i = {
							["<c-i>"] = actions.move_selection_next,
							["<c-e>"] = actions.git_staging_toggle,
						},
					},
				},
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},
				heading = {
					treesitter = true,
					picker_opts = {
						layout_config = { width = 0.6, preview_width = 0.5 },
						layout_strategy = "vertical",
					},
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("heading")
		telescope.load_extension("emoji")

		-- Token  	       Match type           	          Description
		-- -------+-----------------------------+-----------------------------------
		-- sbtrkt 	fuzzy-match                 	Items that match sbtrkt
		-- 'wild  	exact-match (quoted)        	Items that include wild
		-- ^music 	prefix-exact-match          	Items that start with music
		-- .mp3$  	suffix-exact-match          	Items that end with .mp3
		-- !fire  	inverse-exact-match         	Items that do not include fire
		-- !^music	inverse-prefix-exact-match  	Items that do not start with music
		-- !.mp3$ 	inverse-suffix-exact-match  	Items that do not end with .mp3
	end,
	keys = {
		-- File Pickers
		{ "<leader>fi", "<cmd>Telescope find_files<cr>" },
		{ "<leader>gf", "<cmd>Telescope git_files<cr>" },
		{ "<leader>fw", "<cmd>Telescope grep_string<cr>", mode = { "n", "x" } },
		{ "<leader>fl", "<cmd>Telescope live_grep<cr>" },
		-- Vim pickers
		{ "<leader>fo", "<cmd>Telescope buffers theme=dropdown prompt_title=Teleport<cr>" },
		{ "<leader>fd", "<cmd>Telescope oldfiles theme=ivy<cr>" },
		-- { "<leader>", "<cmd>Telescope commands<cr>" },
		-- { "<leader>", "<cmd>Telescope tags<cr>" },
		{ "<leader>:", "<cmd>Telescope command_history layout_config={height=30}<cr>" },
		{ "<leader>/", "<cmd>Telescope search_history layout_config={height=30}<cr>" },
		{ "<leader>H", "<cmd>Telescope help_tags theme=ivy<cr>" },
		-- { "<leader>", "<cmd>Telescope man_pages<cr>" },
		{ "<leader>fm", "<cmd>Telescope marks<cr>" },
		-- { "<leader>c", "<cmd>Telescope colorscheme<cr>" }, -- added in colorschemes.lua
		{ "<leader>fq", "<cmd>Telescope quickfix<cr>" },
		{ "<leader>fQ", "<cmd>Telescope quickfixhistory<cr>" },
		{ "<leader>fs", "<cmd>Telescope loclist<cr>" },
		{ "<leader>fj", "<cmd>Telescope jumplist<cr>" },
		{ "<leader>fv", "<cmd>Telescope vim_options<cr>" },
		{ "<leader>fr", "<cmd>Telescope registers theme=dropdown layout_config={height=50}<cr>" },
		-- { "<leader>", "<cmd>Telescope autocommands<cr>" },
		{ "<leader>fp", "<cmd>Telescope spell_suggest theme=cursor layout_config={height=15}<cr>" },
		{ "<leader>fk", "<cmd>Telescope keymaps<cr>" },
		{ "<leader>fy", "<cmd>Telescope filetypes<cr>" },
		-- { "<leader>", "<cmd>Telescope highlights<cr>" },
		{ "<leader>ff", "<cmd>Telescope current_buffer_fuzzy_find<cr>" },
		{ "<leader>fb", "<cmd>Telescope current_buffer_tags<cr>" },
		{ "<leader>;", "<cmd>Telescope resume<cr>" },
		-- { "<leader>", "<cmd>Telescope pickers<cr>" },
		-- Neovim LSP Pickers
		-- { "<leader>", "<cmd>Telescope lsp_references<cr>" },
		-- { "<leader>", "<cmd>Telescope lsp_incoming_calls<cr>" },
		-- { "<leader>", "<cmd>Telescope lsp_outgoing_calls<cr>" },
		-- { "<leader>", "<cmd>Telescope lsp_document_symbols<cr>" },
		-- { "<leader>", ":Telescope lsp_workspace_symbols query=" },
		{ "<leader>ly", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>" },
		-- { " leader>", "<cmd>Telescope diagnostics theme=dropdown<cr>" },
		-- { "<leader>", "<cmd>Telescope lsp_implementations<cr>" },
		-- { "<leader>", "<cmd>Telescope lsp_definitions<cr>" },
		-- { "<leader>", "<cmd>Telescope lsp_type_definitions<cr>" },
		-- Git Pickers
		{ "<leader>gc", "<cmd>Telescope git_commits<cr>" },
		{ "<leader>gm", "<cmd>Telescope git_bcommits<cr>" },
		{ "<leader>gM", "<cmd>Telescope git_bcommits_range<cr>" },
		{ "<leader>gr", "<cmd>Telescope git_branches<cr>" },
		{ "<leader>gs", "<cmd>Telescope git_status<cr>" },
		{ "<leader>gh", "<cmd>Telescope git_stash<cr>" },
		-- Treesitter Pickers
		{ "<leader>ft", "<cmd>Telescope treesitter<cr>" },
		-- Lists Pickers
		-- { "<leader>", "<cmd>Telescope planets<cr>" },
		-- { "<leader>", "<cmd>Telescope builtin<cr>" },
		-- { "<leader>", "<cmd>Telescope reloader<cr>" },
		-- { "<leader>", "<cmd>Telescope symbols<cr>" },
		-- Not included in Github
		-- { "<leader>", "<cmd>Telescope tagstack<cr>" },
		-- { "<leader>", "<cmd>Telescope fd<cr>" },
		-- Plugins
		{ "<c-g><c-e>", "<cmd>Telescope emoji theme=cursor layout_config={height=14}<cr>", mode = { "i" } },
		{ "<leader>fh", "<cmd>Telescope heading<cr>" },
		{ "<leader>fP", "<cmd>lua Paste_image()<cr>" },
		{ "<c-space>", "<cmd>Telescope session-lens<cr>" },
	},
}
