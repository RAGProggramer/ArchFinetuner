#!/usr/bin/env bash
# shellcheck source=/dev/null
source "RAGFunções.sh"

AZUL="\033[34m"
SEM_COR="\033[0m"

Menu() {
    clear
    cabecalho
    opcaow=""

    while [[ "$opcaow" != "q" ]]
    do
        echo -e "Selecione uma opção:"
        echo -e "${AZUL} 1  - Instalar yay!${SEM_COR}"
        echo -e "${AZUL} 2  - Instalar paru!${SEM_COR}"
        echo -e "${AZUL} 3  - Adicionar Repositório chaotic e multilib!${SEM_COR}"
        echo -e "${AZUL} 4  - Instalar kernel xanmod${SEM_COR}"
        echo -e "${AZUL} 5  - Instalar KDE Plasma e todas as suas dependências${SEM_COR}"
        echo -e "${AZUL} 6  - Instalar drivers gráficos${SEM_COR}"
        echo -e "${AZUL} 7  - Criar chave GPG${SEM_COR}"
        echo -e "${AZUL} 8  - Instalar Navegador${SEM_COR}"
        echo -e "${AZUL} 9  - Oh My Zsh e Plugins${SEM_COR}"
        echo -e "${AZUL} 10 - Programas Essenciais${SEM_COR}"
        echo -e "${AZUL} 11 - Instalar tema dedsec${SEM_COR}"
        echo -e "${AZUL} 12 - Instalar Wallpaper Engine${SEM_COR}"
        echo -e "${AZUL} 13 - Ativar serviços essenciais${SEM_COR}"
        echo -e "${VERMELHO} q - Sair${SEM_COR}"

        read -rp "Opção: " opcao

        case $opcao in
            1) InstalarYAY ;;
            2) InstalarParu ;;
            3) ADDrepoChaotic ;;
            4) Intalarxanmod ;;
            5) instlarapps ;;
            6) driversGraficos ;;
            7) criarchavegpg ;;
            8) installnavegador ;;
            9) zsheplugins ;;
            10) progesential ;;
            11) grubtheme ;;
            12) wallpaperengine ;;
            13) ativaservicos ;;
            q) exit ;;
            *) echo -e "${VERMELHO}Opção inválida${SEM_COR}" ;;
        esac
    done
}

Menu
