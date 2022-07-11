#!/bin/bash
echo Content-Type: text/html
echo

echo "pause" > /home/pi/Downloads/pipe
echo "SYSLOG: Play or Pause option used." >> /home/pi/Downloads/system_logs.txt

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
					<h2>Pause | Play</h2>
				</div>
				<div>
				<p>Pause or Play option used.</p>
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
