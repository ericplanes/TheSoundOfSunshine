#!/bin/bash
sudo chmod 777 /home/pi/Downloads/pipe
if [ $# -eq 0 ];
then
    while true
    do
        songs=`cat /home/pi/Downloads/list_songs.txt`
        while IFS="" read -r -a line;
        do
            pivot=($line)
            echo "Load ${pivot[0]} /home/pi/Downloads/playlist3.m3u" > /home/pi/Downloads/pipe
            echo "${pivot[0]}" > /home/pi/Downloads/cur_song.txt
            sleep 60
        done <<< "$songs"
    done
else
    if [ $# -eq 1 ];
    then
        flag=0
        songs=`cat /home/pi/Downloads/list_songs.txt`
        current=`cat /home/pi/Downloads/cur_song.txt`
        while IFS="" read -r -a line;
        do
            pivot=($line)

            if [ "$flag" -eq 1 ];
            then
                echo "Load ${pivot[0]} /home/pi/Downloads/playlist3.m3u" > /home/pi/Downloads/pipe
                echo "${pivot[0]}" > /home/pi/Downloads/cur_song.txt
                sleep 60
            else
                if [ "$current" == "${pivot[0]}" ];
                then
                    flag=1
                fi
            fi
        done <<< "$songs"

        songs=`cat /home/pi/Downloads/list_songs.txt`
        while true
        do
            songs=`cat /home/pi/Downloads/list_songs.txt`
            while IFS="" read -r -a line;
            do
                pivot=($line)
                echo "Load ${pivot[0]} /home/pi/Downloads/playlist3.m3u" > /home/pi/Downloads/pipe
                echo "${pivot[0]}" > /home/pi/Downloads/cur_song.txt
                sleep 60
            done <<< "$songs"
        done
    else
        flag=0
        pointer=0
        songs=`cat /home/pi/Downloads/list_songs.txt`
        current=`cat /home/pi/Downloads/cur_song.txt`
        while IFS="" read -r -a line;
        do
            pivot=($line)

            if [ "$flag" -neq 1 ];
            then
                if [ "$current" == "${pivot[0]}" ];
                then
                    flag=1
                else
                    pointer=$((pointer+1))
                fi
            fi
        done <<< "$songs"

        cont=1
        songs=`cat /home/pi/Downloads/list_songs.txt`
        while IFS="" read -r -a line;
        do
            pivot=($line)

            if [ $cont -ge $pointer ];
            then
                echo "Load ${pivot[0]} /home/pi/Downloads/playlist3.m3u" > /home/pi/Downloads/pipe
                echo "${pivot[0]}" > /home/pi/Downloads/cur_song.txt
                sleep 60
            fi
            cont=$((cont+1))
        done <<< "$songs"

        songs=`cat /home/pi/Downloads/list_songs.txt`
        while true
        do
            songs=`cat /home/pi/Downloads/list_songs.txt`
            while IFS="" read -r -a line;
            do
                pivot=($line)
                echo "Load ${pivot[0]} /home/pi/Downloads/playlist3.m3u" > /home/pi/Downloads/pipe
                echo "${pivot[0]}" > /home/pi/Downloads/cur_song.txt
                sleep 60
            done <<< "$songs"
        done
    fi
fi
