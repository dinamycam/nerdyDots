-- ~/nvim/lua/slydragonn/plugins/toggleterm.lua

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 16,
			open_mapping = [[<c-`>]],
			shading_factor = 2,
			direction = "horizontal",
			float_opts = {
				border = "curved",
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},
		})
	end,
}
