#! /usr/bin/bash

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
IntalarParu (){
cd "$DIR" || exit ;
sudo pacman -S base-devel git;
git clone https://aur.archlinux.org/paru.git;
cd paru || exit;
makepkg -si;

}

#essa função instala o YAY
IntalarYAY (){
cd "$DIR" || exit;
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git;
cd yay || exit;
makepkg -si;

}
#essa função  adiciona o repitorio chaotic-aur
ADDrepoChaotic () {
    sudo pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com;
    sudo pacman-key --lsign-key FBA220DFC880C036;
    sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst';

cat > /etc/pacman.conf << "EOF" 
    
    [chaotic-aur]
    Include = /etc/pacman.d/chaotic-mirrorlist

    [mulitlib]
    include=/etc/pacman.d/mirrorlist

EOF

}
#essa função verifica se o diretorio log/downloads do nosso script funciona
verifDirExit () {
    
DIR="$HOME/.RAGlog";
export DIR
# Verifica se o diretório já existe
if [[ -d "$DIR" ]]; then
    echo "O diretório $DIR já existe"
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
    echo "Diretório $DIR criado com sucesso";
fi;

}

Intalarxanmod ( ) {
    sudo pacman -S linux-xanmod linux-xanmod-headers;
    grub-mkconfig -o /boot/grub/grub.cfg;
}

instlarapps (){
    sudo pacman -S plasma-desktop plasma-wayland-session plasma-nm plasma-framework ffmpegthumbnailer ffmpegthumbs plasma-pa kate gwenview kscreen powerdevil noto-fonts-emoji sddm tilix dolphin; 
    sudo pacman -S dolphin-plugins spectacle plasma-integration plasma-workspace kded kwayland kwayland-integration systemsettings plasma-workspace-wallpapers  ntfs-3g ark ffmpeg gst-plugins-ugly; 
    sudo pacman -S gst-plugins-good gst-plugins-base gst-plugins-bad gst-libav gstreamer btrfs-progs kio-gdrive neofetch htop ark grub-customizer;
    sudo pacman -S gufw fwupd xorg-server xorg-xinit xorg-apps mesa;

}
driversGraficos(){
    echo "escolha a opção que coresponde com seu hardware!";
    echo "1 - AMD   ";
    echo "2 - INTEL ";
    echo "3 - NVIDIA";
 opcao="";
case $opcao in

1)
sudo pacman -S --needed lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader;
;;
2)
sudo pacman -S --needed lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader;
;;
3)
sudo pacman -S --needed nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader; 
;;
esac;

} 
criarchavegpg(){
gpg --full-generate-key;
}
installnavegador(){
    echo "- - - - - -| Escolha o seu Navegador |- - - - - - - -" 
    echo "1 - microsoft-edge-dev-bin";
    echo "2 - microsoft-edge-stable-bin";
    echo "1 - google-chrome";
    echo "1 - firefox";
    echo "q - para sair";
opcao=""
case $opcao in
 
1)
yay -S microsoft-edge-dev-bin;
;;
2)
yay -S microsoft-edge-stable-bin;
;;
3)
yay -S google-chrome;
;;
4)
yay -S irefox;
;;
esac

}

zsheplugins(){
    sudo pacman -S zsh zsh-completions;
    cd "$DIR" || exit;
    #bash-syntax
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/plugins/zsh-autosuggestions;
    echo "source ~plugin (zsh-autosuggestions)" >> ~/.zshrc;
    #bash autosggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting;
    #oh my zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";
    sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";
}

progesential(){

yay -S vscode mysql-workbench xampp discord balena-etcher steam heroic-games-launcher lutris anydesk;
yay -S obs-studio kdenlive spotify github-desktop whatsapp-for-linux-git piper-git;

}
grubtheme() {
cd "$DIR" || exit;
git clone --depth 1 https://gitlab.com/VandalByte/dedsec-grub-theme.git && cd dedsec-grub-theme || exit;
sudo python3 dedsec-theme.py --install;
rm -rf dedsec-grub-theme;
}

wallpaperengine(){
sudo pacman -S extra-cmake-modules plasma-framework gst-libav base-devel mpv python-websockets qt5-declarative qt5-websockets qt5-webchannel vulkan-headers cmake;
cd "$DIR" || exit;
# Download source
git clone https://github.com/catsout/wallpaper-engine-kde-plugin.git
cd wallpaper-engine-kde-plugin || exit

# Download submodule (glslang)
git submodule update --init

# Configure
# 'USE_PLASMAPKG=ON': using plasmapkg2 tool to install plugin
mkdir build && cd build || exit
cmake .. -DUSE_PLASMAPKG=ON

# Build
make -j7;

# Install package (ignore if USE_PLASMAPKG=OFF for system-wide installation)
make install_pkg;
# install lib
sudo make install;

}
