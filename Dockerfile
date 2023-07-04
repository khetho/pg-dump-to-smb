FROM amazonlinux:latest

#Database connection details
ENV PGHOST=""
ENV PGPORT="5432"
ENV PGDATABASE=""
ENV PGUSER=""
ENV PGPASSWORD=""

#Samba client connection details
ENV SHARE=""
ENV USER=""
ENV PASSWD=""

LABEL maintainer="Khetho Mtembo <khetho@gmail.com>"
# Install any necessary packages
RUN yum update -y
RUN yum install postgresql15 postgresql15-contrib gzip samba-client cifs-utils -y
# Copy the script to the container
COPY ./backup_to_smb.sh /
RUN chmod +x /backup_to_smb.sh
# Set the entrypoint to the script with CMD arguments
ENTRYPOINT ["./backup_to_smb.sh"]