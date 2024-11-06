local function get_java_class_name(file_path)
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	for _, line in ipairs(lines) do
		local class_match = line:match("^public%s+class%s+(%w+)")
		if class_match then
			return class_match
		end
	end
	return nil
end

return {
	name = "Run Script",
	builder = function()
		local file = vim.fn.expand("%:p")
		local file_type = vim.bo.filetype

		if file_type == "java" then
			local class_name = get_java_class_name(file)
			return {
				cmd = { "java", class_name },
				components = {
					{ "on_output_quickfix", set_diagnostics = true },
					"on_result_diagnostics",
					"default",
				},
				on_success = function()
					-- No additional action needed for Java programs
				end,
			}
		elseif file_type == "cpp" then
			local executable = vim.fn.expand("%:p:r") -- for C++ executables
			return {
				cmd = { executable },
				components = {
					{ "on_output_quickfix", set_diagnostics = true },
					"on_result_diagnostics",
					"default",
				},
				on_success = function()
					-- No additional action needed for C++ programs
				end,
			}
		else
			vim.notify("Unsupported file type: " .. file_type, vim.log.levels.ERROR)
			return nil
		end
	end,
	condition = {
		filetype = { "java", "cpp" },
	},
}
