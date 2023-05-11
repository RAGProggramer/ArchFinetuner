#! /usr/bin/bash
# shellcheck source=/dev/null
source "RAGFunções.sh";

Menu() {
opcaow="";

while [[ "$opcaow" != "q"  ]]
do
    echo "Selecione uma opção:";
    echo " 1  - intalar yay!";
    echo " 2  - instalar paru!";
    echo " 3  - adicionar Repositorio chaotic e multilib!";
    echo " 4  - instalar kernel xanmod  ";
    echo " 5  - instalar kde plasma e todas suas dependencias";
    echo " 6  - Instalar drivers Graficos ";
    echo " 7  - Criar chave GPG  ";
    echo " 8  - Instalar Navegador ";
    echo " 9  - Oh My zsh e Plugins ";
    echo " 10 - Programas Essenciais ";
    echo " 11 - Instalar thema dedsec ";
    echo " 12 - Instalar Wallpaper Engine ";
    echo " q - Sair  ";

        read -r opcao;

    case $opcao in
    1)
    InstalarYAY; 
    ;;
    2)
    InstalarParu;
    ;;
    3)
    ADDrepoChaotic;
    ;;
    4)
    Intalarxanmod;
    ;;
    5)
    instlarapps;
    ;;
    6)
    driversGraficos;
    ;;
    7)
    criarchavegpg;
    ;;
    8)
    installnavegador;
    ;;
    9)
    zsheplugins;
    ;;
    10)
    progesential;
    ;;
    11)
    grubtheme;
    ;;
    12)
    wallpaperengine;
    ;;
    q) 
    exit;
    ;;    
    *)
        echo "Opção inválida";
        ;;
    esac
done
}