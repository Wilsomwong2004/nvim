local overseer = require("overseer")

return {
	{
		name = "Shell",
		builder = function()
			local file = vim.fn.expand("%:p")
			local cmd = { file }

			return {
				cmd = cmd,
				components = {
					{ "on_output_quickfix", set_diagnostics = true },
					"on_result_diagnostics",
					"default",
				},
				{
					"on_success",
					cmd = { vim.fn.expand("%:r") },
				},
			}
		end,
		condition = {
			filetype = { "sh" },
		},
	},
}
