-- /home/stevearc/.config/nvim/lua/overseer/template/user/run_script.lua
return {
	name = "Run Python Script",
	builder = function()
		local file = vim.fn.expand("%:p")
		return {
			cmd = { "python" },
			args = { file },
			components = {
				{ "on_output_quickfix", set_diagnostics = true },
				"on_result_diagnostics",
				"default",
			},
		}
	end,
	condition = {
		filetype = { "python" },
	},
}
