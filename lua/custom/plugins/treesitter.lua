return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-textobjects" }, -- Syntax aware text-objects
		{
			"nvim-treesitter/nvim-treesitter-context",  -- Show code context
			opts = { enable = true, mode = "topline", line_numbers = true }
		}
	},
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "markdown" },
			callback = function(ev)
				-- treesitter-context is buggy with Markdown files
				require("treesitter-context").disable()
			end
		})

		treesitter.setup({
			ensure_installed = {
				"dockerfile", "gitignore", "go", "gomod", "gosum",
				"gowork", "json", "lua", "markdown", "proto",
				"sql", "yaml",
			},
			indent = { enable = true },
			auto_install = true,
			sync_install = false,
			highlight = {
				enable = true,
				disable = { "csv" } -- preferring chrisbra/csv.vim
			},
			textobjects = { select = { enable = true, lookahead = true } }
		})
	end
}
