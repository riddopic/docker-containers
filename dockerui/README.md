## DockerUI

DockerUI is a web interface for the Docker Remote API.  The goal is to provide a pure client side implementation so it is effortless to connect and manage docker.  This project is not complete and is still under heavy development.

### Goals

* Minimal dependencies - I really want to keep this project a pure html/js app.
* Consistency - The web UI should be consistent with the commands found on the docker CLI.

### Container Quickstart

1. Run:
     $ docker run -d --name=dockerui --net host --privileged \
	 	-v /var/run/docker.sock:/var/run/docker.sock riddopic/dockerui

2. Open your browser to `http://<dockerd host ip>`

Bind mounting the Unix socket into the DockerUI container is much more secure than exposing your docker daemon over TCP. The `--privileged` flag is required for hosts using SELinux. You should still secure your DockerUI instance behind some type of auth. Directions for using Nginx auth are [here](https://github.com/crosbymichael/dockerui/wiki/Dockerui-with-Nginx-HTTP-Auth).

### Specify socket to connect to Docker daemon

By default DockerUI connects to the Docker daemon with`/var/run/docker.sock`. For this to work you need to bind mount the unix socket into the container with `-v /var/run/docker.sock:/var/run/docker.sock`.

You can use the `-e` flag to change this socket:

    # Connect to a tcp socket:
    $ docker run -d -p 9000:9000 --privileged dockerui/dockerui \
		-e http://127.0.0.1:2375

### Change address/port DockerUI is served on

DockerUI listens on port 9000 by default. If you run DockerUI inside a container then you can bind the container's internal port to any external address and port:

    # Expose DockerUI on 10.20.30.1:80
    $ docker run -d -p 10.20.30.1:80:9000 --privileged -v \
		/var/run/docker.sock:/var/run/docker.sock dockerui/dockerui
