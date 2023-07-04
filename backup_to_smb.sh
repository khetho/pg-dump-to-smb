#!/bin/bash
export PGBACKUPFILE="nottodb-backup-$(date +"%Y_%m_%d_%I_%M_%p").tar.gz"

if [ -z "$PGHOST" ]; then
  echo "Missing Postgres database host name, provide -e PGHOST=host"
  exit 1
fi

if [ -z "$PGDATABASE" ]; then
  echo "Missing Postgres database name, provide -e PGDATABASE=database"
  exit 2
fi

if [ -z "$PGUSER" ]; then
  echo "Missing Postgres database user name, provide -e PGUSER=user"
  exit 3
fi

if [ -z "$PGPASSWORD" ]; then
  echo "Missing Postgres database user password, provide -e PGPASSWORD=password"
  exit 4
fi

if [ -z "$SHARE" ]; then
  echo "Missing Samba share, provide -e SHARE=share"
  exit 5
fi

if [ -z "$USER" ]; then
  echo "Missing Samba username, provide -e USER=user"
  exit 6
fi

if [ -z "$PASSWD" ]; then
  echo "Missing Samba password, provide -e PASSWD=password"
  exit 7
fi

yum update -y
yum install postgresql15 postgresql15-contrib gzip samba-client cifs-utils -y
gzip --version
psql --version
pg_dump --version
smbclient --version

echo "Exporting: $PGBACKUPFILE"
pg_dump -v -F c | gzip > "/tmp/$PGBACKUPFILE"

if [ $? -eq 0 ]; then
    echo "PostgreSQL Backup Succesful"
    cd /tmp
    smbclient $SHARE --command  "put $PGBACKUPFILE"  
    if [ $? -eq 0 ]; then
        echo "Transfer to Azure Succesful"
        smbclient $SHARE  --command="ls $PGBACKUPFILE"
        rm "/tmp/$PGBACKUPFILE"
    else
        echo "Transfer to Azure Failed"
        exit 8
    fi
else
    echo "PostgreSQL Backup Failed"
    exit 9
fi
