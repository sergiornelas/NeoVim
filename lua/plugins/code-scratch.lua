return {
	{
		"metakirby5/codi.vim",
		event = "VeryLazy",
		config = function()
			vim.cmd([[
          let g:codi#aliases = {
          \ 'javascriptreact': 'javascript',
          \ 'typescriptreact': 'typescript',
          \ }
			 ]])
		end,
		-- npm i -g typescript
		-- npm i -g tsun
	},
	{
		"CRAG666/code_runner.nvim",
		cmd = { "RunCode", "RunFile" },
		opts = {
			focus = false,
			startinsert = false,
			term = {
				size = 13,
			},
			filetype = {
				javascript = "nvm use latest && node --watch",
				typescript = "deno run --allow-net --watch",
				javascriptreact = "nvm use latest && node --watch",
				typescriptreact = "deno run --allow-net --watch",
			},
		},
	},
}
