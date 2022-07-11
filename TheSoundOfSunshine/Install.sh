#!/bin/bash
#Kernel Headers
sudo apt-get update
sudo apt upgrade --fix-missing
sudo apt-get install git
sudo apt autoremove
sudo apt-get install rpi-update
sudo rpi-update
sudo git clone --depth=1 https://github.com/raspberrypi/linux
sudo apt-get install raspberrypi-kernel-headers
sudo apt-get update
sudo apt full-upgrade --fix-missing

#Apache
sudo apt install apache2
sudo systemctl restart apache2

#Descarregar i moure projecte (777 perque amb 755 no ens deixava als dos)
git clone https://github.com/ericplanes/TheSoundOfSunshine.git $HOME/Downloads/TheSoundOfSunshine
sudo cp -r $HOME/Downloads/TheSoundOfSunshine /usr/lib/cgi-bin
sudo chmod -R 777 /usr/lib/cgi-bin

#Installs iptable per la ip del server
sudo apt-get install iptables

#Installs mpg123 per la música
sudo apt-get install mpg123

#Creem el fitxer on printarem tots els logs del sistema
touch $HOME/Downloads/system_logs.txt
sudo chmod 777 $HOME/Downloads/system_logs.txt

#Creem els fitxers que utilitzarem per les cançons i ho inicialitzem tot
touch $HOME/Downloads/cur_song.txt
sudo chmod 777 $HOME/Downloads/cur_song.txt
echo "0" > $HOME/Downloads/cur_song.txt

touch $HOME/Downloads/list_songs.txt
sudo chmod 777 $HOME/Downloads/list_songs.txt
echo "0 song1.mp3" > $HOME/Downloads/list_songs.txt
echo "1 song1.mp3" > $HOME/Downloads/list_songs.txt
echo "2 song2.mp3" >> $HOME/Downloads/list_songs.txt
echo "3 song3.mp3" >> $HOME/Downloads/list_songs.txt
echo "4 song4.mp3" >> $HOME/Downloads/list_songs.txt
echo "5 song4.mp3" >> $HOME/Downloads/list_songs.txt
echo "6 song4.mp3" >> $HOME/Downloads/list_songs.txt
echo "7 song4.mp3" >> $HOME/Downloads/list_songs.txt

#Reiniciem el servidor per tal que tot funcioni segons la configuració actual
sudo systemctl restart apache2

#Fem el make del hardware per tal que funcioni tot
cd /usr/lib/cgi-bin/TheSoundOfSunshine/Hardware
make 
sudo make install


