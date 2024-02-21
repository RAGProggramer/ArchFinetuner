#! /usr/bin/env bash
# shellcheck source=/dev/null

#-----------------------------------------| Váriaveis|-------------------------------------------------#
export DIR="$HOME/.cache/RAGlog"

# Set error code variable
export ERROR_CODE=2

declare -A NAVEGADORES=(
    ["edge-dev"]="microsoft-edge-dev-bin"
    ["edge-stable"]="microsoft-edge-stable-bin"
    ["chrome"]="google-chrome"
    ["firefox"]="firefox"
)

declare -A DRIVERS_GRAFIC_INSTAL=(
    ["AMD"]="lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader"
    ["INTEL"]="lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader"
    ["NVIDIA"]="nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader"
)

PAC=(
    base-devel
    git
    zsh
    zsh-completions
)

WALLPAERS_PACOTES_INSTALL=(
    extra-cmake-modules 
    plasma-framework
    gst-libav 
    base-devel
    mpv
    python-websockets 
    qt5-declarative
    qt5-websockets
    qt5-webchannel
    vulkan-headers 
    cmake
)

VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
SEM_COR='\e[0m'
GREEN='\033[0;32m'
RESET='\033[0m'

#------------------------------------------| Testes/Atualização |------------------------------------------------#

