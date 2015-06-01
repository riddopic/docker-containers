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

FROM       fedora:21
MAINTAINER Stefano Harding <riddopic@gmail.com>

ENV GOMAXPROCS=2
RUN useradd -c 'Test Kitchen' -d /home/kitchen -m kitchen -s /bin/bash
ADD https://dl.bintray.com/mitchellh/serf/0.6.4_linux_amd64.zip / \
    https://dl.bintray.com/mitchellh/consul/0.5.2_linux_amd64.zip / \
    https://github.com/just-containers/s6-overlay/releases/download/v1.10.0.3/s6-overlay-amd64.tar.gz / \
    root /
RUN rm -f /etc/yum.repos.d/fedora-updates*.repo                               ;\
    yum -y update                                                             ;\
    # Yum updates can update the repos, so we double dip as a follow on.
    rm -f /etc/yum.repos.d/fedora-updates*.repo                               ;\
    yum -y install deltarpm yum-utils tar unzip sudo cronie rsync logrotate    \
    rsyslog rsyslog-relp                                                      ;\
    #
    # Create Kitchen user
    #
    echo kitchen:kitchen | chpasswd                                           ;\
    echo 'kitchen ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers                     ;\
    echo 'kitchen ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/kitchen           ;\
    #
    # s6 Overlay
    #
    tar xvfz /s6-overlay-amd64.tar.gz -C /                                    ;\
    rm /s6-overlay-amd64.tar.gz                                               ;\
    #
    # Setup Chef Client
    #
    yum -y install chef which curl openssh-server openssh-clients             ;\
    /opt/chef/embedded/bin/gem install pry awesome_print                      ;\
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
    yum clean all                                                             ;\
    rm -rf /tmp/* /var/tmp/* /var/cache/*

ENTRYPOINT ["/init"]

CMD []
