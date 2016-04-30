#!/bin/sh
## backup.sh for  in /home/baptiste/secu/Backup_sql_freebsd
## 
## Made by 
## Login   <baptiste.heraud@epitech.eu>
## 
## Started on  Sat Apr 30 12:09:26 2016 
## Last update Sat Apr 30 12:10:28 2016 
##

#Script sauvegarde avec rotation de log (WORK with freebsd 9)
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
$MYSQLDUMP -u $MyUSER -h $MyHOST -p$MyPASS common2 | $GZIP > /var/tmp/mysql_backups/common2.gz
$MYSQLDUMP -u $MyUSER -h $MyHOST -p$MyPASS player | $GZIP > /var/tmp/mysql_backups/player.gz
$MYSQLDUMP -u $MyUSER -h $MyHOST -p$MyPASS yurima | $GZIP > /var/tmp/mysql_backups/yurima.gz


sleep 5 
cd /home/sauvegarde/
find . -type f -name 'savemysql*.tar.bz' | sed -e 's/^.*[^0-9]\([0-9]*\).tar.bz/\1/g'| sort -rn | while read A
do
 B=$(expr $A + 1)
 mv savemysql${A}.tar.bz savemysql${B}.tar.bz
done
tar cvjf savemysql1.tar.bz /var/tmp/mysql_backups/ 
sleep 5
cd /var/tmp/mysql_backups/
rm *.gz

