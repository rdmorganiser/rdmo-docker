FROM python:2.7
ENV PYTHONUNBUFFERED 1

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    build-essential libxml2-dev libxslt-dev git \
    python-dev python-pip virtualenv \
    pandoc \
    texlive \
    apache2 libapache2-mod-wsgi \
    memcached

RUN pip install --upgrade pip
RUN pip install --upgrade wheel
RUN pip install --upgrade setuptools
RUN pip install rdmo
RUN pip install psycopg2
RUN pip install python-memcached

RUN useradd -m -d /srv/rdmo -s /bin/bash rdmo

USER rdmo

RUN git clone https://github.com/rdmorganiser/rdmo-app /srv/rdmo/rdmo-app

WORKDIR /srv/rdmo/rdmo-app

ADD local.py config/settings/local.py

RUN python manage.py download_vendor_files
RUN python manage.py collectstatic --no-input

USER root

ADD apache.conf /etc/apache2/sites-available/000-default.conf

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE=/var/run/apache2.pid
ENV APACHE_LOCK_DIR=/var/lock/apache2

EXPOSE 80
CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
