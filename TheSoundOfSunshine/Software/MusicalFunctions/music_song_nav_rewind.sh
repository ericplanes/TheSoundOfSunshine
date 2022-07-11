#!/bin/bash
echo Content-Type: text/html
echo

echo "SYSLOG: Back done on playlist song." >> /home/pi/Downloads/system_logs.txt

sudo pkill -9 -f music_playlisy_play.sh
nohup bash music_playlisy_play.sh 1 1 > /dev/null 2>&1 & disown

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
					<h2>Regress song</h2>
				</div>
				<div>
					<p>Back done on playlist song.</p>
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
