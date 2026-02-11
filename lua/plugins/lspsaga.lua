return {
    -- 语言服务器相关快捷操作
    "nvimdev/lspsaga.nvim",
    cmd = "Lspsage",
    opts = {
        finder = {
            keys = {
                toggle_or_open = "<CR>", -- find var usage
            }
        }
    },
    keys = {
        { "<leader>lr", ":Lspsaga rename<CR>", silent=true},
        { "<leader>lc", ":Lspsaga code_action<CR>" , silent=true}, --like quick fix
        { "<leader>ld", ":Lspsaga goto_definition<CR>" , silent=true},  -- go to def
        { "<leader>lh", ":Lspsaga hover_doc<CR>" , silent=true},   -- show hover help doc
        { "<leader>lR", ":Lspsaga finder<CR>" , silent=true},
        { "<leader>ln", ":Lspsaga diagnostic_jump_next<CR>" , silent=true}, -- jump to warnning
        { "<leader>lp", ":Lspsaga diagnostic_jump_prev<CR>" , silent=true},
    }

}
