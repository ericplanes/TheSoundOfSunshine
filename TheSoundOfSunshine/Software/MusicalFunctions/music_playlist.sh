#!/bin/bash
echo Content-Type: text/html
echo

list_songs=`echo "$(cat /home/pi/Downloads/playlist3.m3u)"`

echo "SYSLOG: Playlist shown." >> /home/pi/Downloads/system_logs.txt

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
					<h2>PlayList</h2>
				</div>
				<div>
				</div>
				<div>"

				cont=1
				list_songs=`cat /home/pi/Downloads/list_songs.txt`
				cur_song=`cat /home/pi/Downloads/cur_song.txt`

				echo -e "
				<p><h4>Current Song: </h4> Index ${cur_song} (song${cur_song}.mp3)</p><p></p>";

				while IFS="" read -r -a song;
				do
					pivot=($song)
					echo "<p>Order $cont: ${pivot[1]}</p>";
					cont=$((cont+1))
				done <<< "$list_songs"




echo -e "		</div>
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
