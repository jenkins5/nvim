return {
	"kevinhwang91/nvim-ufo",
	event = "BufReadPost",
	dependencies = "kevinhwang91/promise-async",
	config = function()
		-- virtual icon
		local handler = function(virtText, lnum, endLnum, width, truncate)
			local newVirtText = {}
			local suffix = (" %d "):format(endLnum - lnum)
			local sufWidth = vim.fn.strdisplaywidth(suffix)
			local targetWidth = width - sufWidth
			local curWidth = 0
			for _, chunk in ipairs(virtText) do
				local chunkText = chunk[1]
				local chunkWidth = vim.fn.strdisplaywidth(chunkText)
				if targetWidth > curWidth + chunkWidth then
					table.insert(newVirtText, chunk)
				else
					chunkText = truncate(chunkText, targetWidth - curWidth)
					local hlGroup = chunk[2]
					table.insert(newVirtText, { chunkText, hlGroup })
					chunkWidth = vim.fn.strdisplaywidth(chunkText)
					-- str width returned from truncate() may less than 2nd argument, need padding
					if curWidth + chunkWidth < targetWidth then
						suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
					end
					break
				end
				curWidth = curWidth + chunkWidth
			end
			table.insert(newVirtText, { suffix, "MoreMsg" })
			return newVirtText
		end

		-- ignore file type
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "leetcode.nvim", "lazy" },
			callback = function()
				require("ufo").detach()
				vim.opt_local.foldenable = false
			end,
		})
		---@diagnostic disable-next-line: missing-fields
		require("ufo").setup({
			provider_selector = function(bufnr, filetype, buftype)
				if buftype ~= "" then
					return ""
				end

				-- 大文件用 indent
				local line_count = vim.api.nvim_buf_line_count(bufnr)
				if line_count > 10000 then
					return "indent"
				end

				-- node_modules / 只读用 indent
				local filepath = vim.api.nvim_buf_get_name(bufnr)
				if filepath:match("node_modules") or vim.bo[bufnr].readonly then
					return "indent"
				end

				-- 已知没有好的 LSP 折叠支持
				local use_indent = { "python", "yaml" }
				if vim.tbl_contains(use_indent, filetype) then
					return "indent"
				end

				-- 已知有 treesitter 但 LSP 折叠不好
				local use_ts = { "markdown", "json" }
				if vim.tbl_contains(use_ts, filetype) then
					return { "treesitter", "indent" }
				end

				-- 其他：LSP 优先（ufo 会自动 fallback）
				return { "lsp", "indent" }
			end,

			close_fold_kinds_for_ft = {
				default = { "imports", "comment" },
				-- c = { "comment", "region" },
			},
			fold_virt_text_handler = handler,
		})
	end,
}
