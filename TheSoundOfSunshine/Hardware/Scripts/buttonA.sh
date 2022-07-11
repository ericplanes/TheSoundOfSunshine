#!/bin/bash
echo "A button pressed." >> /home/pi/Desktop/TheSoundOfSunshine/Files/button_log.txt
sudo pkill -9 -f music_playlisy_play.sh
nohup bash /home/pi/Desktop/TheSoundOfSunshine/Software/MusicalFunctions/music_playlisy_play.sh 1 1 > /dev/null 2>&1 & disown