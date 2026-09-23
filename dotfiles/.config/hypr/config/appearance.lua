hl.config({
    general = {
        border_size = 2,

        gaps_in = 6,
        gaps_out = 10,

        resize_on_border = true,

        layout = "dwindle",

        col = {
            active_border = "rgba(89b4faff)",
            inactive_border = "rgba(45475aaa)",
        },
    },

    decoration = {
        rounding = 10,
        rounding_power = 2.5,

        active_opacity = 1.0,
        inactive_opacity = 0.97,
        fullscreen_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 12,
            render_power = 3,
            color = "rgba(00000055)",
        },

        blur = {
            enabled = true,
            size = 5,
            passes = 2,

            new_optimizations = true,
            popups = true,
            xray = true,
        },
    },
})
