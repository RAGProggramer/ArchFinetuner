#!/usr/bin/env bash

# shellcheck source=/dev/null
source "ArchFinetunerFunções.sh";
source "ArchFinetunerKernells.sh";
source "ArchFinetunerYAYPKG.sh";
source "ArchFinetunerInterfaces.sh";

funcoes=(
    instalar_paru
    instalar_yay
    ADDrepoChaotic
    driversGraficos
    criarchavegpg
    zsheplugins
    grubtheme
    ativaservicos
    instalarNavegador
    escolher_interface
    IntallKernels
    install_or_skip_package
    installWallpaperEngine
)


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
    echo "12) Instalar programas padrao"
    echo "13) Instalar Walpaper Engine do KDE";
    echo "14) Rodar Tudo";

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
        13)
        installWallpaperEngine
        ;;
        14)
       # Loop sobre cada função e solicitação de confirmação para executá-la
    for funcao in "${funcoes[@]}"; do
    read -p "Tem certeza que deseja executar $funcao? (Digite 's' para sim, 'n' para não): " resposta
    if [ "$resposta" = "s" ]; then
        "$funcao"
    else
        echo "Função $funcao ignorada."
    fi
done
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
