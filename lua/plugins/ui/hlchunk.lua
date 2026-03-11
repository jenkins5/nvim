-- Auto-detect actual indent width from buffer content
-- instead of relying on shiftwidth option
local function detect_indent(bufnr)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, math.min(200, vim.api.nvim_buf_line_count(bufnr)), false)
	local function gcd(a, b)
		while b ~= 0 do
			a, b = b, a % b
		end
		return a
	end
	local result = 0
	for _, line in ipairs(lines) do
		local spaces = line:match("^( +)%S")
		if spaces then
			local indent = #spaces
			result = result == 0 and indent or gcd(result, indent)
		end
	end
	return result > 0 and result or vim.fn.shiftwidth()
end

-- Sync shiftwidth to match actual content after formatting
local function setup_indent_sync()
	vim.api.nvim_create_autocmd({ "BufWritePost", "TextChanged" }, {
		group = vim.api.nvim_create_augroup("hlchunk_indent_sync", { clear = true }),
		callback = function(ev)
			local bufnr = ev.buf
			if not vim.api.nvim_buf_is_valid(bufnr) then
				return
			end
			local detected = detect_indent(bufnr)
			local current_sw = vim.bo[bufnr].shiftwidth
			if detected ~= current_sw and detected > 0 then
				vim.bo[bufnr].shiftwidth = detected
				vim.bo[bufnr].tabstop = detected
			end
		end,
	})
end

return {
	"shellRaining/hlchunk.nvim",
	event = { "BufNewFile", "BufReadPre" },
	config = function()
		require("hlchunk").setup({
			chunk = {
				enable = true,
				use_treesitter = true,
				style = {
					{ fg = "#806d9c" },
				},
			},
			indent = {
				enable = true,
				use_treesitter = false,
				chars = {
					"│",
				},
				style = {
					vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
				},
			},
			line_num = {
				enable = false,
				use_treesitter = true,
				style = "#00ffff",
			},
			blank = {
				enable = false,
			},
		})
		setup_indent_sync()
	end,
}
