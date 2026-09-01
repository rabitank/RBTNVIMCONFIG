return -- 在你的 lazy.nvim 配置中添加
{
    "nickjvandyke/opencode.nvim",
    version = "*", -- 使用最新的稳定版本
    dependencies = {
        -- 强烈推荐，用于增强输入框、选择器等UI体验
        {
            "folke/snacks.nvim",
            opts = {
                input = {},
                picker = { enabled = true },
                terminal = { enabled = true },
            },
        },
    },
    config = function()
        -- 这里配置你的AI提供商和API密钥
        -- 方法1：通过环境变量（推荐）
        -- 在你的shell配置文件中设置 export OPENAI_API_KEY="你的密钥"
        -- vim.g.opencode_opts 会默认读取这个变量
        
        -- 方法2：直接在配置中设置（不安全，仅供测试）
        -- vim.g.opencode_opts = {
        --     provider = "openai",
        --     openai = {
        --         api_key = "你的OpenAI API密钥",
        --         model = "gpt-4o-mini",
        --     },
        -- }

        -- 一些有用的快捷键设置[reference:2]
        vim.keymap.set({ "n", "x" }, "<leader>oa", function()
            require("opencode").ask("@this: ", { submit = true })
        end, { desc = "Ask opencode about current selection/file" })

        vim.keymap.set({ "n", "x" }, "<leader>os", function()
            require("opencode").select()
        end, { desc = "Execute opencode action" })

        vim.keymap.set({ "n", "t" }, "<leader>ot", function()
            require("opencode").toggle()
        end, { desc = "Toggle opencode" })
    end,
}
