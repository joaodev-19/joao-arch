hl.workspace_rule({
    workspace = 1,
    monitor = "DP-1",
    default = true,
})

for i = 2, 5 do
    hl.workspace_rule({
        workspace = i,
        monitor = "DP-1",
    })
end

hl.workspace_rule({
    workspace = 6,
    monitor = "HDMI-A-1",
    default = true,
})

for i = 7, 10 do
    hl.workspace_rule({
        workspace = i,
        monitor = "HDMI-A-1",
    })
end
