# vincowl/Grav-PHP-Nginx-v2
This is derivated from ![dsavell/docker-grav](https://github.com/dsavell/docker-grav)

![grav](https://getgrav.org/user/pages/media/grav-logo.svg)

Grav is a Fast, Simple, and Flexible file-based Web-platform. There is Zero installation required. Although Grav follows principles similar to other flat-file CMS platforms, it has a different design philosophy than most.

The underlying architecture of Grav is built using well established and best-in-class technologies. This is to ensure that Grav is simple to use and easy to extend. Some of these key technologies include:

* Twig Templating: for powerful control of the user interface
* Markdown: for easy content creation
* YAML: for simple configuration
* Parsedown: for fast Markdown and Markdown Extra support
* Doctrine Cache: for performance
* Pimple Dependency Injection Container: for extensibility and maintainability
* Symfony Event Dispatcher: for plugin event handling
* Symfony Console: for CLI interface
* Gregwar Image Library: for dynamic image manipulation

## What is vincowl/Grav-PHP-Nginx-v2 ?

This is derivated from ![dsavell/docker-grav](https://github.com/dsavell/docker-grav)
It is a Docker image based on minideb:bullseye linux with Grav CMS and PHP8.0/nginx.

## Container Information

+ bitnami/minideb:bullseye
+ php8.0 + FPM
+ nginx
+ GRAV Core
+ GRAV Admin Plugin
+ optional [multisite installation](https://learn.getgrav.org/16/advanced/multisite-setup) using subdirectories

## Usage

```
docker create \
  --name=grav \
  --restart unless-stopped \
  -p 80:80 \
  -e DUID=1000 \
  -e DGID=1000 \
  -e GRAV_MULTISITE=subdirectory \
  -v /data/containers/grav/backup:/var/www/grav/backup \
  -v /data/containers/grav/logs:/var/www/grav/logs \
  -v /data/containers/grav/user:/var/www/grav/user \
  vincowl/Grav-PHP-Nginx-v2
docker start grav
```

## Tags
[latest](https://github.com/Grav-PHP-Nginx-v2/blob/master/Dockerfile)

## Tag usage
You can choose between ,using tags, no tag is required for grav default installation.

Add one of the tags,  if required:

+ ***Example:*** vincowl/Grav-PHP-Nginx-v2:latest


## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 80` | http |
| `-e DUID=1000` | for UserID - see below for explanation |
| `-e DGID=1000` | for GroupID - see below for explanation |
| `-e GRAV_MULTISITE=subdirectory` | Deploy a Grav multisite (subdirectory) installation |
| `-v /var/www/backup` | Contains your location for Grav backups |
| `-v /var/www/logs` | Contains your location for your Grav log files |
| `-v /var/www/user` | Contains your Grav content |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `DUID` and group `DGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `DUID=1000` and `DGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```

## Accessing the application
Access the webui at `http://<your-ip>`, for more information check out [GRAV](https://getgrav.org/)

## Using the container

+ Shell Access to container when it is running: `docker exec -it grav /bin/bash`
+ To monitor the logs of the container in realtime: `docker logs -f grav`
