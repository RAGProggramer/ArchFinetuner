#!/usr/bin/env bash

# shellcheck source=/dev/null
source "RAGFunções.sh";
source "RAGkernels.sh";
source "RAGYAYPKG.sh";
source "RAGInterfaceINS.sh";

Menu() {
  while true; do
    clear
    cabecalho
    echo "1) Instalar Paru"
    echo "2) Instalar YAY"
    echo "3) Adicionar Repositório Chaotic AUR"
    echo "4) Instalar Drivers Gráficos"
    echo "5) Criar Chave GPG"
    echo "6) Instalar ZSH e Plugins"
    echo "7) Instalar Grub Theme Dedsec"
    echo "8) Ativar Serviços"
    echo "9) Instalar Navegador"
    echo "10) Escolher Interface"
    echo "11) Instalar Kernels"
    echo "q) Sair"

    read -rp "Escolha uma opção: " opcao

    case $opcao in
      1)
        instalar_paru
        ;;
      2)
        instalar_yay
        ;;
      3)
        ADDrepoChaotic
        ;;
      4)
        driversGraficos
        ;;
      5)
        criarchavegpg
        ;;
      6)
        zsheplugins
        ;;
      7)
        grubtheme
        ;;
      8)
        ativaservicos
        ;;
      9)
       instalarNavegador
        ;;
      10)
        escolher_interface
        ;;
      11)
        IntallKernels
        ;;
        12)
        install_or_skip_package
        ;;
      q)
        echo "Saindo..."
        exit 0
        ;;
      *)
        echo "Opção inválida. Tente novamente."
        sleep 1
        ;;
    esac

    read -rp "Pressione ENTER para voltar ao menu."
  done
}