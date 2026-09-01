-- vim.keymap.set("n", "<C-a>b",function ()
--  print("hello world")
-- end, { silent = true})

vim.keymap.set({ "n", "i" }, "<C-z>", "<Cmd>undo<CR>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = ","
-- vim.keymap.set("n", "<leader>aa", ":lua print('aa')<CR>")

vim.keymap.set("n", "<Leader>ih", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { noremap = true, silent = true })
--
-- 行内错误提示
vim.diagnostic.config({
	virtual_text = true,
	signs = false,
	update_in_insert = true,
	underline = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
	},
})
-- 底部错误列表
-- Toggle diagnostics location list (safe version)
vim.keymap.set("n", "<leader>el", function()
  -- 获取当前 buffer 的所有诊断
  local diags = vim.diagnostic.get(0)
  
  if #diags == 0 then
    -- 没有诊断：关闭列表（如果开着）
    pcall(vim.cmd, "lclose")
    print("No diagnostics found")
    return
  end

  -- 检查 location list 是否已打开
  local winid = vim.fn.getloclist(0, { winid = 0 }).winid
  if winid ~= 0 then
    -- 已打开：关闭
    vim.cmd("lclose")
  else
    -- 未打开：先填充诊断到 location list，再打开
    vim.diagnostic.setloclist()
    vim.cmd("lopen")
  end
end, { desc = "Toggle Diagnostics List" })

-- 显示错误浮动窗口
vim.keymap.set("n", "<leader>ef", vim.diagnostic.open_float, { desc = "Show Diagnostics" })

-- 终端模式下，双击 ESC 退出
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { noremap = true })

-- -- open terminal
-- vim.keymap.set('n', '<leader>t', '<cmd>terminal<CR>', { desc = "Open terminal" })
-- vim.keymap.set('n', '<leader>vt', '<cmd>vsplit term://bash<CR>', { desc = "Open terminal vertical" })
-- vim.keymap.set('n', '<leader>ht', '<cmd>split term://bash<CR>', { desc = "Open terminal horizontal" })
