#!/bin/bash

#Cron based disk free space logger

#check if user runs as sudo
if [ `id -u` -ne 0 ]; then
      echo "This script can be executed only as root, Exiting.."
      exit 1
   fi

#create crontab for root
#printf '%s\n' '1' | crontab -u root -e &> /dev/null

#create script file for crontask
touch /home/student/disk_usage.sh
echo "#!/bin/bash" >> /home/student/disk_usage.sh
echo "
df / | awk  'NR==2{print strftime(\"%d-%m-%y %H:%M:%S /// \")\"Free disk space on /root is: \" \$4}' >> /home/student/storageusage.txt 
" >> /home/student/disk_usage.sh

#duplicate old crontab and append new cron task
install -m 666 /dev/null /home/student/storageusage.txt
crontab -l > crontab_new
echo "* * * * * /home/student/disk_usage.sh" >> crontab_new
crontab crontab_new
rm crontab_new

#make the new cron task script file executable and exec it the first time
chmod +x /home/student/disk_usage.sh
./disk_usage.sh
