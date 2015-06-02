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

FROM       acme/ubuntu-14.04
MAINTAINER Stefano Harding <riddopic@gmail.com>

ENV LANG=C.UTF-8 JAVA_VERSION=8u45 JAVA_DEBIAN_VERSION=8u45-b14-2~bpo8+2 \
    CA_CERTIFICATES_JAVA_VERSION=20140324 ELASTICSEARCH_VERSION=1.5.2
EXPOSE 9200 9300
RUN apt-get-min update && \
    apt-get-install-min ca-certificates curl wget unzip && \
    apt-get-install-min openjdk-8-jre-headless="$JAVA_DEBIAN_VERSION" \
		                    ca-certificates-java="$CA_CERTIFICATES_JAVA_VERSION" && \
    rm -rf /var/lib/apt/lists/* && \
    /var/lib/dpkg/info/ca-certificates-java.postinst configure && \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && \
    curl -o /usr/local/bin/gosu     -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" && \
    curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" && \
    gpg --verify /usr/local/bin/gosu.asc && \
    rm /usr/local/bin/gosu.asc && \
    chmod +x /usr/local/bin/gosu && \
    apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 46095ACC8548582C1A2699A9D27D666CD88E42B4 && \
    echo "deb http://packages.elasticsearch.org/elasticsearch/${ELASTICSEARCH_VERSION%.*}/debian stable main" > /etc/apt/sources.list.d/elasticsearch.list && \
    apt-get-min update && \
    apt-get-install-min elasticsearch=$ELASTICSEARCH_VERSION && \
    rm -rf /var/lib/apt/lists/*
