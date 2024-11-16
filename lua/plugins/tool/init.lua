return {
	{
		"nvim-tree/nvim-tree.lua",
		lazy = true,
		cmd = {
			"NvimTreeToggle",
			"NvimTreeOpen",
			"NvimTreeFindFile",
			"NvimTreeFindFileToggle",
			"NvimTreeRefresh",
		},
		config = require("plugins.tool.config.nvim-tree"),
		keys = {
			{ "<C-n>", ":NvimTreeToggle<CR>", desc = "Toggle NvimTree", mode = "n" },
			{
				"<C-b>",
				":NvimTreeOpen C:\\Users\\wilso\\OneDrive\\Code\\Wil-s-Drive<CR>"
					.. ":cd C:\\Users\\wilso\\OneDrive<CR>",
				desc = "Open Wil's Drive",
				mode = "n",
				silent = true,
			},
		},
	},

	{
		"folke/which-key.nvim",
		lazy = true,
		event = { "CursorHold", "CursorHoldI" },
		config = require("plugins.tool.config.which-key"),
		dependencies = "echasnovski/mini.icons",
	},

	{
		"dstein64/vim-startuptime",
		lazy = true,
		event = "CmdlineEnter",
	},
	{
		"michaelb/sniprun",
		lazy = true,
		-- You need to cd to `~/.local/share/nvim/site/lazy/sniprun/` and execute `bash ./install.sh`,
		-- if you encountered error about no executable sniprun found.
		event = { "CursorHold", "CursorHoldI" },
		build = "bash ./install.sh",
		cmd = { "SnipRun", "SnipReset", "SnipInfo" },
		config = require("plugins.tool.config.sniprun"),
	},
	{
		"luozhiya/fittencode.nvim",
		lazy = false,
		config = function()
			require("fittencode").setup({
				log = {
					level = vim.log.levels.TRACE,
				},
			})
		end,
		keys = {
			{ "<Space>ad", "<cmd>Fitten document_code<CR>", desc = "Document code", mode = "n" },
			{ "<Space>ae", "<cmd>Fitten edit_code<CR>", desc = "Edit Code", mode = "n" },
			{ "<Space>aE", "<cmd>Fitten explain_code<CR>", desc = "Explain Code", mode = "n" },
			{ "<Space>ac", "<cmd>Fitten start_chat<CR>", desc = "Start Chat", mode = "n" },
			{ "<Space>as", "<cmd>Fitten show_chat<CR>", desc = "Show Chat Windows", mode = "n" },
			{ "<Space>at", "<cmd>Fitten toggle_chat<CR>", desc = "Toggle Chat Windows", mode = "n" },
		},
	},
	{
		"akinsho/toggleterm.nvim",
		keys = {
			{ [[<C-\>]] },
			{ [[<C-S-\>]], ":ToggleTerm direction=horizontal<CR>" },
		},
		lazy = true,
		cmd = {
			"ToggleTerm",
			"ToggleTermSetName",
			"ToggleTermToggleAll",
			"ToggleTermSendVisualLines",
			"ToggleTermSendCurrentLine",
			"ToggleTermSendVisualSelection",
		},
		config = require("plugins.tool.config.toggleterm"),
	},

	-- {
	-- 	"folke/trouble.nvim",
	-- 	enabled = false,
	-- 	lazy = true,
	-- 	cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
	-- 	config = require("plugins.tool.config.trouble"),
	-- },

	{
		"gelguy/wilder.nvim",
		lazy = true,
		event = "CmdlineEnter",
		config = require("plugins.tool.config.wilder"),
		dependencies = {
			"romgrk/fzy-lua-native",
		},
	},
	{
		"barrett-ruth/live-server.nvim",
		build = "pnpm add -g live-server",
		cmd = { "LiveServerStart", "LiveServerStop" },
		config = true,
	},
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		cmd = "Telescope",
		config = require("plugins.tool.config.telescope"),
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-lua/plenary.nvim" },
			{ "debugloop/telescope-undo.nvim" },
			{ "jvgrootveld/telescope-zoxide" },
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		keys = {
			{ "<leader>tt", "<cmd>Telescope<CR>", desc = "Telescope", mode = "n" },
			{ "<leader>tl", "<cmd>Telescope live_grep<CR>", desc = "Live Grep", mode = "n" },
			{ "<leader>tf", "<cmd>Telescope find_files<CR>", desc = "Find Files", mode = "n" },
		},
	},
	{
		"Shatur/neovim-session-manager",
		lazy = true,
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			local Path = require("plenary.path")
			require("session_manager").setup({
				sessions_dir = Path:new(vim.fn.stdpath("data"), "sessions"), -- Directory where sessions are saved
				autoload_mode = require("session_manager.config").AutoloadMode.LastSession,
			})
		end,
	},

	{
		"ahmedkhalf/project.nvim",
		lazy = true,
		dependencies = {
			"nvim-telescope/telescope.nvim", -- Ensure Telescope is loaded before project.nvim
		},
		config = function()
			require("project_nvim").setup({
				-- Configure patterns for detecting project root
				detection_methods = { "pattern" },
				patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
			})
			--enable telescope integration
			require("telescope").load_extension("project")
		end,
	},

	-- TODO:
	-- {
	-- 	"mfussenegger/nvim-dap",
	-- 	lazy = true,
	-- 	cmd = {
	-- 		"DapSetLogLevel",
	-- 		"DapShowLog",
	-- 		"DapContinue",
	-- 		"DapToggleBreakpoint",
	-- 		"DapToggleRepl",
	-- 		"DapStepOver",
	-- 		"DapStepInto",
	-- 		"DapStepOut",
	-- 		"DapTerminate",
	-- 	},
	-- 	config = require("plugins.tool.config.dap"),
	-- 	dependencies = {
	-- 		{
	-- 			"rcarriga/nvim-dap-ui",
	-- 			config = require("plugins.tool.config.dap.dapui"),
	-- 			dependencies = {
	-- 				"nvim-neotest/nvim-nio",
	-- 			},
	-- 		},
	-- 		{ "jay-babu/mason-nvim-dap.nvim" },
	-- 	},
	-- }

	{
		"amitds1997/remote-nvim.nvim",
		lazy = true,
		event = "CmdlineEnter",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = true,
		-- config = require("plugins.tool.config.remote-nvim"),
	},

	{
		"nosduco/remote-sshfs.nvim",
		lazy = true,
		event = "CmdlineEnter",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = require("plugins.tool.config.remote-sshfs"),
	},

	{
		"sindrets/diffview.nvim",
		lazy = true,
		event = "CmdlineEnter",
		keys = {
			{ "<leader>dd", "<cmd>DiffviewOpen", desc = "DiffView Open" },
			{ "<leader>dc", "<cmd>DiffviewClose", desc = "DiffView Close" },
		},
	},
	{
		"rbong/vim-flog",
		lazy = true,
		cmd = { "Flog", "Flogsplit", "Floggit" },
		dependencies = {
			"tpope/vim-fugitive",
		},
		keys = {
			{ "<leader>gff", "<cmd>Flog<CR>", desc = "Git Graph (full)" },
			{ "<leader>gfs", "<cmd>Flogsplit<CR>", desc = "Git Graph (split)" },
			{ "<leader>gft", "<cmd>Floggit<CR>", desc = "Floggit" },
		},
	},
	{
		"stevearc/overseer.nvim",
		lazy = true,
		event = "CmdlineEnter",
		config = require("plugins.tool.config.overseer"),
		keys = {
			{ "<F5>", "<cmd>OverseerRun<CR>", desc = "OverseerRun" },
			{
				"<F6>",
				function()
					if vim.g.overseer_is_open then
						vim.cmd("OverseerClose")
						vim.g.overseer_is_open = false
					else
						vim.cmd("OverseerOpen")
						vim.g.overseer_is_open = true
					end
				end,
				desc = "Toggle Overseer",
			},
			{ "<F7>", "<cmd>OverseerQuickAction<CR>", desc = "OverseerQuickAction" },
		},
	},
}
