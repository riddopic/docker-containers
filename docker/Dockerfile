# encoding: UTF-8
#
# Author:    Stefano Harding <riddopic@gmail.com>
# License:   Apache License, Version 2.0
# Copyright: (C) 2014-2015 Stefano Harding
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FROM       riddopic/ubuntu-14.04
MAINTAINER Stefano Harding <riddopic@gmail.com>

ENV INITRD=no GOMAXPROCS=2 DEBIAN_FRONTEND=noninteractive PORT=4444
ADD root /
RUN apt-get-min update;\
    apt-get-install-min apt-transport-https ca-certificates curl lxc iptables ;\
    curl -sSL https://get.docker.com/ubuntu/ | sh;\
    apt-get-min clean;\
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* /var/cache/apt/archives/*
