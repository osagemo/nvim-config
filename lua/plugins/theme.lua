return {
    { "folke/tokyonight.nvim",
        config = function()
        end,
    },
    {
        "sphamba/smear-cursor.nvim",
        opts = {
            enabled = true,

            -- Fire Config
            -- cursor_color = "#ff8800",
            -- stiffness = 0.3,
            -- trailing_stiffness = 0.1,
            -- trailing_exponent = 3,
            -- gamma = 1,
            -- volume_reduction_exponent = -0.1,

            -- Faster config               -- Default  Range
            stiffness = 0.8, -- 0.6      [0, 1]
            trailing_stiffness = 0.5, -- 0.3      [0, 1]
            distance_stop_animating = 0.5, -- 0.1      > 0
            hide_target_hack = false, -- true     boolean
        },
    }
}
