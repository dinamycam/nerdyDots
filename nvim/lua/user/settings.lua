-- Basic Neovim Configuration

-- General settings
vim.opt.number = true -- Show line numbers
-- vim.opt.relativenumber = true        -- Show relative line numbers
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 4 -- Number of spaces for indentation
vim.opt.tabstop = 4 -- Number of spaces a tab counts for
vim.opt.smartindent = true -- Smart indentation
vim.opt.wrap = false -- Disable line wrapping
vim.opt.hlsearch = false -- Highlight search results
vim.opt.incsearch = true -- Incremental search
-- vim.opt.termguicolors = true         -- Enable 24-bit RGB colors (heh, already enabled)
vim.opt.scrolloff = 8 -- Keep 8 lines above/below the cursor
-- vim.opt.signcolumn = "yes"           -- Always show the sign column

-- neovide setup
if vim.g.neovide then
	-- vim.o.guifont = "Fira Code:h7"
	vim.opt.linespace = 2
	-- vim.g.neovide_scale_factor = 0.5

	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0

	vim.g.neovide_floating_shadow = true
	vim.g.neovide_floating_z_height = 10
	vim.g.neovide_light_angle_degrees = 45
	vim.g.neovide_light_radius = 5

	vim.g.neovide_opacity = 0.92

	vim.g.neovide_refresh_rate_idle = 5

	vim.g.neovide_remember_window_size = true

	vim.g.neovide_cursor_vfx_mode = "railgun"
	vim.g.neovide_cursor_trail_size = 0.4
end

-- Key mappings
if vim.g.neovide then
	vim.keymap.set("n", "<C-s>", ":w<CR>") -- Save
	vim.keymap.set("v", "<C-c>", '"+y') -- Copy
	vim.keymap.set("n", "<C-v>", '"+P') -- Paste normal mode
	vim.keymap.set("v", "<C-v>", '"+P') -- Paste visual mode
	vim.keymap.set("c", "<C-v>", "<C-R>+") -- Paste command mode
	vim.keymap.set("i", "<C-v>", '<ESC>l"+Pli') -- Paste insert mode
end

vim.api.nvim_set_keymap("n", "<F2>", ":set paste!<CR>", { noremap = true, silent = true })

-- Additional configurations for plugins can go here

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "tokyonight",
		-- component_separators = "|",
		-- section_separators = "",
		disabled_types = {},
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
})
require("noice").setup({
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
		},
	},
	-- you can enable a preset for easier configuration
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false, -- add a border to hover docs and signature help
	},
})

require("colorizer").setup()

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.api.nvim_set_keymap(
	"n",
	"<C-p>",
	":lua require'telescope'.extensions.project.project{}<CR>",
	{ noremap = true, silent = true }
)

vim.api.nvim_set_keymap("n", "<leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true }) -- Toggle file explorer
require("telescope").load_extension("notify")
require("telescope").load_extension("project")
-- not configured
-- vim.lsp.enable("pyright")
