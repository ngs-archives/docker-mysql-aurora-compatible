# docker-mysql-aurora-compatible

(WIP) Docker Container compatible with Amazon Aurora MySQL Engine

## How to use

```sh
$ docker pull atsnngs/mysql-aurora-compatible
$ docker run --detach \
      --publish 13306:3306 \
      --volume $(pwd)/data:/var/mysql \
      --volume $(pwd)/log:/var/log \
      -it atsnngs:mysql-aurora-compatible
$ mysql -uroot -P13306
```
