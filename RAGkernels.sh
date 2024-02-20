#! /usr/bin/env bash
# shellcheck source=/dev/null
source "RAGFunções.sh";

declare -A kernels=(
    [1]="linux-xanmod linux-xanmod-headers"
    [2]="linux-lts linux-lts-headers"
    [3]="linux linux-headers"
    [4]="linux-cachyos linux-cachyos-headers"
    # Adicione mais opções de kernels aqui, se desejar
)

# Função para instalar o pacote do kernel selecionado
instalar_kernel() {
    local nome_pacote="${kernels[$1]}"
    if ! pacman -Q | grep -q "$nome_pacote"; then
        # Verificar se o pacote está disponível no pacman
        if pacman -Si "$nome_pacote" &> /dev/null; then
            echo -e "${VERDE}[INFO] - Instalando o kernel selecionado via pacman.${SEM_COR}"
            sudo pacman -S "$nome_pacote" --noconfirm
        elif yay -Qi "$nome_pacote" &> /dev/null; then
            echo -e "${VERDE}[INFO] - Instalando o kernel selecionado via yay.${SEM_COR}"
            yay -S "$nome_pacote" --noconfirm
        else
            echo -e "${VERDE}[INFO] - O pacote $nome_pacote não está disponível no pacman ou yay.${SEM_COR}"
        fi
    else
        echo -e "${VERDE}[INFO] - O pacote $nome_pacote já está instalado.${SEM_COR}"
    fi
}
atualizar_grub() {
   sudo grub-mkconfig -o /boot/grub/grub.cfg
}

IntallKernels() {
    echo "Selecione um kernel para instalar:"
    for key in "${!kernels[@]}"; do
        echo "$key) ${kernels[$key]}"
    done

    read -p "Digite o número do kernel que deseja instalar: " escolha

    # Usar o comando case para lidar com a entrada do usuário
    case "$escolha" in
        [1-9]|[1-9][0-9])
            if [[ -n "${kernels[$escolha]}" ]]; then
                instalar_kernel "$escolha"
            else    
                echo "Opção inválida."
            fi
            ;;
        *)
            echo "Entrada inválida. Digite um número válido."
            ;;
    esac

    # Atualizar o GRUB após a instalação do kernel selecionado
    atualizar_grub
}


