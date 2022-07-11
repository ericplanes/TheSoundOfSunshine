#!/bin/bash
echo "C button pressed." >> /home/pi/Desktop/TheSoundOfSunshine/Files/button_log.txt
sudo pkill -9 -f mpg123
sudo pkill -9 -f music_playlisy_play.sh
nohup bash /home/pi/Desktop/TheSoundOfSunshine/Software/MusicalFunctions/music_playlisy_play.sh > /dev/null 2>&1 & disown
sudo chmod 777 /home/pi/Downloads/pipe
nohup bash /home/pi/Desktop/TheSoundOfSunshine/Software/MusicalFunctions/music_playlisy_play.sh > /dev/null 2>&1 & disown