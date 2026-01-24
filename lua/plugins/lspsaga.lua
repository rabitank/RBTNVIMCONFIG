return {
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
        { "<leader>lr", ":Lspsaga rename<CR>" },
        { "<leader>lc", ":Lspsaga code_action<CR>" }, --like quick fix
        { "<leader>ld", ":Lspsaga goto_definition<CR>" },  -- go to def
        { "<leader>lh", ":Lspsaga hover_doc<CR>" },   -- show hover help doc
        { "<leader>lR", ":Lspsaga finder<CR>" },
        { "<leader>ln", ":Lspsaga diagnostic_jump_next<CR>" }, -- jump to warnning
        { "<leader>lp", ":Lspsaga diagnostic_jump_prev<CR>" },
    }

}
