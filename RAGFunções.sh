#! /usr/bin/env bash

#-----------------------------------------| Váriaveis|-------------------------------------------------#
DIR="$HOME/.RAGlog";
export DIR;

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

PACMAN_APP_INSTALL=(
    wget
    nano
    plasma-desktop
    plasma-wayland-session
    plasma-nm 
    plasma-framework
    ffmpegthumbnailer
    ffmpegthumbs 
    plasma-pa
    kate
    gwenview
    kscreen
    powerdevil 
    noto-fonts-emoji 
    sddm 
    tilix 
    dolphin 
    dolphin-plugins 
    spectacle 
    plasma-integration 
    plasma-workspace 
    kded 
    kwayland 
    kwayland-integration 
    systemsettings 
    plasma-workspace-wallpapers  
    ntfs-3g 
    ark 
    ffmpeg 
    gst-plugins-ugly 
    gst-plugins-good 
    gst-plugins-base 
    gst-plugins-bad 
    gst-libav 
    gstreamer 
    btrfs-progs 
    kio-gdrive 
    neofetch 
    htop 
    ark 
    grub-customizer 
    gufw 
    fwupd 
    xorg-server 
    xorg-xinit 
    xorg-apps 
    mesa
    zsh 
    zsh-completions
    base-devel 
    git
    plasma-framework 
    gst-libav 
    base-devel   
    qt5-webchannel 
    vulkan-headers 
    pulseaudio 
    alsa-utils
)

DRIVERS_GRAFIC_INSTAL_AMD=(
lib32-mesa 
vulkan-radeon 
lib32-vulkan-radeon 
vulkan-icd-loader 
lib32-vulkan-icd-loader
)

DRIVERS_GRAFIC_INSTAL_INTEL=(
lib32-mesa 
vulkan-intel 
lib32-vulkan-intel 
vulkan-icd-loader 
lib32-vulkan-icd-loader
)

DRIVERS_GRAFIC_INSTAL_NVIDIA=(
nvidia-dkms 
nvidia-utils 
lib32-nvidia-utils 
nvidia-settings 
vulkan-icd-loader 
lib32-vulkan-icd-loader
)

PAC=(
    base-devel 
    git
)

VERMELHO='\e[1;91m';
VERDE='\e[1;92m';
SEM_COR='\e[0m';

#------------------------------------------| Testes/Atualização |------------------------------------------------#

verifiDepScript(){
    if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
    echo -e "${VERMELHO}[ERROR] - Seu computador não tem conexão com a internet.${SEM_COR}";

    exit 1;
    else
    echo -e "${VERDE}[INFO] - Conexão com a internet funcionando normalmente.${SEM_COR}"; 
    fi

    echo -e "${VERDE}[INFO] - Atualizando pacotes Pacman...${SEM_COR}";
    sudo pacman -Syu --noconfirm;
    
    echo "                                          ";

    echo -e "${VERDE}[INFO] - Atualizando pacotes YAY...${SEM_COR}";
    yay -Syu --noconfirm;
    



    for programa in ${PAC[@]}; do

        if ! pacman -Q | grep -q "$programa"; then  
        echo -e "${VERDE}[INFO] - Instalando $programa... ${SEM_COR}";
            sudo pacman -S "$programa" --noconfirm; 
        else 
             echo -e "${VERDE}[INFO] - O pacote $programa já está instalado.${SEM_COR}";
        fi;
    done;
}
#-------------------------------------------| Funções |-----------------------------------------------#
cabecalho ( ) {
echo "                                                                                                                       ";
echo "    ██████╗  █████╗  ██████╗     ██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗          █████╗ ██████╗ ██████╗     ";
echo "    ██╔══██╗██╔══██╗██╔════╝     ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║         ██╔══██╗██╔══██╗██╔══██╗    ";
echo "    ██████╔╝███████║██║  ███╗    ██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║         ███████║██████╔╝██████╔╝    ";
echo "    ██╔══██╗██╔══██║██║   ██║    ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║         ██╔══██║██╔═══╝ ██╔═══╝     ";
echo "    ██║  ██║██║  ██║╚██████╔╝    ██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗    ██║  ██║██║     ██║         ";
echo "    ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝     ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝    ╚═╝  ╚═╝╚═╝     ╚═╝         ";
echo "                                                                                                                       ";
}

#essa função instala o paru
InstalarParu (){
cd "$DIR";
if [ -f "$DIR/paru" ]; then
    echo -e "${VERDE}[INFO] - O arquivo já existe.${SEM_COR}"
else
    echo -e "${VERDE}[INFO] - Instalando gerenciador de pacotes paru...${SEM_COR}";
    echo "  ";
    git clone https://aur.archlinux.org/paru.git;
    cd paru;
    makepkg -si;
fi


}

