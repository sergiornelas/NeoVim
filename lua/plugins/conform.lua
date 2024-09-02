return {
	"stevearc/conform.nvim",
	keys = {
		{ "<leader>w", "<cmd>w<cr>" },
	},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				json = { "prettierd" },
				css = { "prettierd" },
				-- html = { "prettierd" },
				-- mjml = { "prettierd" },
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
				markdown = { "markdownlint" },
			},
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})
	end,
}
