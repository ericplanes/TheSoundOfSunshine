#!/bin/bash
echo Content-Type: text/html
echo

#Creem fitxer file_pivot.txt
sudo touch /home/pi/Downloads/file_pivot.txt
sudo chmod 666 /home/pi/Downloads/file_pivot.txt

sudo shuf /home/pi/Downloads/list_songs.txt > /home/pi/Downloads/file_pivot.txt
cat /home/pi/Downloads/file_pivot.txt > /home/pi/Downloads/list_songs.txt
sudo rm -f /home/pi/Downloads/file_pivot.txt

echo "SYSLOG: Shuffle done on playlist." >> /home/pi/Downloads/system_logs.txt

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
					<h2>Shuffle</h2>
				</div>
				<div>
				<p>Shuffle done on playlist.</p>
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
