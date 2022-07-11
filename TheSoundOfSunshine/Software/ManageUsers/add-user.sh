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
data=`echo $QUERY_STRING`

username=`echo $data | awk -F\& '{print $1}' | awk -F= '{print $2}'`
password=`echo $data | awk -F\& '{print $2}' | awk -F= '{print $2}'`
passwordrepeated=`echo $data | awk -F\& '{print $3}' | awk -F= '{print $2}'`

userexists=$(sudo cat /etc/passwd | awk -F: '{ print $1}' | grep $username)

# USERNAME
if [ -z "$username" ];
then
    #vacio
    $(sudo logger -p local0.info "Failed attempt to create a user in the system with the name: $username") >> /var/log/syslog    
    echo -e "
    <div>
        <form class="form" action="main-add-user.sh">
            <p> Sorry, username is empty <br/> </p>
			<input type="submit" value=\"Back\">
		</form>
    </div>"
elif [ -n "$userexists" ];
then
    #usuario ya existe nombre
    $(sudo logger -p local0.info "Failed attempt to create a user in the system with the name: $username (already exists)") >> /var/log/syslog    
    echo -e "
    <div>
        <form class="form" action="main-add-user.sh">
            <p> Sorry, the username is already in the system <br/></p>
			<input type="submit" value=\"Back\">
		</form>
    </div>"    

# PASSWORD
elif [ -z "$password" ] || [ -z "$passwordrepeated" ];
then
    #vacio
    $(sudo logger -p local0.info "Failed attempt to create a user in the system with the name: $username") >> /var/log/syslog    
    echo -e "
    <div>
        <form class="form" action="main-add-user.sh">
            <p>Sorry, there is an empty password is empty<br/></p>
			<input type="submit" value=\"Back\">
		</form>
    </div>"
elif [ "$password" == "$passwordrepeated" ];
then
    # wE CREATE THE USER
    sudo useradd -m -p $(openssl passwd -1 $password) $username
    $(sudo logger -p local0.info "New user created in the system with the name: $username") >> /var/log/syslog    
echo -e "
    <div>
        <form class="form" action="main-add-user.sh">
            <p> Alright! A new user created with name -> $username <br/></p>
			<input type="submit" value=\"Back\">
		</form>
    </div>"
else
    $(sudo logger -p local0.info "Failed attempt to create a user in the system with the name: $username") >> /var/log/syslog    
    echo -e "
    <div>
        <form class="form" action="main-manage-users.sh">
            <p> Sorry, passwords dont match <br/></p>
			<input type="submit" value=\"Back\">
		</form>
    </div>"   
fi

echo -e "

    </body>
</html>"

