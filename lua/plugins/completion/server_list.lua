local M = {}

-- Add lsp server at here, and will be automate configure it or add custom configuration at ./server/`lsp`
M["lsp_list"] = {
	"bashls",
	"cssls",
	"html",
	"jsonls",
	"lua_ls",
	"marksman",
	"pyright",
	"tailwindcss",
	"taplo",
	"ts_ls",
	"yamlls",
	--"pylsp",
}

-- Automate download, but need for
-- modify formatter at ./config/conform.lua
-- modify lint and diagnostic at ./config/nonels.lua
M["null_ls"] = {
	-- Formatter
	"black",
	"clang-format",
	"isort",
	"prettier",
	"prettierd",
	"stylua",
	"taplo",
	"yamlfmt",
	-- "rustfmt" -- Download with system

	-- Diagnostics

	-- Lint
	"ruff",
	"shellharden",
}

return M
