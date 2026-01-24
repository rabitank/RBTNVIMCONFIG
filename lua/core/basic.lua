vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true
vim.opt.colorcolumn = "110"

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0

vim.opt.autoread = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.hlsearch = true
vim.opt.showmode = false

vim.opt.clipboard = "unnamedplus" -- sys use '+' register as clb -> sys use default register as clb
vim.opt.nrformats = "bin,hex,alpha" -- enable to plus/minus character (use ctrl a, ctrl x)

vim.opt.showtabline = 2
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.backup = false
vim.opt.fileencoding = "utf-8"

vim.opt.updatetime = 400
vim.opt.termguicolors =  true -- use true color 24bits

vim.opt.cursorline = true
vim.opt.mouse = 'a'  -- all mods enable mouse

vim.o.background = dark

vim.lsp.inlay_hint.enable()

vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.bo.tabstop = 2 -- bo -> buffer opt, wo -> window opt
		vim.bo.shiftwidth = 0 -- recover nvim sys default shiftwidth for python
		vim.wo.colorcolumn = "120"
	end,
})
