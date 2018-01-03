#!/usr/bin/env bash

cd resources 2>/dev/null

if [ $? != 0 ]; then
    echo "setup.sh must be run from the root folder of the project, i.e parent of (...)/resources/"
    exit 1
fi

cd ..

if [ ! -e ./resources/local.ini ]; then
    echo "generating local.ini (including postgresql password)"
    export POSTGRES_PASSWORD=$(python -c "import random;import string;print(''.join(random.SystemRandom().choice(string.ascii_uppercase + string.ascii_lowercase + string.digits) for _ in range(40)))")
    cat >> ./resources/local.ini <<EOF
[django]
POSTGRES_PASSWORD=$POSTGRES_PASSWORD
EOF
else
    source resources/local.ini 2>/dev/null
fi

echo "pulling images"
docker-compose pull

docker-compose run -d db > /tmp/db_name.txt
DB_CONTAINER_NAME=$(cat /tmp/db_name.txt)
DB_CONTAINER_IP=$(docker inspect $DB_CONTAINER_NAME | grep '"IPAddress"' | grep -v \"\" | cut -d\" -f4)
DB_CONTAINER_NETWORK=$(docker inspect $DB_CONTAINER_NAME | grep '"Networks"' -A 1 | tail -n 1 | cut -d\" -f2)

echo "Waiting after the db during its initialization"
READY=1
while [ $READY != 0 ];
do
    docker run -it --rm --net $DB_CONTAINER_NETWORK --link $DB_CONTAINER_NAME:postgres postgres psql -h $DB_CONTAINER_IP -U postgres "password=$POSTGRES_PASSWORD" -c 'SELECT 1;' 1>/dev/null
    READY=$?
    if [ $READY != 0 ]; then
        echo "not yet"
        sleep 1
    else
        echo "done !"
    fi
done
docker-compose down

echo "You now can do docker-compose up"
