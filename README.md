Docker files for [RDMO](https://github.com/rdmorganiser/rdmo)
=============================================================

The repository contains two dockerfiles that can be used to build RDMO dockers. They differ in the http server they use. One of them uses Nginx and the other one Apache.

### How to build and run
The ```build-and-run.sh``` can be used to create the docker images and automatically run them after a successful build.

If you prefer to do all this manually use the following command examples as an orientation.
```
sudo docker build -t ${tag} -f ${dockerfile} .
sudo docker run -d --publish ${port}:80 --name ${tag} ${tag}
```

### Note:
Please keep in mind that the data you enter into RDMO are stored in an sqllite db inside the docker container. If you remove the container your data are gone. If you are planning to remove the docker container and you want to keep your data you should save the relevant files.
