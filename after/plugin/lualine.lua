require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()

require("lualine").setup {
    sections = {
        lualine_c = {
            {
                "filename", path = 4
            }
        },
    },
}
