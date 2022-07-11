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
        echo "Los datos son $data<br/>"

        type=`echo $data | awk -F\& '{print $1}' | awk -F= '{print $2}'`
        action=`echo $data | awk -F\& '{print $2}' | awk -F= '{print $2}'`
        sourceaddress=`echo $data | awk -F\& '{print $3}' | awk -F= '{print $2}'`
        destinationaddress=`echo $data | awk -F\& '{print $4}' | awk -F= '{print $2}'`
        protocol=`echo $data | awk -F\& '{print $5}' | awk -F= '{print $2}'`
        sourceport=`echo $data | awk -F\& '{print $6}' | awk -F= '{print $2}'`
        destinationport=`echo $data | awk -F\& '{print $7}' | awk -F= '{print $2}'`

        echo " $type <br/>"
        echo " $action <br/>"
        echo " $sourceaddress <br/>"
        echo " $destinationaddress <br/>"
        echo " $protocol <br/>"
        echo " $sourceport <br/>"
        echo " $destinationport <br/>"


#type
if [ -z "$type" ];
then
    # tiene que haber tipo
    echo -e "
    <div>
        <form class="form" action="main-add-filter-policy.sh">
            <p> Sorry, there has to be a type <br/></p>
			<input type="submit" value=\"Back to add policy menu\">
		</form>
    </div>"
else

    typeUpper=$(echo $type | tr '[:lower:]' '[:upper:]')
    typecondition=" $typeUpper"

    if [ -z "$action" ];
    then
        # tiene que haber action
        echo -e "
        <div>
            <form class="form" action="main-add-filter-policy.sh">
                <p> Sorry, there has to be an action <br/></p>
                <input type="submit" value=\"Back to add policy menu\">
            </form>
        </div>"
    else

        actionUpper=$(echo $action | tr '[:lower:]' '[:upper:]')
        actioncondition=" -j $actionUpper"
            
        #source address
        if [ -n "$sourceaddress" ];
        then
            sourceaddressCondition=" -s $sourceaddress"
        else
            sourceaddressCondition=""
        fi

        #destination address
        if [ -n "$destinationaddress" ];
        then
            destinationaddressCondition=" -d $destinationaddress"
        else
            destinationaddressCondition=""
        fi

        #protocol
        if [ -n "$protocol" ];
        then
            protocolCondition=" -p $protocol"
        else
            protocolCondition=""
        fi

        #source port
        if [ -n "$sourceport" ];
        then
            sourceportCondition=" -sport $sourceport"
        else
            sourceportCondition=""
        fi

        #destination port
        if [ -n "$destinationport" ];
        then
            destinationportCondition=" -dport $destinationport"
        else
            destinationportCondition=""
        fi

        # WE ADD THE RULE
        echo " $typecondition <br/>"
        echo " $actioncondition <br/>"
        echo " $sourceaddressCondition <br/>"
        echo " $destinationaddressCondition <br/>"
        echo " $protocolCondition <br/>"
        echo " $sourceportCondition <br/>"
        echo " $destinationportCondition <br/>"

        echo "iptables -A$typecondition$sourceaddressCondition$destinationaddressCondition$protocolCondition$sourceportCondition$destinationportCondition$actioncondition"

        $(sudo iptables -A$typecondition$sourceaddressCondition$destinationaddressCondition$protocolCondition$sourceportCondition$destinationportCondition$actioncondition)
        echo -e "
        
            <form class="form" action="main-filter-policies.sh">
                <div>
                    <input type="submit" value=\"Back\">
                </div>
	        </form>"

    fi
fi

echo -e "
    </body>
</html>"

