function ColorMyPencils(color)
	-- color = color or "tokyonight" or "tokyoday"
	local current_colorscheme = vim.api.nvim_exec("colorscheme", true)
	vim.cmd.colorscheme(current_colorscheme)
	-- vim.cmd.colorscheme()

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- ColorMyPencils()
