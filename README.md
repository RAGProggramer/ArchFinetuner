Script de Pós-Instalação do Arch Linux - RAGdev
Logo RAGdev

Descrição
O Script de Pós-Instalação do Arch Linux - RAGdev é uma ferramenta automatizada desenvolvida para facilitar o processo de configuração e instalação de pacotes após a instalação do sistema operacional Arch Linux. Com esse script, você pode rapidamente configurar seu ambiente de desenvolvimento ou uso pessoal, economizando tempo e esforço.

Características
Atualiza e instala pacotes Pacman e AUR.
Instala o gerenciador de pacotes Paru.
Instala o gerenciador de pacotes YAY.
Adiciona o repositório Chaotic-aur e configura o pacman.conf.
Cria um diretório de log/downloads (configurável).
Instala drivers gráficos para placas AMD, Intel e NVIDIA.
Cria uma chave GPG para o usuário.
Instala o ZSH e os plugins ZSH-Autosuggestions e ZSH-Syntax-Highlighting.
Instala e configura o tema Dedsec para o GRUB.
Ativa alguns serviços essenciais (NetworkManager, SDDM, Bluetooth).
Instala navegadores populares (Microsoft Edge, Google Chrome, Mozilla Firefox).
Permite escolher uma interface de desktop (KDE, GNOME, XFCE, Cinnamon).
Instala kernels adicionais para o sistema.
Requisitos
Sistema operacional: Arch Linux
Acesso à internet (para atualizar e instalar pacotes)
Permissões de superusuário (para executar comandos com sudo)
Como Usar
Faça o download do script .
Abra o terminal e navegue até o diretório onde o script foi baixado.
Dê permissão de execução ao script: chmod +x ragdev.sh.
Execute o script com permissões de superusuário: sudo ./ragdev.sh.
O menu de opções será exibido. Escolha as configurações desejadas e siga as instruções.
Documentação Adicional
O script possui comentários explicativos em cada função para ajudar a entender o que está sendo feito em cada etapa.
Os pacotes a serem instalados podem ser personalizados editando as variáveis PAC e DRIVERS_GRAFIC_INSTAL no início do script.
É recomendado executar o script após a instalação limpa do Arch Linux.
