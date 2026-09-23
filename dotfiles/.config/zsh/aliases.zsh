# ==============================
# Navigation
# ==============================

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias cls='clear'

alias proj='cd ~/Projects'
alias dl='cd ~/Downloads'

# zoxide
alias cd='z'

# ==============================
# Files
# ==============================

alias ls='eza --icons=auto --group-directories-first'
alias ll='eza -lah --icons=auto --group-directories-first'
alias la='eza -a --icons=auto --group-directories-first'
alias lt='eza --tree --level=2 --icons=auto'

alias cat='bat --paging=never'

# ==============================
# Arch / packages
# ==============================

alias update='paru -Syu'
alias pacs='pacman -Ss'
alias pacq='pacman -Qs'
alias paci='sudo pacman -S'
alias pacrm='sudo pacman -Rns'

alias aur='paru -Ss'

# ==============================
# Git
# ==============================

alias gs='git status'
alias ga='git add'
alias gaa='git add --all'

alias gc='git commit'
alias gcm='git commit -m'

alias gp='git push'
alias gl='git pull'

alias gco='git checkout'
alias gsw='git switch'

alias gb='git branch'
alias gd='git diff'

alias glog='git log --oneline --graph --decorate --all'

# ==============================
# Docker
# ==============================

alias d='docker'
alias dps='docker ps'
alias dpa='docker ps -a'
alias di='docker images'

alias dc='docker compose'
alias dcup='docker compose up -d'
alias dcdown='docker compose down'
alias dclogs='docker compose logs -f'

# ==============================
# systemd
# ==============================

alias sc='systemctl'
alias scu='systemctl --user'

alias jc='journalctl'
alias jcu='journalctl --user'

# ==============================
# Network
# ==============================

alias ports='ss -tulpn'
alias iplocal='ip -brief address'

# ==============================
# Hyprland
# ==============================

alias hyprreload='hyprctl reload'
alias hyprclients='hyprctl clients'

# ==============================
# Useful functions
# ==============================

mkcd() {
    mkdir -p "$1" && cd "$1"
}

extract() {
    if [[ -f "$1" ]]; then
        case "$1" in
            *.tar.bz2) tar xjf "$1" ;;
            *.tar.gz)  tar xzf "$1" ;;
            *.tar.xz)  tar xJf "$1" ;;
            *.bz2)     bunzip2 "$1" ;;
            *.gz)      gunzip "$1" ;;
            *.tar)     tar xf "$1" ;;
            *.tbz2)    tar xjf "$1" ;;
            *.tgz)     tar xzf "$1" ;;
            *.zip)     unzip "$1" ;;
            *.7z)      7z x "$1" ;;
            *) echo "Formato não reconhecido: $1" ;;
        esac
    else
        echo "Arquivo não encontrado: $1"
    fi
}
