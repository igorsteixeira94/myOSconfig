#!/usr/bin/env bash 

#---------------------Configurações/Variaveis------------------#
PPA_GRAPHICS_DRIVERS="ppa:graphics-drivers/ppa"

URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_VSCODE="https://az764295.vo.msecnd.net/stable/91899dcef7b8110878ea59626991a18c8a6a1b3e/code_1.47.3-1595520028_amd64.deb"

DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"

#Remover snaps
sudo snap remove gnome-system-monitor gnome-calculator gnome-characters gnome-logs -y

## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

## Atualizando o repositório ##
sudo apt update -y

sudo apt-add-repository $PPA_GRAPHICS_DRIVERS -y

# ----------------------------- EXECUÇÃO ----------------------------- #
## Atualizando o repositório depois da adição de novos repositórios ##
sudo apt update -y

mkdir "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GOOGLE_CHROME"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_VSCODE"         -P "$DIRETORIO_DOWNLOADS"

## Instalando pacotes .deb baixados na sessão anterior ##
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb
sudo apt install -f


#Programas para serem instalados via apt-get install
PROGRAMAS_PARA_INSTALAR=(
gnome-system-monitor
gnome-calculator
gnome-characters
gnome-logs
gnome-tweak-tool
ubuntu-restricted-extras
qbittorrent
typora
zsh
curl
git

)

# Instalar programas no apt
for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    sudo apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done

#Programar para instalar via snap
sudo snap install spotify
sudo snap install discord
sudo snap install insomnia
sudo snap install vlc
sudo snap install libreoffice


#------------------DOCKER-----------
sudo apt install docker.io
docker -v
#---rodar docker sem sudo
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
docker run hello-world

#---Docker composer
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

#------ Configurar git
git config --global user.name "Igor Rodrigues"
git config --global user.email "igorsteixeira94@gmail.com"
# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #
## Finalização, atualização e limpeza##
echo "Começar a limpeza"
sudo apt update && sudo apt dist-upgrade -y
sudo apt autoclean
sudo apt autoremove -y
# ---------------------------------------------------------------------- #

