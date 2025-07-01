-- lua/plugins/lsp.lua
return {
	"mason-org/mason-lspconfig.nvim",
	opts = {
		ensure_installed = { "lua_ls", "pyright", "rust_analyzer", "marksman" }, -- Example: Automatically install these servers
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

		-- example calling setup directly for each LSP
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local lspconfig = require("lspconfig")

			lspconfig["lua_ls"].setup({ capabilities = capabilities })
			lspconfig["pyright"].setup({ capabilities = capabilities })
			lspconfig["rust_analyzer"].setup({ capabilities = capabilities })
			lspconfig["marksman"].setup({ capabilities = capabilities })
		end
		-- Not needed, as mason-lspconfig autoloads necessary lsp for ft
	end,
}
