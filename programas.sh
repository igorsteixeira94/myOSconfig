#!/usr/bin/env bash 

#---------------------Configurações/Variaveis------------------#
PPA_GRAPHICS_DRIVERS="ppa:graphics-drivers/ppa"

URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"


## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

## Atualizando o repositório ##
sudo apt update -y

sudo apt-add-repository $PPA_GRAPHICS_DRIVERS -y

# ----------------------------- EXECUÇÃO ----------------------------- #
##----------------------------- Atualizando o repositório depois da adição de novos repositórios ##
sudo apt update -y

mkdir "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GOOGLE_CHROME"       -P "$DIRETORIO_DOWNLOADS"

##-----------------Instalando pacotes .deb baixados na sessão anterior ##
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb
sudo apt install -f

#instalando o JAVA para Android Studio
sudo add-apt-repository ppa:openjdk-r/ppa -y
sudo apt-get update -y
sudo apt-get install openjdk-11-jdk -y


#-----------------Programas para serem instalados via apt-get install
PROGRAMAS_PARA_INSTALAR=(
git
snapd
)

# -----------------Instalar programas no apt
for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    sudo apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done

#-------------Nvidia
sudo ubuntu-drivers autoinstall -y

#-----------------Programas para serem instalados via snap
PROGRAMAS_PARA_INSTALAR=(
spotify
discord
insomnia
vlc
code --classic
node --classic
android-studio --classic
docker
)

# -----------------Instalar programas via snap
for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    sudo snap install "$nome_do_programa"
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done

# instalando yarn
sudo npm install --global yarn -y




#---rodar docker sem sudo
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

#---Docker composer
sudo apt install docker-compose -y

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

