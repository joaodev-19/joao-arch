hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start hyprpolkitagent.service")
    hl.exec_cmd("caelestia shell -d")
end)
