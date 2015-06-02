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

FROM       acme/alpine
MAINTAINER Stefano Harding <riddopic@gmail.com>

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 53 53/udp
ENV GOMAXPROCS=2
ADD https://dl.bintray.com/mitchellh/consul/0.5.2_web_ui.zip / \
    root /
RUN apk add --update dnsmasq openssh curl;\
    rm -rf /var/cache/apk/*;\
    unzip -o /0.5.2_web_ui.zip;\
    mkdir /ui;\
    mv /dist/* /ui;\
    rm -rf /dist /0.5.2_web_ui.zip;\
    chown -R consul:consul /ui
