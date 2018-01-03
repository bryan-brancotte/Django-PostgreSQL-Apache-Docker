# Django-PostgreSQL-Apache-Docker

## Install it

```
./resources/setup.sh
```

It will initialize the password of the db in resources/local.ini and then the db in /opt/dpad/

To change the folder, edit [docker-compose.yml](https://github.com/bryan-brancotte/Django-PostgreSQL-Apache-Docker/blob/6f39dacd6f32ddb0024679f3a2c880639cc4731e/docker-compose.yml#L9). For testing purpose you can set it to /tmp/dpad/.

## Run it

```
docker-compose up
```

## None-apache hosting

Note that you can use the django server to host the project:
```
docker-compose run web runserver
```
which is a shortcut for
```
docker-compose run web python manage.py runserver 0.0.0.0:8000
```
