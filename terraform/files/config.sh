#!/bin/bash
yum install -y python3 git
mkdir /apps && git clone https://github.com/Azure-Samples/docker-django-webapp-linux.git /apps/django-webapp-linux/
pip3 install -r /apps/django-webapp-linux/requirements.txt --no-cache-dir
python3 /apps/django-webapp-linux/manage.py migrate
python3 /apps/django-webapp-linux/manage.py runserver 0.0.0.0:3001 &> /dev/null &
