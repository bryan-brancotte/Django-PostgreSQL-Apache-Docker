# Django-PostgreSQL-Apache-Docker

## Install it

```
./resources/setup.sh
```

It will initialize the password of the db in resources/local.ini and then the db in /opt/dpad/

To change the folder, edit [docker-compose.yml](https://github.com/bryan-brancotte/Django-PostgreSQL-Apache-Docker/blob/master/docker-compose.yml#L9). For testing purpose you can set it to /tmp/dpad/.

## Run it

```
docker-compose up
```

## None-apache hosting

You can simply start the web container (which will start the db) and 
not use Apache. Once the container started you might want to have its ip:
```
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq) | head -n 1 
```
For the remaining of this section, we consider that you got 172.18.0.3


### Using django web server
You can use django to server the project:
```
docker-compose run web django
```
which is a shortcut for
```
docker-compose run web python manage.py runserver 0.0.0.0:80
```
It will be served at [http://172.18.0.3](http://172.18.0.3)

### Using gunicorn

You can use gunicorn to serve in https the project:
```
docker-compose run web gunicorn
```
It will serve in https using the certs specified in default.ini/local.ini

It will be served at [https://172.18.0.3](https://172.18.0.3)

### No hosting, just a shell
You can enter the container by typing
```
docker-compose run web bash
```

