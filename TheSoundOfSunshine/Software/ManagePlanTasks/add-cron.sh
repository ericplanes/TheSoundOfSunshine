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
dades=`echo $QUERY_STRING`

weekday=`echo $dades | awk -F\& '{print $1}' | awk -F= '{print $2}'`
month=`echo $dades | awk -F\& '{print $2}' | awk -F= '{print $2}'`
monthday=`echo $dades | awk -F\& '{print $3}' | awk -F= '{print $2}'`
hour=`echo $dades | awk -F\& '{print $4}' | awk -F= '{print $2}'`
minute=`echo $dades | awk -F\& '{print $5}' | awk -F= '{print $2}'`
command=`echo $dades | awk -F\& '{print $6}' | awk -F= '{print $2}'`


#weekday
if [ -z "$weekday" ];
then
    weekday=*
elif (( "$weekday" > 6 || "$weekday" < 0 ));
then
    echo -e "
    <div>
        <form class="form" action="add-cron-menu.sh">
            <p>Error in weekday format<br/></p>
			<input type="submit" value=\"Back to cron menu\">
		</form>
    </div>"
fi

#month
if [ -z "$month" ];
then
    month=*
elif (( "$month" > 12 && "$month" < 1 ));
then
    echo -e "
    <div>
        <form class="form" action="add-cron-menu.sh">
            <p>Error in month format<br/></p>
			<input type="submit" value=\"Back to cron menu\">
		</form>
    </div>"
fi

#monthday
if [ -z "$monthday" ];
then
    monthday=*
elif (( "$monthday" > 31 && "$monthday" < 1 ));
then
    echo -e "
    <div>
        <form class="form" action="add-cron-menu.sh">
            <p>Error in monthday format<br/></p>
			<input type="submit" value=\"Back to cron menu\">
		</form>
    </div>"
fi

#hour
if [ -z "$hour" ];
then
    hour=*
elif (( "$hour" > 23 && "$hour" < 0 ));
then
    echo -e "
    <div>
        <form class="form" action="add-cron-menu.sh">
            <p>Error in hour format<br/></p>
			<input type="submit" value=\"Back to cron menu\">
		</form>
    </div>"
fi

#minute
if [ -z "$minute" ];
then
    minute=*
elif (( "$minute" > 59 && "$minute" < 0 ));
then
    echo -e "
    <div>
        <form class="form" action="add-cron-menu.sh">
            <p>Error in minute format<br/></p>
			<input type="submit" value=\"Back to cron menu\">
		</form>
    </div>"
fi


if [ -z "$command" ];
then
    echo -e "
    <div>
        <form class="form" action="add-cron-menu.sh">
            <p>Sorry, there is no command to save<br/></p>
			<input type="submit" value=\"Back to cron menu\">
		</form>
    </div>"
fi

x="$command"
x="$(echo $x | sed 's|%2F|/|g')"

sudo echo "$minute $hour $monthday $month $weekday $x" >> /home/pi/crontabs

echo -e "
        <div>
            <form class="form" action="cron-menu.sh">
                <p> Alright! A new task created <br/></p>
			    <input type="submit" value=\"Back\">
		    </form>
        </div>
    </body>
</html>"

