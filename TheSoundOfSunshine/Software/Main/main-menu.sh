#!/bin/bash
echo Content-Type: text/html
echo
echo -e "
<!DOCTYPE html><html>
	<head>
		<style>
             @import url(https://fonts.googleapis.com/css?family=Roboto:300);

            .main-container {
            width: 360px;
            padding: 6% 0 0;
            margin: auto;
            }

            .form {
            position: relative;
            z-index: 1;
            background: #FFFFFF;
            max-width: 360px;
            margin: 0 auto 20px;
            padding: 10px;
            text-align: center;
            box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);
            }

            .form input {
            font-family: "Roboto", sans-serif;
            outline: 0;
            background: #f2f2f2;
            width: 100%;
            border: 0;
            padding: 15px;
            box-sizing: border-box;
            font-size: 14px;
            }

            .form button {
            font-family: "Roboto", sans-serif;
            text-transform: uppercase;
            outline: 0;
            background: #4CAF50;
            width: 100%;
            border: 0;
            padding: 15px;
            color: #FFFFFF;
            font-size: 14px;
            -webkit-transition: all 0.3 ease;
            transition: all 0.3 ease;
            cursor: pointer;
            }

            .form button:hover,.form button:active,.form button:focus {
            background: #43A047;
            }

            .form .message {
            margin: 15px 0 0;
            color: #b3b3b3;
            font-size: 12px;
            }

            .form .message a {
            color: #4CAF50;
            text-decoration: none;
            }

            .form .register-form {
            display: none;
            }

            .container {
            position: relative;
            z-index: 1;
            max-width: 300px;
            margin: 0 auto;
            }

            .container:before, .container:after {
            content: "";
            display: block;
            clear: both;
            }

            .container .info {
            margin: 50px auto;
            text-align: center;
            }

            .container .info h1 {
            margin: 0 0 15px;
            padding: 0;
            font-size: 36px;
            font-weight: 300;
            color: #1a1a1a;
            }

            .container .info span {
            color: #4d4d4d;
            font-size: 12px;
            }

            .container .info span a {
            color: #000000;
            text-decoration: none;
            }

            .container .info span .fa {
            color: #EF3B3A;
            }

			.restart {
				display: flex;
			}

            body {
            background: #76b852; /* fallback for old browsers */
            background: rgb(141,194,111);
            background: linear-gradient(90deg, rgba(141,194,111,1) 0%, rgba(118,184,82,1) 50%);
            font-family: "Roboto", sans-serif;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;      
            }

        </style>
	</head>
	<body>"
		
echo "User is:"
whoami
		
echo -e "
		<div class="main-container">
			<div>
				<form class="form" action="../ManageProcess/show-processes.sh">
					<div>
						<input type="submit" value=\"Process management\">
					</div>
				</form>

				<form class="form" action="../Monitoring/main-monitoring.sh">
					<div>
						<input type="submit" value="Monitoring">
					</div>
				</form>

				<form class="form" action="../ManageLogs/log-main.sh">
					<div>
						<input type="submit" value=\"Log management\">
					</div>
				</form>

				<form class="form" action="../ManageUsers/main-manage-users.sh">
					<div>
						<input type="submit" value=\"User management\">
					</div>
				</form>

				<form class="form" action="../FilterPackages/main-filter-policies.sh">
					<div>
						<input type="submit" value=\"Packet filtering\">
					</div>
				</form>

				<form class="form" action="../ManagePlanTasks/cron-menu.sh">
					<div>
						<input type="submit" value=\"Scheduled tasks management\">
					</div>
				</form>

				<form class="form" action="">
					<div>
						<input type="submit" value=\"Music functionalities\">
					</div>
				</form>
				</br>

				<div class="restart">
					<form class="form" action="../ShutdownAndReboot/stop-server.sh">
						<div>
							<input type="submit" value="Shut Down">
						</div>
					</form>

					<form class="form" action="../ShutdownAndReboot/restart-server.sh">
						<div>
							<input type="submit" value="Reboot">
						</div>
					</form>
				</div>

				<form class="form" action="index.sh">
					<div>
						<button type="submit">Back to login</button>
					</div>
				</form>
			</div>
		</div>
	</body>
</html>"

