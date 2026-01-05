return {
	"ravitemer/mcphub.nvim",
	-- cmd = "MCPHub",
	event = "VeryLazy",
	dependencies = { "nvim-lua/plenary.nvim" },
	build = "bundled_build.lua",
	opts = {
		use_bundled_binary = true,
		host = "127.0.0.1",
		port = 37373,
		auto_connect = true,
		register_neovim_server = true,
		auto_start_hub = true,
		-- log_level = "info",
		log_level = "debug",
	},
}