#essa função instala o YAY
InstalarYAY (){
cd "$DIR";
if [ -f "$DIR/yay" ]; then
    echo -e "${VERDE}O arquivo já existe.${SEM_COR}"
else
    echo -e "${VERDE}[INFO] - Instalando gerenciador de pacotes yay...${SEM_COR}";
    git clone https://aur.archlinux.org/yay.git;
    cd yay;
    makepkg -si;
fi


}
#essa função  adiciona o repitorio chaotic-aur
ADDrepoChaotic () {
    echo -e "${VERDE}[INFO] - Adicionando Repositorios e Mirros do Chaotic.${SEM_COR}";
    sudo pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com;
    sudo pacman-key --lsign-key FBA220DFC880C036;
    sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst';
    
     cat > /etc/pacman.conf<< "EOF" 

    [chaotic-aur]
    Include = /etc/pacman.d/chaotic-mirrorlist

    [mulitlib]
    include=/etc/pacman.d/mirrorlist

EOF
}
#essa função verifica se o diretorio log/downloads do nosso script funciona
verifDirExit () {

# Verifica se o diretório já existe
if [[ -d "$DIR" ]]; then
    echo -e "${VERDE}[INFO] - O diretório $DIR já existe.${SEM_COR}"
    else
         # Exibe uma mensagem animada de criação do diretório
        echo "Criando diretório $DIR"
        for i in $(seq 10) ; do
        echo -n ".";
        sleep 0.1;
        done;
        echo "";

         # Cria o diretório
         mkdir "$DIR";
    # Exibe uma mensagem de conclusão
    echo -e "${VERDE}[INFO] - Diretório $DIR criado com sucesso!${SEM_COR}";
fi;
}

Intalarxanmod ( ) {
    pacotelinuxxanmod=(
        linux-xanmod 
        linux-xanmod-headers
    )
    for pacote in ${pacotelinuxxanmod[@]}; do
    if ! pacman -Q | grep -q "$pacote"; then  
    echo -e "${VERDE}[INFO] - Instalando Kernel XanMod.${SEM_COR}";
    sudo pacman -S "$pacote" --noconfirm; 
    else 
    echo -e "${VERDE}[INFO] - O pacote $pacote já está instalado.${SEM_COR}";
    fi
done;
    grub-mkconfig -o /boot/grub/grub.cfg;
}

driversGraficos(){
    echo "escolha a opção que coresponde com seu hardware:";
    echo "1 - AMD   ";
    echo "2 - INTEL ";
    echo "3 - NVIDIA";
    echo "q - sair";
 read -rp "opção: " opcao;
case $opcao in

1)
for pacote in ${DRIVERS_GRAFIC_INSTAL_AMD[@]}; do
    if ! pacman -Q | grep -q "$pacote"; then  
     echo -e "${VERDE}[INFO] - Instalando o $pacote...${SEM_COR}";
    sudo pacman -S "$pacote" --noconfirm; 
    else 
    echo -e "${VERDE}[INFO] - O pacote $pacote já está instalado.${SEM_COR}";
    fi
done;
;;
2)
for pacote in ${DRIVERS_GRAFIC_INSTAL_INTEL[@]}; do
    if ! pacman -Q | grep -q "$pacote"; then  
    echo -e "${VERDE}[INFO] - Instalando o $pacote...${SEM_COR}";
    sudo pacman -S "$pacote" --noconfirm  ; 
    else 
    echo -e "${VERDE}[INFO] - O pacote $pacote já está instalado.${SEM_COR}";
    fi
done;
;;
3)
for pacote in ${DRIVERS_GRAFIC_INSTAL_NVIDIA[@]}; do
    if ! pacman -Q | grep -q "$pacote"; then 
     echo -e "${VERDE}[INFO] - Instalando o $pacote...${SEM_COR}"; 
    sudo pacman -S "$pacote" --noconfirm; 
    else 
    echo -e "${VERDE}[INFO] - O pacote $pacote já está instalado.${SEM_COR}";
    fi
done;
;;
esac;

} 
criarchavegpg(){
 echo -e "${VERDE}[INFO] - Criando chave GPG do Usuário...${SEM_COR}";
sudo gpg --full-generate-key;
}
installnavegador(){
pacote='microsoft-edge-dev-bin';
pacote2='microsoft-edge-stable-bin';
pacote3='google-chrome';
pacote4='firefox';
    echo "- - - - - -| Escolha o seu Navegador |- - - - - - - -" 
    echo "1 - microsoft-edge-dev-bin";
    echo "2 - microsoft-edge-stable-bin";
    echo "1 - google-chrome";
    echo "1 - firefox";
    echo "q - para sair";
 read -rp "opção: " opcao;
case $opcao in
1)


 if ! yay -Q | grep -q "$pacote"; then  
 echo -e "${VERDE}[INFO] - Instalando o $pacote...${SEM_COR}"; 
    yay -S "$pacote" --noconfirm; 
    else 
    echo -e "${VERDE}[INFO] - O pacote $pacote já está instalado. ${SEM_COR}";
    fi
