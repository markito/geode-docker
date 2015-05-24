# Building the container image

The current Dockerfile is based on a CentOS 6 image, downloads JDK 8, clone the Apache Geode git repository, starts a build and execute the basic tests. 

```
docker build .
```

This may take a while depending on your internet connection, but it's worth since it's a one time step and you endup with container that is tested and ready to be used for development. It will download gradle and as part of the build, project dependencies as well. 

# Starting a locator and gfsh

1. Then you can start gfsh as well in order to perform more commands:

```
docker run -it -p 10334:10334 -p 7575:7575 -p 1099:1099  apache/geode gfsh
```


From this point you can pretty much follow Apache [Geode in 5 minutes](https://cwiki.apache.org/confluence/display/GEODE/Index#Index-Geodein5minutes) for example:

```
start server --name=server1
```

But in order to have real fun with containers you are probably better of using something like docker-compose or kubernetes. Those examples will come next. 

# Creating an Apache Geode cluster using multiple containers

...Create a docker-compose.yml 