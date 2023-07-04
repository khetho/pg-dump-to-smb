# PostgreSQL Dump to Samba Share
pg-dump-to-smb can be used to create a backup of a Postgres database  and upload the backup to an Samba server.

It can be used to back up databases in AWS RDS to Azure Storage using AWS Batch. The following links may be of use

Creating and use an Azure file share https://learn.microsoft.com/en-us/azure/storage/files/storage-how-to-use-files-portal?tabs=azure-portal

Create and connect to a PostgreSQL database with Amazon RDS https://aws.amazon.com/getting-started/hands-on/create-connect-postgresql-db/

The following variables are requied:

| Variable      | Description                   |
| -----------   | -----------                   |
| PGHOST        | PostgreSQL DB host            |
| PGDATABASE    | PostgreSQL DB database name   |
| PGPORT        | PostgreSQL DB Port            |
| PGUSER        | PostgreSQL DB user            |
| PGPASSWORD    | PostgreSQL DB password        |
| SHARE         | Samba share                   |
| USER          | Samba user                    |
| PASSWD        | Samba password                |