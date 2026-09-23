hl.window_rule({
    match = { class = "pavucontrol" },
    float = true,
})

hl.window_rule({
    match = { class = "nm-connection-editor" },
    float = true,
})

hl.window_rule({
    match = { class = "blueman-manager" },
    float = true,
})

hl.window_rule({
    match = { modal = true },
    float = true,
})

hl.window_rule({
    match = { class = "(pinentry-)(.*)" },
    stay_focused = true,
})
