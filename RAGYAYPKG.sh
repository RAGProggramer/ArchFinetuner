#! /usr/bin/env bash
# shellcheck source=/dev/null

# Array com a lista de aplicativos para instalar
YAY_APP_INSTALL=(
    visual-studio-code-bin
    mysql-workbench 
    xampp 
    discord 
    balena-etcher 
    steam 
    heroic-games-launcher 
    lutris 
    anydesk
    obs-studio 
    kdenlive 
    spotify 
    github-desktop 
    whatsapp-for-linux-git 
    piper
    portmaster-stub-bin
)

# Função para verificar se um pacote está instalado usando o yay
is_package_installed() {
    yay -Q "$1" &>/dev/null
}

# Função para instalar um pacote usando o yay
install_package() {
    echo -e "[INFO] - Instalando o pacote $1..."
    yay -S --noconfirm "$1"
}

# função paraq Instalar os aplicativos com efeito de carregamento
install_or_skip_package() {
    local pacote=$1
    if ! is_package_installed "$pacote"; then
        show_loading "Instalando o pacote $pacote"
        install_package "$pacote"
    else
        echo -e "[INFO] - O pacote $pacote já está instalado."
    fi
}
