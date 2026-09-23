#!/usr/bin/env bash

set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "===================================="
echo " João Arch Workstation Installer"
echo "===================================="

if [[ ! -f /etc/arch-release ]]; then
    echo "Este instalador foi feito para Arch Linux."
    exit 1
fi

if [[ $EUID -eq 0 ]]; then
    echo "Não execute este script como root."
    exit 1
fi

MACHINE="${1:-}"

if [[ -z "$MACHINE" ]]; then
    echo
    echo "Escolha a máquina:"
    echo "1) desktop"
    echo "2) notebook"
    echo
    read -rp "> " choice

    case "$choice" in
        1) MACHINE="desktop" ;;
        2) MACHINE="notebook" ;;
        *)
            echo "Opção inválida."
            exit 1
            ;;
    esac
fi

if [[ "$MACHINE" != "desktop" && "$MACHINE" != "notebook" ]]; then
    echo "Máquina inválida: $MACHINE"
    exit 1
fi

echo
echo "Máquina selecionada: $MACHINE"
echo

echo "[1/10] Atualizando sistema..."

sudo pacman -Syu --noconfirm


echo "[2/10] Instalando dependências base..."

sudo pacman -S --needed --noconfirm \
    base-devel \
    git \
    rsync \
    rustup


echo "[3/10] Detectando CPU..."

CPU_VENDOR="$(
    lscpu |
    awk -F: '/Vendor ID/ {
        gsub(/^[ \t]+/, "", $2)
        print $2
    }'
)"

case "$CPU_VENDOR" in
    GenuineIntel)
        echo "CPU Intel detectada."
        sudo pacman -S --needed --noconfirm intel-ucode
        ;;

    AuthenticAMD)
        echo "CPU AMD detectada."
        sudo pacman -S --needed --noconfirm amd-ucode
        ;;

    *)
        echo "Vendor desconhecido: $CPU_VENDOR"
        ;;
esac


echo "[4/10] Instalando pacotes oficiais..."

mapfile -t PACMAN_PKGS < <(
    grep -Ev '^[[:space:]]*(#|$)' \
        "$REPO/packages/pacman.txt"
)

if (( ${#PACMAN_PKGS[@]} )); then
    sudo pacman -S \
        --needed \
        --noconfirm \
        "${PACMAN_PKGS[@]}"
fi


echo "[5/10] Instalando pacotes específicos..."

MACHINE_PACKAGES="$REPO/packages/machines/$MACHINE.txt"

if [[ -f "$MACHINE_PACKAGES" ]]; then
    mapfile -t MACHINE_PKGS < <(
        grep -Ev '^[[:space:]]*(#|$)' \
            "$MACHINE_PACKAGES"
    )

    if (( ${#MACHINE_PKGS[@]} )); then
        sudo pacman -S \
            --needed \
            --noconfirm \
            "${MACHINE_PKGS[@]}"
    fi
fi


echo "[6/10] Preparando paru..."

if ! command -v paru >/dev/null 2>&1; then
    rustup default stable

    TMP="$(mktemp -d)"

    cleanup() {
        rm -rf "$TMP"
    }

    trap cleanup EXIT

    git clone \
        https://aur.archlinux.org/paru.git \
        "$TMP/paru"

    (
        cd "$TMP/paru"
        makepkg -si --noconfirm
    )

    cleanup
    trap - EXIT
else
    echo "paru já instalado."
fi


echo "[7/10] Instalando pacotes AUR..."

mapfile -t AUR_PKGS < <(
    grep -Ev '^[[:space:]]*(#|$)' \
        "$REPO/packages/aur.txt"
)

if (( ${#AUR_PKGS[@]} )); then
    paru -S \
        --needed \
        --noconfirm \
        "${AUR_PKGS[@]}"
fi


echo "[8/10] Instalando dotfiles..."

rsync -a \
    "$REPO/dotfiles/" \
    "$HOME/"


echo "Aplicando overlay de $MACHINE..."

MACHINE_DIR="$REPO/machines/$MACHINE"

if [[ -d "$MACHINE_DIR/hypr" ]]; then
    mkdir -p "$HOME/.config/hypr"

    rsync -a \
        "$MACHINE_DIR/hypr/" \
        "$HOME/.config/hypr/"
fi

if [[ -d "$MACHINE_DIR/caelestia" ]]; then
    mkdir -p "$HOME/.config/caelestia"

    rsync -a \
        "$MACHINE_DIR/caelestia/" \
        "$HOME/.config/caelestia/"
fi


echo "[9/10] Instalando wallpapers..."

if [[ -d "$REPO/assets/Wallpapers" ]]; then
    mkdir -p "$HOME/Pictures/Wallpapers"

    rsync -a \
        "$REPO/assets/Wallpapers/" \
        "$HOME/Pictures/Wallpapers/"
fi


echo "[10/10] Instalando extensões VS Code..."

if command -v code >/dev/null 2>&1; then
    while IFS= read -r extension; do
        [[ -z "$extension" ]] && continue
        [[ "$extension" =~ ^# ]] && continue

        code --install-extension "$extension" || true
    done < "$REPO/packages/vscode-extensions.txt"
fi


if command -v zsh >/dev/null 2>&1; then
    CURRENT_SHELL="$(
        getent passwd "$USER" |
        cut -d: -f7
    )"

    if [[ "$CURRENT_SHELL" != "/usr/bin/zsh" ]]; then
        echo "Configurando Zsh como shell padrão..."
        chsh -s /usr/bin/zsh "$USER"
    fi
fi


if command -v thunar >/dev/null 2>&1; then
    xdg-mime default \
        thunar.desktop \
        inode/directory
fi


echo
echo "===================================="
echo " Instalação concluída."
echo " Máquina: $MACHINE"
echo
echo " Faça logout/login ou reinicie."
echo "===================================="
