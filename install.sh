#!/usr/bin/env bash

set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "===================================="
echo " João Arch Workstation Installer"
echo "===================================="

# -----------------------------------
# Arch check
# -----------------------------------

if [[ ! -f /etc/arch-release ]]; then
    echo "Este instalador foi feito para Arch Linux."
    exit 1
fi

# -----------------------------------
# System update
# -----------------------------------

echo "[1/8] Atualizando sistema..."

sudo pacman -Syu --noconfirm

# -----------------------------------
# Base dependencies
# -----------------------------------

echo "[2/8] Instalando dependências base..."

sudo pacman -S --needed --noconfirm \
    base-devel \
    git \
    rsync \
    rustup

# -----------------------------------
# Official packages
# -----------------------------------

echo "[3/8] Instalando pacotes oficiais..."

sudo pacman -S --needed --noconfirm - < "$REPO/packages/pacman.txt"

# -----------------------------------
# Paru
# -----------------------------------

if ! command -v paru >/dev/null 2>&1; then
    echo "[4/8] Instalando paru..."

    rustup default stable

    TMP="$(mktemp -d)"

    git clone https://aur.archlinux.org/paru.git "$TMP/paru"

    (
        cd "$TMP/paru"
        makepkg -si --noconfirm
    )

    rm -rf "$TMP"
else
    echo "[4/8] paru já instalado."
fi

# -----------------------------------
# AUR packages
# -----------------------------------

echo "[5/8] Instalando pacotes AUR..."

paru -S --needed --noconfirm - < "$REPO/packages/aur.txt"

# -----------------------------------
# Dotfiles
# -----------------------------------

echo "[6/8] Instalando dotfiles..."

rsync -a "$REPO/dotfiles/" "$HOME/"

# -----------------------------------
# Wallpapers
# -----------------------------------

echo "[7/8] Instalando wallpapers..."

mkdir -p "$HOME/Pictures"

rsync -a "$REPO/assets/Wallpapers/" "$HOME/Pictures/Wallpapers/"

# -----------------------------------
# VS Code extensions
# -----------------------------------

echo "[8/8] Instalando extensões do VS Code..."

if command -v code >/dev/null 2>&1; then
    while read -r extension; do
        code --install-extension "$extension" || true
    done < "$REPO/packages/vscode-extensions.txt"
fi

# -----------------------------------
# Zsh
# -----------------------------------

if command -v zsh >/dev/null 2>&1; then
    if [[ "$SHELL" != "/usr/bin/zsh" ]]; then
        echo "Configurando Zsh como shell padrão..."
        chsh -s /usr/bin/zsh "$USER"
    fi
fi

# -----------------------------------
# File manager
# -----------------------------------

if command -v thunar >/dev/null 2>&1; then
    xdg-mime default thunar.desktop inode/directory
fi

echo
echo "===================================="
echo " Instalação concluída."
echo " Faça logout/login ou reinicie."
echo "===================================="
