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

.PHONY: all alpine default centos-6 centos-7 ubuntu

default: all

all: alpine centos chef-server consul docker  fedora kibana \
	    nginx seagull squid ubuntu

alpine:
	$(MAKE) -C alpine build tag

centos:
	$(MAKE) -C centos-6 build tag
	$(MAKE) -C centos-7 build tag

chef-server: ubuntu
	$(MAKE) -C chef-server build tag

consul: alpine
	$(MAKE) -C consul build tag

docker: ubuntu
	$(MAKE) -C docker build tag

elasticsearch: ubuntu
	$(MAKE) -C elasticsearch build tag

fedora:
	$(MAKE) -C fedora-21 build tag

kibana: alpine nginx
	$(MAKE) -C kibana build tag

logstash: ubuntu
	$(MAKE) -C logstash build tag

nginx: alpine
	$(MAKE) -C nginx build tag

seagull: alpine
	$(MAKE) -C seagull build tag

squid: alpine
	$(MAKE) -C squid build tag

ubuntu:
	$(MAKE) -C ubuntu-14.04 build tag

clean: clean-alpine clean-centos clean-chef-server clean-consul clean-docker \
			 clean-elasticsearch clean-fedora clean-kibana clean-logstash \
			 clean-nginx clean-seagull clean-squid clean-ubuntu

clean-alpine:
	$(MAKE) -C alpine clean

clean-centos:
	$(MAKE) -C centos-6 clean
	$(MAKE) -C centos-7 clean

clean-chef-server:
	$(MAKE) -C chef-server clean

clean-consul:
	$(MAKE) -C consul clean

clean-docker:
	$(MAKE) -C docker clean

clean-elasticsearch:
	$(MAKE) -C elasticsearch clean

clean-fedora:
	$(MAKE) -C fedora-21 clean

clean-kibana:
	$(MAKE) -C kibana clean

clean-logstash:
	$(MAKE) -C logstash clean

clean-nginx:
	$(MAKE) -C nginx clean

clean-seagull:
	$(MAKE) -C seagull clean

clean-squid:
	$(MAKE) -C squid clean

clean-ubuntu:
	$(MAKE) -C ubuntu-14.04 clean
