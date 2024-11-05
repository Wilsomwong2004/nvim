return {
	name = "g++ build",
	builder = function()
		local file = vim.fn.expand("%:p")
		local output = vim.fn.expand("%:p:r") -- removes extension
		return {
			cmd = { "g++" },
			args = { file, "-o", output },
			components = { { "on_output_quickfix", open = true }, "default" },
		}
	end,
	condition = {
		filetype = { "cpp" },
	},
}
