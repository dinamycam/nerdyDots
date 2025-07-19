return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
		options = {
			diagnostics = "nvim_lsp",
			mode = "buffers",
			hover = {
				enabled = true,
				delay = 150,
				reveal = { "close" },
			},
			offsets = {
				{
					filetype = "neo-tree",
					text = "File Explorer",
					highlight = "Directory",
					seperator = true,
				},
			},
		},
	},
}
