-- AOC 24G2 - secundário, esquerda
hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@144",
    position = "0x0",
    scale = 1,
})

-- ASUS VG27AQ5A - principal, direita
hl.monitor({
    output = "DP-1",
    mode = "2560x1440@200",
    position = "1920x0",
    scale = 1,
})
