#!/bin/bash

cd /code

echo "Applying database migrations"
python manage.py migrate

echo "Compilling localization (.po -> .mo)"
python manage.py compilemessages

echo "Collecting static files"
python manage.py collectstatic --noinput

echo "Compressing css files"
if [ "$(pip freeze | grep csscompressor | wc -l )" == "1" ]; then
    for css_file in $(find $(python manage.py shell -c "from django.conf import settings; print(settings.STATIC_ROOT)") -name \*.css -print | grep -v .min.css); do
        ls -laH $css_file
        d=$(date -R -r $css_file)
        python -m csscompressor $css_file -o $css_file;
        touch -d "$d" $css_file
    done
else
    echo "csscompressor missing, passed"
fi

MEDIA_ROOT_DIR=$(python manage.py shell -c "from django.conf import settings; print(settings.MEDIA_ROOT)")
echo "Creating media root at $MEDIA_ROOT_DIR"
if [ "$MEDIA_ROOT_DIR" != "" ]; then
    mkdir -p $MEDIA_ROOT_DIR
    chmod 777 $MEDIA_ROOT_DIR
else
    echo "settings.MEDIA_ROOT missing, passed"
fi

#Setting up cron tasks
echo "Cron tasks"
if [ "$(pip freeze | grep django-crontab | wc -l )" == "1" ]; then
    python manage.py crontab add
    service cron start
else
    echo "django-crontab missing, passed"
fi

#if [ "$1" == "loaddata" ]; then
#    echo "Load initial data"
#    #./misc/tool_shed.py find-in-json "$(./manage.py dumpdata auth.group 2>/dev/null)" 'name' --recursive --return-all --print-values --separator '\n'
#    python manage.py loaddata */fixtures/*.json
#el
if [ "$1" == "do_not_start" ]; then
    echo "Entrypoint have been run successfully, we are not starting the project as requested"
elif [ "$1" == "runserver" ]; then
    exec python manage.py runserver 0.0.0.0:8000
elif [ "$1" == "makemessages" ]; then
    exec python manage.py makemessages -l en --no-location
else
    rm -f /var/run/apache2/apache2.pid
    rm -rf /run/httpd/* /tmp/httpd*
    chmod -R 777 /tmp/* 2>/dev/null
    exec "$@"
fi

# Start server
#echo "Starting server"
#python manage.py runserver 0.0.0.0:8001
