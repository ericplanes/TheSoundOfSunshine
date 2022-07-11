#!/bin/bash
echo Content-Type: text/html
echo
echo -e 

$(sudo logger -p local0.info "System has been stoped") >> /var/log/syslog    
$(sudo /etc/init.d/apache2 stop)