atualizarEInstalarPacotes() {
    local CODIGO_ERRO=2
    local pacotes_com_falha=()

    if ! ping -c 1 8.8.8.8 -q &>/dev/null; then
        echo -e "${VERMELHO}[ERRO] - Seu computador não tem conexão com a internet.${SEM_COR}"
        return 1
    else
        echo -e "${VERDE}[INFO] - Conexão com a internet funcionando normalmente.${SEM_COR}"
    fi

    echo -e "${VERDE}[INFO] - Atualizando pacotes Pacman e YAY...${SEM_COR}"
    sudo pacman -Syu --noconfirm || {
        echo -e "${VERMELHO}[ERRO] - Falha ao atualizar os pacotes Pacman.${SEM_COR}"
        return 1
    }
    yay --noconfirm || {
        echo -e "${VERMELHO}[ERRO] - Falha ao atualizar os pacotes YAY.${SEM_COR}"
        return 1
    }

    for programa in "${PAC[@]}"; do
        if ! pacman -Qq "$programa" &>/dev/null; then
            echo -e "${VERDE}[INFO] - Instalando $programa... ${SEM_COR}"
            sudo pacman -S "$programa" --noconfirm || {
                echo -e "${VERMELHO}[ERRO] - Falha ao instalar o pacote $programa.${SEM_COR}"
                pacotes_com_falha+=("$programa")
            }
        else
            echo -e "${VERDE}[INFO] - O pacote $programa já está instalado.${SEM_COR}"
        fi
    done

    if [ ${#pacotes_com_falha[@]} -gt 0 ]; then
        echo -e "${VERMELHO}[ERRO] - Falha ao instalar os seguintes pacotes: ${pacotes_com_falha[*]}.${SEM_COR}"
        return 1
    fi

    echo -e "${VERDE}[INFO] - Todos os pacotes foram instalados ou já estão presentes.${SEM_COR}"
    return 0
}


#-------------------------------------------| Funções |-----------------------------------------------#
cabecalho() {
    echo "                                                                                                         ";
    echo " █████╗ ██████╗  ██████╗██╗  ██╗███████╗██╗███╗   ██╗███████╗████████╗██╗   ██╗███╗   ██╗███████╗██████╗ ";
    echo "██╔══██╗██╔══██╗██╔════╝██║  ██║██╔════╝██║████╗  ██║██╔════╝╚══██╔══╝██║   ██║████╗  ██║██╔════╝██╔══██╗";
    echo "███████║██████╔╝██║     ███████║█████╗  ██║██╔██╗ ██║█████╗     ██║   ██║   ██║██╔██╗ ██║█████╗  ██████╔╝";
    echo "██╔══██║██╔══██╗██║     ██╔══██║██╔══╝  ██║██║╚██╗██║██╔══╝     ██║   ██║   ██║██║╚██╗██║██╔══╝  ██╔══██╗";
    echo "██║  ██║██║  ██║╚██████╗██║  ██║██║     ██║██║ ╚████║███████╗   ██║   ╚██████╔╝██║ ╚████║███████╗██║  ██║";
    echo "╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝";
    echo "                                                                                                         ";
}

# Função para mostrar o efeito de carregamento
show_loading() {
    local message=$1
    local spin_chars="/-\|"

    echo -n "$message "
    for ((i = 0; i < 15; i++)); do
        echo -n "${spin_chars:i%4:1}"
        sleep 0.1
        echo -ne "\b"
    done
    echo " Concluído!"
}

instalar_paru() {
    cd "$DIR"
    if [ -f "$DIR/paru" ]; then
        echo -e "${VERDE}[INFO] - O arquivo paru já existe.${SEM_COR}"
    else
        echo -e "${VERDE}[INFO] - Instalando gerenciador de pacotes paru...${SEM_COR}"
        show_loading "Clonando repositório"
        git clone https://aur.archlinux.org/paru.git
        cd paru
        show_loading "Compilando e instalando"
        makepkg -si
    fi
}

instalar_yay() {
    cd "$DIR"
    if [ -f "$DIR/yay" ]; then
        echo -e "${VERDE}[INFO] - O arquivo yay já existe.${SEM_COR}"
    else
        echo -e "${VERDE}[INFO] - Instalando gerenciador de pacotes yay...${SEM_COR}"
        show_loading "Clonando repositório"
        git clone https://aur.archlinux.org/yay.git
        cd yay
        show_loading "Compilando e instalando"
        makepkg -si
    fi
}

modificarPacmanConf() {
    # Etapa 1: Adicionar a seção [chaotic-aur]
    if ! grep -q '^\[chaotic-aur\]' /etc/pacman.conf; then
        echo -e "\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf
        echo -e "${VERDE}[SUCESSO] - Adicionada a seção [chaotic-aur].${RESET}"
    else
        echo -e "${VERMELHO}[INFO] - A seção [chaotic-aur] já existe.${RESET}"
    fi

    # Etapa 2: Remover os comentários da seção [multilib] com include
    if sudo grep -q '^\s*#\[multilib\]' /etc/pacman.conf; then
        sudo sed -i '/^\s*#\[multilib\]$/,/^\s*# include=\/etc\/pacman\.d\/mirrorlist$/ s/^#//' /etc/pacman.conf
        echo -e "${VERDE}[SUCESSO] - Comentários removidos da seção [multilib].${RESET}"
    else
        echo -e "${VERMELHO}[INFO] - A seção [multilib] já está descomentada.${RESET}"
    fi
}

#essa função  adiciona o repitorio chaotic-aur
ADDrepoChaotic() {
    echo -e "${VERDE}[INFO] - Adicionando Repositorios e Mirros do Chaotic.${SEM_COR}"
    sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
    sudo pacman-key --lsign-key 3056513887B78AEB
    sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
    # Executar a função
    modificarPacmanConf
}
#essa função verifica se o diretorio log/downloads do nosso script funciona ou existe
verifDirExit() {

    # Verifica se o diretório já existe
    if [[ -d "$DIR" ]]; then
        echo -e "${GREEN}[INFO] - O diretório $DIR já existe.${RESET}"
    else
        # Chama a função de animação de carregamento
        show_loading "Criando diretório $DIR"

        # Cria o diretório
        mkdir -p "$DIR"

        # Exibe uma mensagem de conclusão
        echo -e "${GREEN}[INFO] - Diretório $DIR criado com sucesso!${RESET}"
    fi
}

driversGraficos() {
    echo "Escolha a opção que corresponde ao seu hardware:"
    echo "1 - AMD"
    echo "2 - INTEL"
    echo "3 - NVIDIA"
    echo "q - Sair"

    read -rp "Opção: " opcao

    case $opcao in
    1)
        instalar_pacotes ${DRIVERS_GRAFIC_INSTAL["AMD"]}
        ;;
    2)
        instalar_pacotes ${DRIVERS_GRAFIC_INSTAL["INTEL"]}
        ;;
    3)
        instalar_pacotes ${DRIVERS_GRAFIC_INSTAL["NVIDIA"]}
        ;;
    q)
        echo "Saindo..."
        ;;
    *)
        echo "Opção inválida. Tente novamente."
        ;;
    esac
    
}

