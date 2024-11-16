local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Function to center the text
local function center_text(text)
	local lines = type(text) == "table" and text or { text }
	local window_width = vim.o.columns
	local centered_text = {}

	for _, line in ipairs(lines) do
		local padding = math.floor((window_width - vim.fn.strwidth(line)) / 2)
		table.insert(centered_text, string.rep(" ", padding) .. line)
	end
	return centered_text
end

-- Original ASCII art header
local header_text = {
	"███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
	"████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
	"██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
	"██║╚██╗██║██╔══╝  ██║   ██║██║   ██║██║██║╚██╔╝██║",
	"██║ ╚████║███████╗╚██████╔╝╚██████╔╝██║██║ ╚═╝ ██║",
	"╚═╝  ╚═══╝╚══════╝ ╚══════╝  ╚═════╝ ╚═╝╚═╝    ╚═╝",
	"",
}

-- Motivational messages
local motivational_messages = {
	"🌟 Today is a perfect day to write amazing code!",
	"💡 Every line of code is a step toward mastery",
	"🚀 Dream big, code bigger!",
	"⭐ Your potential is infinite, just like your vim buffers",
	"🎯 Focus on progress, not perfection",
	"💪 You've got this! One function at a time",
	"🌈 Coding is poetry for computers - make it beautiful",
	"🎨 Create something awesome today",
	"⚡ Your code can change the world",
	"🔥 Debug like a detective, code like an artist",
	"🌱 Growth happens outside your comfort zone",
	"💻 Every bug you fix makes you stronger",
	"🎸 Code with passion, debug with patience",
	"🎮 Level up your skills with every session",
	"🎯 Small progress is still progress",
	"🌟 You're not just coding, you're crafting solutions",
	"💫 Make today's code better than yesterday's",
	"🚀 Embrace the challenges, they make you stronger",
	"⚡ Your creativity knows no bounds",
	"🎨 Code is art, and you're the artist",
}

-- Star animation frames
local star_frames = {
	"✧",
	"✦",
	"✯",
	"⋆",
	"★",
}

-- Initialize empty header for animation
local animated_header = {}
for _ = 1, #header_text do
	table.insert(animated_header, "")
end

dashboard.section.header.val = animated_header

-- Configure buttons with centering
local button = dashboard.button
dashboard.section.buttons.val = {
	button("e", "📄  New file", ":ene <BAR> startinsert <CR>"),
	button("f", "🔍  Find file", ":Telescope find_files<CR>"),
	button("r", "🕘  Recent files", ":Telescope oldfiles<CR>"),
	button("y", "🖥  Terminal", ":ToggleTerm<CR>"),
	button("q", "🚪  Quit Neovim", ":qa<CR>"),
}

-- Add motivational message section with centering configuration
dashboard.section.message = {
	type = "text",
	val = "",
	opts = {
		position = "center",
		hl = "Comment",
	},
}

-- Center the buttons section
dashboard.section.buttons.opts = {
	spacing = 1,
	position = "center",
}

-- Update layout to include message
dashboard.config = {
	layout = {
		{ type = "padding", val = 13 },
		dashboard.section.header,
		{ type = "padding", val = 2 },
		dashboard.section.message,
		{ type = "padding", val = 4 },
		dashboard.section.buttons,
		{ type = "padding", val = 2 },
		dashboard.section.footer,
	},
	opts = {
		margin = 3,
		noautocmd = false,
	},
}

-- Set up footer
dashboard.section.footer.opts = {
	position = "center",
	hl = "Comment",
}

-- Initial setup
alpha.setup(dashboard.config)

-- Create autocmd for updating stats and animations
vim.api.nvim_create_autocmd("User", {
	pattern = "LazyVimStarted",
	callback = function()
		local stats = require("lazy").stats()

		-- Select random motivational message
		local message = motivational_messages[math.random(#motivational_messages)]
		dashboard.section.message.val = message

		-- Header typing animation
		local current_chars = {}
		for i = 1, #header_text do
			current_chars[i] = 0
		end

		-- Create reference to timers for proper cleanup
		local header_timer = vim.loop.new_timer()
		local star_pos = 1
		local star_frame = 1
		local header_active = true

		header_timer:start(
			0,
			20,
			vim.schedule_wrap(function()
				if not header_active then
					return
				end

				local any_incomplete = false

				for i = 1, #header_text do
					if current_chars[i] < #header_text[i] then
						current_chars[i] = current_chars[i] + 1
						animated_header[i] = string.sub(header_text[i], 1, current_chars[i])

						-- Add star animation
						if i == star_pos then
							animated_header[i] = animated_header[i] .. " " .. star_frames[star_frame]
						end

						any_incomplete = true
					else
						animated_header[i] = header_text[i]
					end
				end

				-- Update star position and frame
				star_frame = (star_frame % #star_frames) + 1
				if vim.fn.fmod(vim.loop.now(), 100) < 50 then
					star_pos = (star_pos % #header_text) + 1
				end

				dashboard.section.header.val = animated_header
				pcall(vim.cmd.AlphaRedraw)

				if not any_incomplete then
					header_active = false
					if not header_timer:is_closing() then
						header_timer:stop()
						header_timer:close()
					end
				end
			end)
		)

		-- Footer loading animation with counter
		local target_plugins = stats.loaded
		local target_time = math.floor(stats.startuptime * 100 + 0.5) / 100
		local current_plugins = 0
		local current_time = 0
		local start_time = vim.loop.now()
		local duration = 2000 -- 2 seconds animation

		local footer_timer = vim.loop.new_timer()
		local footer_active = true

		footer_timer:start(
			0,
			50,
			vim.schedule_wrap(function()
				if not footer_active then
					return
				end

				local elapsed = vim.loop.now() - start_time
				local progress = math.min(elapsed / duration, 1)

				current_plugins = math.floor(progress * target_plugins)
				current_time = progress * target_time

				dashboard.section.footer.val = string.format(
					"⚡ Wilsom's Neovim loaded %d/%d plugins in %.2fms",
					current_plugins,
					stats.count,
					current_time
				)
				pcall(vim.cmd.AlphaRedraw)

				if progress >= 1 then
					footer_active = false
					if not footer_timer:is_closing() then
						footer_timer:stop()
						footer_timer:close()
					end
				end
			end)
		)
	end,
})

-- Handle lazy.nvim case
vim.api.nvim_create_autocmd("User", {
	pattern = "AlphaReady",
	callback = function()
		if vim.bo.filetype == "lazy" then
			vim.cmd.close()
			require("lazy").show()
		end
	end,
})
