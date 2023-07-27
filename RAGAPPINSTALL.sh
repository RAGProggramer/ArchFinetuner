#! /usr/bin/env bash
# shellcheck source=/dev/null
# Importação de arquivos de funções e menu#
source RAGFunções.sh;
source RAGMenu.sh;
################################################################################
# Nome do Scipt: RAG INSTALL APP
# Autor: Gabriel Aguiar Rocha
# Email: ragprogrammer@gmail.com
# Data: 09/05/2023
# Versão: 2.0
# Descrição: Este script serve para a pós-instalação do Arch Linux, 
# poupando tempo dos usuários ao instalar pacotes essenciais de forma automatizada.
################################################################################



main() {
    clear;
    echo "                                          ";
    verifiDepScript;
    echo "                                          ";
    verifDirExit;
    echo "                                          ";
    Menu;
}
main;
