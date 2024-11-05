-- java.lua
return {
	name = "Run Java script",
	builder = function()
		local file = vim.fn.expand("%:p")
		local class_name = vim.fn.expand("%:t:r")
		return {
			cmd = { "jdtls", file },
			args = {},
			components = {
				{ "on_output_quickfix", set_diagnostics = true },
				"on_result_diagnostics",
				"on_exit_set_status",
			},
			on_success = function()
				local result = os.execute(string.format("java %s", class_name))
				if result ~= 0 then
					vim.notify("Java program execution failed", vim.log.levels.ERROR)
				end
			end,
		}
	end,
	condition = {
		filetype = { "java" },
	},
}
