local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- set no comment in next line
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	command = "set formatoptions-=ro",
})

-- highlight yank
autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- fix select mode diagnostic
local diag_in_select = augroup("diag_in_select", { clear = true })
autocmd("ModeChanged", {
	group = diag_in_select,
	pattern = "*:s",
	callback = function()
		vim.diagnostic.enable(false)
	end,
})
autocmd("ModeChanged", {
	group = diag_in_select,
	pattern = "[is]:n",
	callback = function()
		vim.diagnostic.enable()
	end,
})

-- For settings that need to be reapplied on colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("refresh_transparency", { clear = true }),
	callback = function()
		vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
		vim.cmd("highlight NonText guibg=NONE ctermbg=NONE")
		-- Reapply settings for floating windows on colorscheme change
		vim.cmd("highlight NormalFloat guibg=NONE")
		vim.cmd("highlight FloatBorder guibg=NONE")

		vim.api.nvim_set_hl(0, "TabLineFill", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "TabLineNone", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "TabLine", { bg = "NONE" })

		-- Make statusline transparent
		vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })
	end,
})

-- fix padding on terminal
vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
	callback = function()
		local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
		if not normal.bg then
			return
		end
		io.write(string.format("\027]11;#%06x\027\\", normal.bg))
	end,
})

vim.api.nvim_create_autocmd("UILeave", {
	callback = function()
		io.write("\027]111\027\\")
	end,
})

-- auto trigger fold
local auto_view = augroup("auto_view", { clear = true })
autocmd({ "BufWinLeave", "BufWritePost", "WinLeave" }, {
	desc = "Save view with mkview for real files",
	group = auto_view,
	callback = function(args)
		if vim.b[args.buf].view_activated then
			vim.cmd.mkview({ mods = { emsg_silent = true } })
		end
	end,
})
autocmd("BufWinEnter", {
	desc = "Try to load file view if available and enable view saving for real files",
	group = auto_view,
	callback = function(args)
		if not vim.b[args.buf].view_activated then
			local filetype = vim.api.nvim_get_option_value("filetype", { buf = args.buf })
			local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
			local ignore_filetypes = { "gitcommit", "gitrebase" }
			if buftype == "" and filetype and filetype ~= "" and not vim.tbl_contains(ignore_filetypes, filetype) then
				vim.b[args.buf].view_activated = true
				vim.cmd.loadview({ mods = { emsg_silent = true } })
			end
		end
	end,
})