criarchavegpg() {
    # Diretório para armazenar a chave GPG
    DIR="$HOME/.cache/RAGlog"

    # Verificar se as variáveis estão definidas corretamente
    if [[ -z "$chave_tamanho" ]]; then
        echo "Erro: Variável chave_tamanho não definida." >&2
        exit 1
    fi

    if [[ -z "$chave_comentario" ]]; then
        echo "Erro: Variável chave_comentario não definida." >&2
        exit 1
    fi

    # Gerar a chave GPG
    echo "Gerando chave GPG..."
    gpg --batch --full-generate-key <<EOF
    Key-Type: RSA
    Key-Length: $chave_tamanho
    Subkey-Type: RSA
    Key-Length: $chave_tamanho
    Name-Real: $USER
    Comment: $chave_comentario
    $([ -n "$chave_prazo" ] && echo "Expire-Date: +$chave_prazo")
    %commit
EOF

    # Verificar se a geração da chave foi bem-sucedida
    if [[ $? -ne 0 ]]; then
        echo "Erro: Falha ao gerar a chave GPG." >&2
        exit 1
    fi

    # Exibir mensagem com o ID da chave gerada
    echo -e "\n[INFO] - Chave GPG criada com o ID abaixo:"
    gpg --list-keys --keyid-format LONG "$USER"

}

# Chamar a função para iniciar o processo de instalação do zsh
zsheplugins() {
    sudo pacman -S zsh --noconfirn
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo -e "${VERDE}[INFO] - Instalando o OH MY ZSH...${SEM_COR}"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"
    else
        echo -e "${VERDE}[INFO] - OH MY ZSH já está  zsh
    zsh-completions instalado.${SEM_COR}"
    fi

    # Verifica e instala o plugin zsh-autosuggestions
    if [ ! -d "$HOME/.oh-my-zsh/plugins/zsh-autosuggestions" ]; then
        echo -e "${VERDE}[INFO] - Instalando o plugin zsh-autosuggestions...${SEM_COR}"
        git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/plugins/zsh-autosuggestions
    else
        echo -e "${VERDE}[INFO] - O plugin zsh-autosuggestions já está instalado.${SEM_COR}"
    fi

    # Verifica e instala o plugin zsh-syntax-highlighting
    if [ ! -d "$HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting" ]; then
        echo -e "${VERDE}[INFO] - Instalando o plugin zsh-syntax-highlighting...${SEM_COR}"
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting
    else
        echo -e "${VERDE}[INFO] - O plugin zsh-syntax-highlighting já está instalado.${SEM_COR}"
    fi
}

grubtheme() {
    echo -e "${VERDE}[INFO] - Instalando theme dedsec para o grub...${SEM_COR}"
    cd "$DIR"
    if [ -f "$DIR/dedsec-grub-theme" ]; then
        echo -e "${VERDE}[INFO] - O arquivo já existe."
    else
        git clone --depth 1 https://gitlab.com/VandalByte/dedsec-grub-theme.git && cd dedsec-grub-theme
        sudo python3 dedsec-theme.py --install
    fi
}

ativaservicos() {
    echo -e "${VERDE}[INFO] - ativando alguns serviçoes essenciais e reiniciando o sistema.${SEM_COR}"
    sudo systemctl enable NetworkManager sddm bluetooth.service
}

