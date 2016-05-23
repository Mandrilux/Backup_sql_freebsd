#!/bin/sh

#Script sauvegarde

MyUSER="metin2"
MyPASS="epv4minq"
MyHOST="localhost"

MYSQL="/usr/local/bin/mysql"
MYSQLDUMP="/usr/local/bin/mysqldump"
GZIP="/usr/bin/gzip"
SCP="/usr/bin/scp"
TAIL="/usr/bin/tail"
AWK="/usr/bin/awk"
DF="/bin/df"

$MYSQLDUMP -u $MyUSER -h $MyHOST -p$MyPASS account | $GZIP > /var/tmp/mysql_backups/account.gz
$MYSQLDUMP -u $MyUSER -h $MyHOST -p$MyPASS common | $GZIP > /var/tmp/mysql_backups/common.gz
$MYSQLDUMP -u $MyUSER -h $MyHOST -p$MyPASS player | $GZIP > /var/tmp/mysql_backups/player.gz

sleep 3 
cd /home/
tar czvf file.tar.gz metin2
mv file.tar.gz /var/tmp/mysql_backups/
cd /home/sauvegarde/
sleep 2
find . -type f -name 'savemysql*.tar.bz' | sed -e 's/^.*[^0-9]\([0-9]*\).tar.bz/\1/g'| sort -rn | while read A
do
 B=$(expr $A + 1)
 mv savemysql${A}.tar.bz savemysql${B}.tar.bz
done
tar cvjf savemysql1.tar.bz /var/tmp/mysql_backups/ 
sleep 5
cd /var/tmp/mysql_backups/
rm *.gz

