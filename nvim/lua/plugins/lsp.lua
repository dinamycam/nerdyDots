-- lua/plugins/lsp.lua
return {
	"mason-org/mason-lspconfig.nvim",
	opts = {
		ensure_installed = { "lua_ls", "pyright", "rust_analyzer" }, -- Example: Automatically install these servers
	},
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} }, -- Configuration options for Mason
		"neovim/nvim-lspconfig", -- Neovim's built-in LSP configuration
	},
	config = function()
		-- After lazy.nvim loads plugins, this function will be called
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})
		require("mason-lspconfig").setup()

		-- Configure individual LSP servers here
		-- Not needed, as mason-lspconfig autoloads necessary lsp for ft
	end,
}
