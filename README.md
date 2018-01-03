# Django-PostgreSQL-Apache-Docker

## Install it

```
./resources/setup.sh
```

It will initialize the password of the db in resources/local.ini and then the db in /opt/dpad/

To change the folder, edit [docker-compose.yml](https://github.com/bryan-brancotte/Django-PostgreSQL-Apache-Docker/blob/10387a0b428cc4da4d25e5203a5b352ee6b2dc5f/docker-compose.yml#L9). For testing purpose you can set it to /tmp/dpad/.

## Run it

```
docker-compose up
```
