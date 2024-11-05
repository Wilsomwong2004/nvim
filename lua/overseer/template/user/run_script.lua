return {
	name = "run script",
	builder = function()
		local file = vim.fn.expand("%:p")
		local executable = vim.fn.expand("%:p:r") -- for C++ executables
		local cmd = { file }

		if vim.bo.filetype == "cpp" then
			cmd = { executable }
		elseif vim.bo.filetype == "go" then
			cmd = { "go", "run", file }
		end

		return {
			cmd = cmd,
			components = {
				{ "on_output_quickfix", set_diagnostics = true },
				"on_result_diagnostics",
				"default",
			},
		}
	end,
	condition = {
		filetype = { "sh", "python", "cpp", "java" },
	},
}
