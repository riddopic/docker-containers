
# IPtables Helper for Squid Proxy

This Dockerfile builds a simple container to run IPtables rules for using the Squid caching web proxy.

## Usage

This docker image is available as a trusted build on the docker index, so there's no setup required. Using this image for the first time will start a download. Further runs will be immediate, as the image will be cached locally.

The recommended way to run this container looks like this:

    docker run -d --name=iptables --net host --privileged riddopic/router

This has the effect of running the following IPtables rule on your docker host:

    iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to 3129

Remove:
	iptables -t nat -D PREROUTING -p tcp --dport 80 -j REDIRECT --to 3129

## License
```
Author::   Stefano Harding <riddopic@gmail.com>
Copyright: 2014-2015, Stefano Harding

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
