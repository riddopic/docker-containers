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

FROM       riddopic/nginx
MAINTAINER Stefano Harding <riddopic@gmail.com>

EXPOSE 5601
ADD https://download.elastic.co/kibana/kibana/kibana-4.0.2-linux-x64.tar.gz / \
    root /
RUN tar zxf /kibana-4.0.2-linux-x64.tar.gz -C /opt/ && \
    mv /opt/kibana-4.0.2-linux-x64/ /opt/kibana && \
    apk add --update nginx wget vim && \
    mv /opt/kibana.yml /opt/kibana/config/kibana.yml && \
    rm -rf /var/cache/apk/* /kibana-4.0.2-linux-x64.tar.gz
