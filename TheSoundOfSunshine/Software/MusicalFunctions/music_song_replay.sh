#!/bin/bash
echo Content-Type: text/html
echo

echo "SYSLOG: StopReplay | StartReplay option used." >> /home/pi/Downloads/system_logs.txt

if [ -f /home/pi/Downloads/replay_song.txt ];
then
	cat /home/pi/Downloads/replay_song.txt > /home/pi/Downloads/list_songs.txt
	sudo rm -f /home/pi/Downloads/replay_song.txt
else
	sudo touch /home/pi/Downloads/replay_song.txt
	sudo chmod 777 /home/pi/Downloads/replay_song.txt
	cat /home/pi/Downloads/list_songs.txt > /home/pi/Downloads/replay_song.txt

	var=0
	current=`cat /home/pi/Downloads/cur_song.txt`
	songs=`cat /home/pi/Downloads/list_songs.txt`
	> /home/pi/Downloads/list_songs.txt
	while IFS="" read -r -a line;
	do
		pivot=($line)
		if [ "${pivot[0]}" != "current" ];
		then
			echo "${pivot[0]} ${pivot[1]}" > /home/pi/Downloads/list_songs.txt
		fi
	done <<< "$songs"
fi

echo -e "
<!DOCTYPE html><html>
	<head>
		<meta charset="UTF-8">
		<style>
			// Codi per posar el CSS i fer-ho
		</style>
	</head>
	<body>
		<div>
			<div>
				<div>
					<h2>StopReplay | StartReplay</h2>
				</div>
				<div>
					<p>StopReplay | StartReplay option used.</p>
				</div>
				<p></p>
				<div>
					<p>Back to music</p>
					<div>
						<form action="main_music.sh">
								<input type="submit" value="Go Back">
						</form>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>"
