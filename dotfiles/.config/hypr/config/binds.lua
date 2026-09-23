local terminal = "kitty"
local browser = "firefox"
local file_manager = "thunar"
local launcher = "fuzzel"

-- Apps
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + E", hl.dsp.exec_cmd(file_manager))
hl.bind("SUPER + B", hl.dsp.exec_cmd(browser))

-- Janela
hl.bind("SUPER + Q", hl.dsp.window.close({}))

hl.bind("SUPER + V", hl.dsp.window.float({
    action = "toggle",
}))

hl.bind("SUPER + F", hl.dsp.window.fullscreen({
    mode = "fullscreen",
    action = "toggle",
}))

hl.bind("SUPER + SHIFT + F", hl.dsp.window.fullscreen({
    mode = "maximized",
    action = "toggle",
}))

-- Mover janelas
hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "d" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "r" }))

-- Workspaces 1-9
for i = 1, 9 do
    hl.bind(
        "SUPER + " .. i,
        hl.dsp.focus({ workspace = i })
    )

    hl.bind(
        "SUPER + SHIFT + " .. i,
        hl.dsp.window.move({
            workspace = i,
            follow = false,
        })
    )
end

-- Workspace 10
hl.bind("SUPER + 0", hl.dsp.focus({ workspace = 10 }))

hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({
    workspace = 10,
    follow = false,
}))

-- Scratchpad
hl.bind(
    "SUPER + S",
    hl.dsp.workspace.toggle_special("scratch")
)

-- Screenshot de região
hl.bind(
    "SUPER + SHIFT + S",
    hl.dsp.exec_cmd([[grim -g "$(slurp)" - | swappy -f -]])
)

-- Volume
hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")
)

hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
)

hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
)

-- Logout limpo
hl.bind(
    "SUPER + SHIFT + M",
    hl.dsp.exec_cmd("hyprshutdown")
)

-- Caelestia launcher
hl.bind(
    "SUPER + D",
    hl.dsp.global("caelestia:launcher")
)

-- Sidebar / control center
hl.bind(
    "SUPER + N",
    hl.dsp.global("caelestia:sidebar")
)

-- Session / power
hl.bind(
    "CTRL + ALT + Delete",
    hl.dsp.global("caelestia:session")
)

-- Lock screen
hl.bind(
    "SUPER + L",
    hl.dsp.global("caelestia:lock")
)

-- Clipboard
hl.bind(
    "SUPER + V",
    hl.dsp.exec_cmd("caelestia clipboard")
)

-- Show all shell panels
hl.bind(
    "SUPER + K",
    hl.dsp.global("caelestia:showall")
)

