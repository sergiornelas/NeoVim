local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

if not cmp_nvim_lsp_ok then
	return
end

local keymap = vim.keymap.set

keymap("n", "gw", '<cmd>lua vim.diagnostic.open_float(0, { scope = "cursor", border = "single" })<CR>')
keymap("n", "gl", '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", border = "single" })<CR>')
keymap("n", "gB", '<cmd>lua vim.diagnostic.open_float(0, { scope = "buffer", border = "double" })<CR>')
keymap("n", "\\e", vim.diagnostic.goto_prev)
keymap("n", "\\d", vim.diagnostic.goto_next)
keymap(
	"n",
	"\\r",
	"<cmd>lua vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR, float = { border = { '╭', '~', '╮', '│', '╯', '─', '╰', '│' } } })<CR>"
)
keymap(
	"n",
	"\\f",
	"<cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR, float = { border = { '╭', '~', '╮', '│', '╯', '─', '╰', '│' } } })<CR>"
)
keymap("n", "gq", vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		local lsp = vim.lsp.buf
		local opts = { buffer = ev.buf }
		-- keymap("n", "gD", lsp.declaration, bufopts)
		keymap("n", "gd", lsp.definition, opts)
		keymap("n", "gD", "<cmd>TSToolsGoToSourceDefinition<cr>", opts)
		keymap("n", "gh", lsp.hover, opts)
		keymap("n", "gz", lsp.implementation, opts)
		keymap("n", "gs", lsp.signature_help, opts)
		keymap("n", "gA", lsp.add_workspace_folder, opts)
		keymap("n", "gF", lsp.remove_workspace_folder, opts)
		keymap("n", "gW", function()
			print(vim.inspect(lsp.list_workspace_folders()))
		end, opts)
		keymap("n", "gf", lsp.type_definition, opts)
		keymap("n", "gr", lsp.rename, opts)
		keymap({ "n", "v" }, "g<leader>", lsp.code_action, opts)
		-- keymap("n", "gR", lsp.references, bufopts)
		keymap("n", "g;", function()
			lsp.format({ async = true })
		end, opts)
	end,
	keymap("n", "gL", "<cmd>LspInfo<cr>"),
})

local M = {}

M.on_attach = function(client, bufnr)
	require("nvim-navic").attach(client, bufnr)

	if client.server_capabilities.inlayHintProvider then
		vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#747D83", bg = "#333232", italic = true })

		-- enable/disable on insert mode:
		local inlay_hints_group = vim.api.nvim_create_augroup("InlayHints", { clear = false })
		local mode = vim.api.nvim_get_mode().mode
		vim.lsp.inlay_hint(bufnr, mode == "n" or mode == "v")
		vim.api.nvim_create_autocmd("InsertEnter", {
			group = inlay_hints_group,
			buffer = bufnr,
			callback = function()
				vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#747D83", bg = "#333232", italic = true })
				vim.lsp.inlay_hint(bufnr, false)
			end,
		})
		vim.api.nvim_create_autocmd("InsertLeave", {
			group = inlay_hints_group,
			buffer = bufnr,
			callback = function()
				vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#747D83", bg = "#333232", italic = true })
				vim.lsp.inlay_hint(bufnr, true)
			end,
		})

		-- toggle manually
		-- keymap(
		-- 	"n",
		-- 	"<leader>v",
		-- 	"<cmd>lua vim.lsp.inlay_hint(" .. bufnr .. ", true)<cr>",
		-- 	{ noremap = true, silent = true }
		-- )
		-- keymap(
		-- 	"n",
		-- 	"<leader>r",
		-- 	"<cmd>lua vim.lsp.inlay_hint(" .. bufnr .. ", false)<cr>",
		-- 	{ noremap = true, silent = true }
		-- )
	end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
