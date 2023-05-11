#! /usr/bin/bash
################################################################################
# Nome do programa: RAG INSTALL APP 
# Autor: Gabriel Aguiar Rocha
# Data: 09/05/2023
# Versão: 1.0
#
# Descrição: Esse script serve para o pos instalaçao do Archlinux. serve para poupar
# tempo dos usuarios preparei pacotes
# essenciais separado, onde os usuario pode escolher quais 
# pacotes ele quer instalar ao ives de toda vez que
# formatar seu sistema ter que ficar digitando o nome e tal.  
#
################################################################################
# shellcheck source=/dev/null
source RAGFunções.sh;
source RAGMenu.sh;

intmain(){

    cabecalho;

    verifDirExit;

    Menu;
}

intmain;