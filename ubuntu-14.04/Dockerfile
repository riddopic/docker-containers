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

FROM       ubuntu:14.04
MAINTAINER Stefano Harding <riddopic@gmail.com>

ENV INITRD=no GOMAXPROCS=2 DEBIAN_FRONTEND=noninteractive
RUN useradd -c 'Test Kitchen' -d /home/kitchen -m kitchen -s /bin/bash
ADD https://dl.bintray.com/mitchellh/serf/0.6.4_linux_amd64.zip / \
    https://dl.bintray.com/mitchellh/consul/0.5.2_linux_amd64.zip / \
    https://github.com/just-containers/s6-overlay/releases/download/v1.10.0.3/s6-overlay-amd64.tar.gz / \
    root /
    # Add MudBox keys and insure exec permission to utils.
RUN apt-key add /etc/apt/mudbox.key && rm -f /etc/apt/mudbox.key              ;\
    apt-key add /etc/apt/gpg.key    && rm -f /etc/apt/gpg.key                 ;\
    chmod +x /usr/bin/apt-cleanup                                              \
             /usr/bin/apt-dpkg-wrapper                                         \
             /usr/bin/apt-get-install                                         ;\
    ls /usr/bin/apt* /usr/bin/dpkg* |                                          \
    while read line; do                                                        \
      min=$line-min                                                           ;\
      printf '#!/bin/sh\n/usr/bin/apt-dpkg-wrapper '$line' $@\n' > $min       ;\
      chmod +x $min                                                           ;\
    done                                                                      ;\
    if [ ! -e /etc/dpkg/dpkg.cfg.d/docker-apt-speedup ]; then                  \
      echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/docker-apt-speedup          ;\
    fi                                                                        ;\
    #
    # Enable Ubuntu Universe and Multiverse repos.
    #
    sed -i 's/^#\s*\(deb.*universe\)$/\1/g' /etc/apt/sources.list             ;\
    sed -i 's/^#\s*\(deb.*multiverse\)$/\1/g' /etc/apt/sources.list           ;\
    apt-get-min update                                                        ;\
    #
    # Handle issue with APT packages and replace `ischroot` to return true which
    # should prevents initscripts updates from breaking /dev/shm.
    #
    dpkg-divert-min --local --rename --add /sbin/initctl                      ;\
    ln -sf /bin/true /sbin/initctl                                            ;\
    dpkg-divert-min --local --rename --add /usr/bin/ischroot                  ;\
    ln -sf /bin/true /usr/bin/ischroot                                        ;\
    apt-get-install-min software-properties-common apt-transport-https         \
    openssl ca-certificates cron curl rsync logrotate gettext-base sudo        \
    openssh-server curl lsb-release unzip rsyslog rsyslog-relp                ;\
    apt-get-min dist-upgrade -y --no-install-recommends                       ;\
    #
    # Set locale to Америка.
    #
    apt-get-install-min language-pack-en                                      ;\
    locale-gen en_US                                                          ;\
    update-locale LANG=en_US.UTF-8 LC_CTYPE=en_US.UTF-8                       ;\
    #
    # s6 Overlay
    #
    tar xvfz /s6-overlay-amd64.tar.gz -C /                                    ;\
    rm /s6-overlay-amd64.tar.gz                                               ;\
    #
    # Setup Chef Client
    #
    apt-get-min update                                                        ;\
    apt-get-install-min chef                                                  ;\
    /opt/chef/embedded/bin/gem install pry awesome_print                      ;\
    echo kitchen:kitchen | chpasswd                                           ;\
    echo 'kitchen ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers                     ;\
    echo 'kitchen ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/kitchen           ;\
    #
    # Setup Consul agent
    #
    mkdir /data                                                               ;\
    useradd -r -c 'Consul' -s /sbin/nologin consul                            ;\
    unzip -o /0.5.2_linux_amd64.zip -d /usr/sbin/                             ;\
    rm -f    /0.5.2_linux_amd64.zip                                           ;\
    chown root:consul /usr/sbin/consul                                        ;\
    chmod 750         /usr/sbin/consul                                        ;\
    chown root:consul /etc/consul                                             ;\
    chmod 750         /etc/consul                                             ;\
    chown -R consul:  /data                                                   ;\
    chmod 750         /data                                                   ;\
    #
    # Setup Serf agent
    #
    useradd -r -c 'Serf' -s /sbin/nologin serf                                ;\
    unzip -o /0.6.4_linux_amd64.zip -d /usr/sbin/                             ;\
    rm -f    /0.6.4_linux_amd64.zip                                           ;\
    chown root:serf /usr/sbin/serf                                            ;\
    chmod 750       /usr/sbin/serf                                            ;\
    chown root:serf /etc/serf                                                 ;\
    chmod 750       /etc/serf                                                 ;\
    #
    # Logstash
    #
    mkdir -p /etc/logstash/ssl                                                ;\
    sed -i -e 's/keep 4/keep 1/' -e 's/rotate 4/rotate 1/' /etc/logrotate.conf;\
    #
    # Add SSH Keys
    #
    chown -R root ~root/.ssh                                                  ;\
    chmod -R go-rwsx ~root/.ssh                                               ;\
    chown -R kitchen ~kitchen/.ssh                                            ;\
    chmod -R go-rwsx ~kitchen/.ssh                                            ;\
    apt-get-min clean                                                         ;\
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* /var/cache/apt/archives/*

ENTRYPOINT ["/init"]

CMD []
