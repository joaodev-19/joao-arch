hl.config({
    input = {
        kb_layout = "us",

        repeat_rate = 40,
        repeat_delay = 250,

        numlock_by_default = true,

        follow_mouse = 1,
        focus_on_close = 2,

        -- Sem aceleração adaptativa.
        -- Mantém o comportamento do mouse previsível.
        accel_profile = "flat",
        sensitivity = 0.0,
    },
})
