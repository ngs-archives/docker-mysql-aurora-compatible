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

RUN /opt/mysql/server-5.6/scripts/mysql_install_db \
  --basedir=/opt/mysql/server-5.6 \
  --datadir=/var/mysql \
  --plugin-dir=/opt/mysql/server-5.6/lib/plugin \
  --user=mysql \
  --log-error=/var/log/mysql/install_db_error.log


RUN mkdir -p /var/mysql && \
    mkdir -p /var/log/mysql && \
    chown mysql /var/mysql && \
    chown mysql /var/log/mysql

ENTRYPOINT ["/opt/mysql/server-5.6/bin/mysqld"]
CMD [ \
  "--basedir=/opt/mysql/server-5.6", \
  "--datadir=/var/mysql", \
  "--plugin-dir=/opt/mysql/server-5.6/lib/plugin", \
  "--user=mysql", \
  "--log-error=/var/log/mysql/error.log" \
  "--skip-grant-tables" \
]
EXPOSE 3306

# Usage:
#   $ docker run --detach \
#       --publish 13306:3306 \
#       --volume $(pwd)/data:/var/mysql \
#       --volume $(pwd)/log:/var/log \
#       -it atsnngs:mysql-aurora-compatible
#    $ mysql -uroot -P13306
