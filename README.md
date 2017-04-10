Docker files for [RDMO](https://github.com/rdmorganiser/rdmo)
=============================================================

Build docker image
------------------

```
docker build -t rdmo .
```

Setup the application
---------------------

1. Copy `production.py` to `local.py` (which is ignored by this git repository):

    ```
    cp sample.local.py local.py
    ```

    and edit the file accourding to your particular setup. Please see the [documentation](http://rdmo.readthedocs.io/en/latest/configuration/index.html) for more information about configuring RDMO.

2. Setup the database on the host or a different machine with the credentials in `local.py`.
   The IP of the database host needs to be provided to docker using the `--add-host` argument.
   For a database on the docker host this is usually `172.17.0.1`.

3. Setup the database

    ```
    docker run --add-host=dbhost:172.17.0.1 rdmo python manage.py migrate
    ```

4. Create and admin user

    ```
    docker run --add-host=dbhost:172.17.0.1 rdmo python manage.py create-admin-user
    ```

5. Run the container for a test

    ```
    docker run -p 127.0.0.1:8000:80 --add-host=dbhost:172.17.0.1 rdmo
    ```

The application should now be available at [http://localhost:8000](http://localhost:8000). All the steps from the [documentation](http://rdmo.readthedocs.io/en/latest/configuration/index.html) involving `manage.py` can be performed using `docker run --add-host=dbhost:172.17.0.1 rdmo python manage.py migrate`.

Run the application as a deamon
-------------------------------

### Start the application

```
docker run -d --name rdmo -p 127.0.0.1:8000:80 --add-host=dbhost:172.17.0.1 rdmo
```

### Stop the application

```
docker stop rdmo
```
