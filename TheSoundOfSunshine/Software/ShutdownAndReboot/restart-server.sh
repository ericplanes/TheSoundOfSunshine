#!/bin/bash
echo Content-Type: text/html
echo
echo -e 

$(sudo logger -p local0.info "System has been restarted") >> /var/log/syslog    
$(sudo service apache2 restart)
