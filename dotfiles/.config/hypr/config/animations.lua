
hl.curve("snappy", {
    type = "bezier",
    points = {
        { 0.2, 0.9 },
        { 0.2, 1.0 },
    },
})

-- Abrir / fechar janelas
hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 2.0,
    bezier = "snappy",
    style = "popin 92%",
})

-- Mover / redimensionar janelas
hl.animation({
    leaf = "windowsMove",
    enabled = true,
    speed = 1.5,
    bezier = "snappy",
})

-- Fades
hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 1.5,
    bezier = "snappy",
})

-- Troca de workspaces
hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 2.0,
    bezier = "snappy",
    style = "slidefade 15%",
})

-- Layers: launcher, notificações, barra etc.
hl.animation({
    leaf = "layers",
    enabled = true,
    speed = 1.8,
    bezier = "snappy",
    style = "fade",
})
