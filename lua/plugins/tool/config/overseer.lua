return function()
	require("overseer").setup({
		templates = { "builtin", "user.run_script", "filetype.python", "filetype.cpp", "filetype.java" },
	})
end
