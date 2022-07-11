#!/bin/bash
echo Content-Type: text/html
echo

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
					<h2>Music</h2>
				</div>

				<form action="music_playlisy_start.sh">
					<div>
						<input type="submit" value=\"Start\">
					</div>
				</form>

				<form action="music_song_play.sh">
					<div>
						<input type="submit" value=\"Pause | Play\">
					</div>
				</form>
				
				<form action="music_song_nav_rewind.sh">
					<div>
						<input type="submit" value=\"Rewind\">
					</div>
				</form>

				<form action="music_song_nav_forward.sh">
					<div>
						<input type="submit" value=\"Forward\">
					</div>
				</form>

				<form action="music_playlist.sh">
					<div>
						<input type="submit" value=\"PlayList\">
					</div>
				</form>

				<form action="music_playlisy_shuffle.sh">
					<div>
						<input type="submit" value=\"Shuffle\">
					</div>
				</form>

				<form action="music_song_replay.sh">
					<div>
						<input type="submit" value=\"StopReplay | StartReplay\">
					</div>
				</form>

				<p></p>
				
				<div>
					<p>Back to Server Web App</p>
					<div>
						<form action="../Main/main.sh">
							<input type="submit" value="Go Back">
						</form>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>"
