#!/bin/bash
echo Content-Type: text/html
echo
echo -e " <!DOCTYPE html>
<html>
    <head>
		<style>
             @import url(https://fonts.googleapis.com/css?family=Roboto:300);

            .main-container {
            width: 360px;
            padding: 8% 0 0;
            margin: auto;
            }

            .form {
            position: relative;
            z-index: 1;
            background: #FFFFFF;
            max-width: 360px;
            margin: 0 auto 100px;
            padding: 45px;
            text-align: center;
            box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);
            }

            .form input {
            font-family: "Roboto", sans-serif;
            outline: 0;
            background: #f2f2f2;
            width: 100%;
            border: 0;
            margin: 0 0 15px;
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
    <body>
"

dades=`echo $QUERY_STRING`
#echo -e "Los datos son $dades<br/>"

user=`echo $dades | awk -F\& '{print $1}' | awk -F= '{print $2}'`
password=`echo $dades | awk -F\& '{print $2}' | awk -F= '{print $2}'`
#echo -e "Hemos obtenido como usuario -> $user y como contrasenya -> $password <br/>"

shadow=$(sudo cat /etc/shadow | grep $user)
shadow_user=`echo $shadow | awk -F: '{print $1}'`
#echo -e "EL shadow es $shadow <br/>"
#echo -e "El user del shadow es  $shadow_user <br/>"

shadow_hash_type=`echo $shadow | awk -F: '{print $2}' | awk -F$ '{print $2}'`
#echo -e "El tipo de hash es -> $shadow_hash_type <br/>"

salt=`echo $shadow | awk -F: '{print $2}' | awk -F$ '{print $3}'`
#echo -e "El salt es -> $salt <br/>"

#echo -e "openssl passwd -$shadow_hash_type -salt $salt <br/>"

password_hashed=`echo $shadow | awk -F: '{print $2}' | awk -F$ '{print $4}'`
#echo -e "EL password hasheado es -> $password_hashed <br/>"

login=`echo $password | sudo openssl passwd -$shadow_hash_type -salt $salt | awk -F$ '{print $4}'`
#echo -e "Esto es: $login"

#echo -e "<br/> Contraseña introducida -> $login <br/>"
#echo -e "<br/> Contraseña hasheada -> $password_hashed <br/>"

if [ "$password_hashed" == "$login" ] && [ -n "$password_hashed" ] && [ -n "$login" ];
then
    $(sudo logger -p local0.info "There has been a login into the system with the name: $user") >> /var/log/syslog    
	echo -e "
	<div class="main-container">
		<div class="form">
			<form action="main-menu.sh">
				<p>Login Succesfully<br/></p>
				<input type="submit" value=\"Go to menu\">
			</form>
		</div>
    </div>"
else
    $(sudo logger -p local0.info "There has been a try to log into the system with the name: $user") >> /var/log/syslog
	echo -e "
	<div class="main-container">
		<div class="form">
			<form action="index.sh">
				<p>Login Failed<br/></p>
				<input type="submit" value=\"Back to login\">
			</form>
		</div>
    </div>"
fi

echo -e "
    </body>
</html>
"
