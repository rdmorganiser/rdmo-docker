#!/bin/bash

gunicorn --bind unix:/srv/rdmo/rdmo.sock config.wsgi:application -D
nginx -g "daemon off;"