instalarNavegador() {
    echo "---------------------------------------------"
    echo "|        Escolha o seu Navegador           |"
    echo "---------------------------------------------"
    echo "Opções:"
    i=1
    for nome_navegador in "${!NAVEGADORES[@]}"; do
        echo "$i - $nome_navegador"
        ((i++))
    done

    echo "q - Sair"

    read -rp "Opção: " opcao

    case $opcao in
    [1-4])
        nomes_navegadores=("${!NAVEGADORES[@]}")
        navegador_selecionado=${nomes_navegadores[opcao - 1]}
        pacote=${NAVEGADORES[$navegador_selecionado]}

        if ! yay -Q | grep -q "$pacote"; then
            echo "[INFO] - Instalando o $navegador_selecionado..."
            yay -S "$pacote" --noconfirm
            echo "[INFO] - $navegador_selecionado instalado com sucesso!"
        else
            echo "[INFO] - O pacote $navegador_selecionado já está instalado."
        fi
        ;;
    "q")
        echo "Saindo do menu."
        ;;
    *)
        echo "Opção inválida. Saindo do menu."
        ;;
    esac
}
Install_wallpaperEngine() {
    # Download source
    echo "Clonando o repositório..."
    git clone https://github.com/catsout/wallpaper-engine-kde-plugin.git || { echo "Erro ao clonar o repositório."; return 1; }

    # Entrar no diretório clonado
    cd wallpaper-engine-kde-plugin || { echo "Erro ao acessar o diretório clonado."; return 1; }

    # Baixar submódulo (glslang)
    echo "Baixando submódulo..."
    git submodule update --init || { echo "Erro ao baixar o submódulo."; return 1; }

    # Configurar
    echo "Configurando..."
    mkdir -p build && cd build || { echo "Erro ao criar o diretório de compilação."; return 1; }
    cmake .. -DUSE_PLASMAPKG=ON || { echo "Erro ao configurar."; return 1; }

    # Compilar
    echo "Compilando..."
    make -j"$nproc" || { echo "Erro ao compilar."; return 1; }

    # Instalar pacote
    echo "Instalando pacote..."
    make install_pkg || { echo "Erro ao instalar o pacote."; return 1; }
    # Instalar lib
    echo "Instalando biblioteca..."
    sudo make install || { echo "Erro ao instalar a biblioteca."; return 1; }

    # Clonar e inicializar submódulo
    cd ../src/backend_scene/standalone_view || { echo "Erro ao acessar o diretório."; return 1; }
    mkdir -p build && cd build || { echo "Erro ao criar o diretório de compilação."; return 1; }
    echo "Configurando..."
    cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_QML=ON || { echo "Erro ao configurar."; return 1; }
    echo "Compilando..."
    make -j"$nproc" || { echo "Erro ao compilar."; return 1; }

    # Exibir ajuda
    echo "Executando..."
    ./sceneviewer --help || { echo "Erro ao executar."; return 1; }

    return 0
}

# Exemplo de uso


installWallpaperEngine(){
    show_loading "Instalando Wallpaper Engine"

    for programa in "${WALLPAERS_PACOTES_INSTALL[@]}"; do
        if ! pacman -Qq "$programa" &>/dev/null; then
            echo -e "${VERDE}[INFO] - Instalando $programa... ${SEM_COR}"
            sudo pacman -S "$programa" --noconfirm || {
                echo -e "${VERMELHO}[ERRO] - Falha ao instalar o pacote $programa.${SEM_COR}"
                pacotes_com_falha+=("$programa")
            }
        else
            echo -e "${VERDE}[INFO] - O pacote $programa já está instalado.${SEM_COR}"
        fi
    done

    if [ ${#pacotes_com_falha[@]} -gt 0 ]; then
        echo -e "${VERMELHO}[ERRO] - Falha ao instalar os seguintes pacotes: ${pacotes_com_falha[*]}.${SEM_COR}"
        return 1
    fi

    echo -e "${VERDE}[INFO] - Todos os pacotes foram instalados ou já estão presentes.${SEM_COR}"
    return 0
    Install_wallpaperEngine
}
