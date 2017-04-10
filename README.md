Docker files for [RDMO](https://github.com/rdmorganiser/rdmo)
=============================================================

Build docker image
------------------

```
docker build -t rdmo .
```

Setup the application
---------------------

1. Copy `sample.local.py` to `local.py` (which is ignored by this git repository):

    ```
    cp sample.local.py local.py
    ```

    and edit the file accourding to your particular setup. Please see the [documentation](http://rdmo.readthedocs.io/en/latest/configuration/index.html) for more information about configuring RDMO.

2. Build the docker image using:

    ```
    docker-compose build
    ```

3. Setup the database

    ```
    docker-compose run django python manage.py migrate
    ```

4. Create and admin user

    ```
    docker-compose run django python manage.py createsuperuser
    ```

5. Run the container for a test

    ```
    docker-compose up
    ```

The application should now be available at [http://localhost:8000](http://localhost:8000). All the steps from the [documentation](http://rdmo.readthedocs.io/en/latest/configuration/index.html) involving `manage.py` can be performed using `docker-compose run django python manage.py`.


Run the application as a deamon
-------------------------------

### Start the application

```
docker-compose start
```

### Stop the application

```
docker-compose stop
```
