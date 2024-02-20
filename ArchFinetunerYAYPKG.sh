#! /usr/bin/env bash

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
    whatsapp-
    piper
    portmaster-stub-bin
    whatsapp-electron-bin
    atlauncher
    arduino
    wine-staging
    winetricks
    wine-mono
    wine-gecko
    wine-staging
    giflib
    lib32-giflib
    libpng
    lib32-libpng
    libldap
    lib32-libldap
    gnutls
    lib32-gnutls
    mpg123
    lib32-mpg123
    openal
    lib32-openal
    v4l-utils
    lib32-v4l-utils
    libpulse
    lib32-libpulse
    libgpg-error
    lib32-libgpg-error
    alsa-plugins
    lib32-alsa-plugins
    alsa-lib
    lib32-alsa-lib
    libjpeg-turbo
    lib32-libjpeg-turbo
    sqlite
    lib32-sqlite
    libxcomposite
    lib32-libxcomposite
    libxinerama
    lib32-libgcrypt
    libgcrypt
    lib32-libxinerama
    ncurses
    lib32-ncurses
    opencl-icd-loader
    lib32-opencl-icd-loader
    libxslt l
    ib32-libxslt
    libva
    lib32-libva
    gtk3
    lib32-gtk3
    gst-plugins-base-libs
    lib32-gst-plugins-base-libs
    vulkan-icd-loader
    lib32-vulkan-icd-loader

)

# Função para verificar se um pacote está instalado usando o yay
is_package_installed() {
    yay -Q "$1"
}

# Função para instalar um pacote usando o yay
install_package() {
    echo -e "[INFO] - Instalando o pacote $1..."
    yay -S --noconfirm "$1"
}

# função para instalar os aplicativos com efeito de carregamento
install_or_skip_package() {
    local pacote=$1
    if ! is_package_installed "$pacote"; then
        show_loading "Instalando o pacote $pacote"
        install_package "$pacote"
    else
        echo -e "[INFO] - O pacote $pacote já está instalado."
    fi
}
