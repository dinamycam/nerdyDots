-- local M ={
--     'goolord/alpha-nvim',
--     dependencies = {
--         'echasnovski/mini.icons',
--         'nvim-lua/plenary.nvim'
--     },
--     config = function ()
--         require'alpha'.setup(
--         require'alpha.themes.theta'.config
--         )
--     end
-- };
-- return M

return {
	"goolord/alpha-nvim",
	commit = "3847d6baf74da61e57a13e071d8ca185f104dc96",
	event = { "VimEnter" },
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = function()
		local theta = require("alpha.themes.theta")
		local dashboard = require("alpha.themes.dashboard")
		local header = {
			type = "text",
			val = {
				-- [[ ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗]],
				-- [[ ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║]],
				-- [[ ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║]],
				-- [[ ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║]],
				-- [[ ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║]],
				-- [[ ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝]],
				[[                                      __              ]],
				[[                                     |  \             ]],
				[[ _______   ______   ______  __     __ \▓▓______ ____  ]],
				[[|       \ /      \ /      \|  \   /  \  \      \    \ ]],
				[[| ▓▓▓▓▓▓▓\  ▓▓▓▓▓▓\  ▓▓▓▓▓▓\\▓▓\ /  ▓▓ ▓▓ ▓▓▓▓▓▓\▓▓▓▓\]],
				[[| ▓▓  | ▓▓ ▓▓    ▓▓ ▓▓  | ▓▓ \▓▓\  ▓▓| ▓▓ ▓▓ | ▓▓ | ▓▓]],
				[[| ▓▓  | ▓▓ ▓▓▓▓▓▓▓▓ ▓▓__/ ▓▓  \▓▓ ▓▓ | ▓▓ ▓▓ | ▓▓ | ▓▓]],
				[[| ▓▓  | ▓▓\▓▓     \\▓▓    ▓▓   \▓▓▓  | ▓▓ ▓▓ | ▓▓ | ▓▓]],
				[[ \▓▓   \▓▓ \▓▓▓▓▓▓▓ \▓▓▓▓▓▓     \▓    \▓▓\▓▓  \▓▓  \▓▓]],
			},
			opts = {
				position = "center",
				hl = "Type",
			},
		}
		local links = {
			type = "group",
			val = {
				{ type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
				{ type = "padding", val = 1 },
				dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
				dashboard.button("f", "  Find files", ":Telescope find_files <CR>"),
				dashboard.button("d", "  Directories", "<cmd>Neotree float<CR>"),
				dashboard.button(
					"p",
					"  Projects",
					-- at this time, telescope-projects has not been loaded, so directly call it
					-- [[<cmd>lua require('telescope').load_extension('projects').load_commnad('projects')<CR>]]),
					[[<cmd>lua require('telescope').load_extension('projects')<CR><cmd>Telescope projects<CR>]]
				),
				dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("l", "鈴 Lazy", ":Lazy<CR>"),
				-- dashboard.button('c', '  Configuration',
				--   '<cmd>cd ' .. vim.fn.stdpath('config') .. '/lua<CR>'),
				--   '<cmd>e ' .. vim.fn.stdpath('config') .. '/lua/plugins/init.lua<CR>'),
				dashboard.button("q", "  Quit", ":qa<CR>"),
				-- dashboard.button('q', '  Quit', '<cmd>qa<CR>'),
			},
			position = "center",
		}
		local recent = require("alpha.themes.theta").config.layout[4]
		local version = vim.version() or { major = 0, minor = 0, patch = 0 }
		theta.config = {
			layout = {
				{ type = "padding", val = 2 },
				header,
				-- show neovim version
				{
					type = "text",
					val = " v" .. version.major .. "." .. version.minor .. "." .. version.patch,
					opts = { hl = "SpecialComment", position = "center" },
				},
				-- each action
				{ type = "padding", val = 2 },
				links,
				{ type = "padding", val = 2 },
				recent,
				{ type = "padding", val = 2 },
			},
			opts = {
				noautocmd = false,
				redraw_on_resize = true,
				setup = function()
					vim.api.nvim_create_autocmd("DirChanged", {
						pattern = "*",
						callback = function()
							require("alpha").redraw()
						end,
					})
				end,
			},
		}
		return theta
	end,
	config = function(_, theta)
		-- close Lazy and re-open when the dashboard is ready
		if vim.o.filetype == "lazy" then
			vim.cmd.close()
			vim.api.nvim_create_autocmd("User", {
				pattern = "AlphaReady",
				callback = function()
					require("lazy").show()
				end,
			})
		end
		require("alpha").setup(theta.config)
		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyVimStarted",
			callback = function()
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				local loaded = "⚡ Loaded " .. stats.count .. " plugins in " .. ms .. "ms"
				table.insert(theta.config.layout, {
					type = "text",
					val = loaded,
					opts = { hl = "SpecialComment", position = "center" },
				})
				pcall(vim.cmd.AlphaRedraw)
			end,
		})
	end,
}
