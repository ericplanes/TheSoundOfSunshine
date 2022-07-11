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
