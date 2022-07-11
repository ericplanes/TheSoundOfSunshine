#!/bin/bash
echo Content-Type: text/html
echo

#Parem els processos si estaven actius
sudo pkill -9 -f mpg123
sudo pkill -9 -f music_playlisy_play.sh

nohup bash music_playlisy_mpg123.sh > /dev/null 2>&1 & disown
sudo chmod 777 /home/pi/Downloads/pipe
nohup bash music_playlisy_play.sh > /dev/null 2>&1 & disown

echo "SYSLOG: Playlist reproduction started." >> /home/pi/Downloads/system_logs.txt

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
					<h2>Start Playlist Reproduction</h2>
				</div>

                <div>
					<p>Playlist reproduction started.</p>
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
