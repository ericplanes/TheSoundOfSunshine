#!/bin/bash
echo "B button pressed." >> /home/pi/Desktop/TheSoundOfSunshine/Files/button_log.txt
sudo pkill -9 -f mpg123
sudo pkill -9 -f music_playlisy_play.sh