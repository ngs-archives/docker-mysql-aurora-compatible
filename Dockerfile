FROM debian:jessie

RUN groupadd -r mysql && useradd -r -g mysql mysql

RUN set -x && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends curl libaio1 pwgen openssl perl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -ksLo /mysql-5.6.10-debian6.0-x86_64.deb 'https://cdn.mysql.com/archives/mysql-5.6/mysql-5.6.10-debian6.0-x86_64.deb' && \
    dpkg -i /mysql-5.6.10-debian6.0-x86_64.deb && \
    rm /mysql-5.6.10-debian6.0-x86_64.deb

RUN /opt/mysql/server-5.6/scripts/mysql_install_db

ENTRYPOINT ["/opt/mysql/server-5.6/bin/mysqld"]
CMD ["/opt/mysql/server-5.6/bin/mysqld"]
EXPOSE 3306
