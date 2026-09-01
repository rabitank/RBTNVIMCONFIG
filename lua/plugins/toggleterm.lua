-- 配置 toggleterm
return {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup({
      size = 30,
      open_mapping = [[<C-t>]],  -- 按 Ctrl+t 打开/关闭浮动终端
      start_in_insert = true,
      direction = "vertical",
    })
  end
}
