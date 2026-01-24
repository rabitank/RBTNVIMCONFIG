-- vim.keymap.set("n", "<C-a>b",function () 
  --  print("hello world")
-- end, { silent = true})

vim.keymap.set({"n", "i"}, "<C-z>", "<Cmd>undo<CR>", {silent=true})
vim.g.mapleader = " "
vim.g.maplocalleader = ","
-- vim.keymap.set("n", "<leader>aa", ":lua print('aa')<CR>")

vim.keymap.set("n", "<Leader>ih", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { noremap = true, silent = true})