;;
2)
if ! yay -Q | grep -q "$pacote2"; then  
    echo -e "${VERDE}[INFO] - Instalando o $pacote2...${SEM_COR}"; 
    yay -S "$pacote2" --noconfirm; 
    else 
    echo -e "${VERDE}[INFO] - O pacote $pacote2 já está instalado.${SEM_COR}";
    fi
;;
3)
if ! yay -Q | grep -q "$pacote3"; then
    echo -e "${VERDE}[INFO] - Instalando o $pacote3...${SEM_COR}"; 
    yay -S "$pacote3" --noconfirm; 
    else 
    echo -e "${VERDE}[INFO] - O pacote $pacote3 já está instalado.${SEM_COR}";
    fi
;;
4)
if ! yay -Q | grep -q "$pacote4"; then  
    echo -e "${VERDE}[INFO] - Instalando o $pacote4...${SEM_COR}"; 
    yay -S "$pacote4" --noconfirm; 
    else 
    echo -e "${VERDE}[INFO] - O pacote $pacote4 já está instalado.${SEM_COR}";
    fi
;;
esac

}

zsheplugins(){
  echo -e "${VERDE}[INFO] - Instalando o OH MY ZSH e os plugins...${SEM_COR}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    if [ -d "$HOME/.oh-my-zsh/plugins/zsh-autosuggestions" ]; then
        echo "The directory already exists."
    else
        git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/plugins/zsh-autosuggestions
    fi

    if [ -d "$HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting" ]; then
        echo "The directory already exists."
    else
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
    fi
}

progesential () {

for pacote in ${YAY_APP_INSTALL[@]}; do
    if ! yay -Q | i aqui com o texto de grep -q "$pacote"; then  
    echo -e "${VERDE}[INFO] - Instalando Programas essenciais para o seu sistema no yay...${SEM_COR}"; 
    yay -S "$pacote" --noconfirm; 
    else 
    echo -e "${VERDE}[INFO] - O pacote $pacote já está instalado.${SEM_COR}";
    fi
done;
}
instlarapps (){
    echo -e "${VERDE}[INFO] - Instalando Progrmas essenciais para o seu sistema no pacman...${SEM_COR}"; 
    for programa in ${PACMAN_APP_INSTALL[@]}; do
        if ! pacman -Q | grep -q "$programa"; then  
            sudo pacman -S "$programa" --noconfirm; 
        else 
             echo -e "${VERDE}[INFO] - O pacote $programa já está instalado.${SEM_COR}";
        fi;
    done;
}

grubtheme() {
echo -e "${VERDE}[INFO] - Instalando theme dedsec para o grub...${SEM_COR}"; 
cd "$DIR";
if [ -f "$DIR/dedsec-grub-theme" ]; then
    echo -e "${VERDE}[INFO] - O arquivo já existe."
else
git clone --depth 1 https://gitlab.com/VandalByte/dedsec-grub-theme.git && cd dedsec-grub-theme;
sudo python3 dedsec-theme.py --install;
fi

}

wallpaperengine(){
        echo -e "${VERDE}[INFO] - Instalando KDE Wallpaper Engine ...${SEM_COR}"; 
        for programa2 in ${pacotes_KDE_WALLPAPER_INSTALL[@]}; do
        if ! pacman -Q | grep -q "$programa2"; then  
            sudo pacman -S "$programa2"; 
        else 
             echo -e "${VERDE}[INFO] - O pacote $programa2 já está instalado.${SEM_COR}";
        fi;
    done;

cd "$DIR";
# Download source
if [ -f "caminho/do/arquivo" ]; then
    echo -e "${VERDE} [INFO] - O arquivo já existe.${SEM_COR}"
else
 git clone https://github.com/catsout/wallpaper-engine-kde-plugin.git
 cd wallpaper-engine-kde-plugin;

# Download submodule (glslang)
 git submodule update --init;
 # Configure
# 'USE_PLASMAPKG=ON': using plasmapkg2 tool to install plugin
mkdir build && cd build;
cmake .. -DUSE_PLASMAPKG=ON
# Build
make -j7;

# Install package (ignore if USE_PLASMAPKG=OFF for system-wide installation)
make install_pkg;
# install lib
sudo make install;
fi
}

ativaservicos(){
    echo -e "${VERDE}[INFO] - ativando alguns serviçoes essenciais e reiniciando o sistema.${SEM_COR}"
    sudo systemctl enable NetworkManager sddm bluetooth.service;
}