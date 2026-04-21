return function()
	local deps = {
		"bash",
		"c",
		"c_sharp",
		"cpp",
		"css",
		"csv",
		"dockerfile",
		"dot",
		"fsh",
		"go",
		"gomod",
		"gosum",
		"gowork",
		"html",
		"htmldjango",
		"javascript",
		"lisp",
		"json",
		"json5",
		"julia",
		"lua",
		"luadoc",
		"luap",
		"luau",
		"markdown",
		"proto",
		"python",
		"query",
		"toml",
		"tsx",
		"typescript",
		"yaml",
	}

	vim.api.nvim_create_autocmd("FileType", {
		pattern = deps,
		callback = function(args)
			local ok, ts = pcall(require, "nvim-treesitter")
			if not ok then
				return
			end
			local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].ft)
			if lang then
				ts.install({ lang }):await() -- Await install
				vim.treesitter.start(args.buf, lang)
				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end
		end,
	})
end
