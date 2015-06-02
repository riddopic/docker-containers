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

.PHONY: build push shell run start stop rm release clean

REPO     ?= acme
NAME     ?= fedora-21
VERSION  ?= 21
INSTANCE ?= AncientPaper
PORTS    ?=
ENV      ?=

help:
	@echo "\n\033[0;35mContainer management for:\033[0m\n" \
	      "Repository: [\033[0;33m$(REPO)\033[0m]\n" \
	      "Name:       [\033[0;33m$(NAME)\033[0m]\n" \
	      "Version:    [\033[0;33m$(VERSION)\033[0m]\n"
	@echo "\033[0;35mUsage:\033[0m \n\n\
  make build     Build a new [$red$(NAME)$normal] image from a Dockerfile. \n\
  make tag       Tag an image into a repository. \n\
  make push      Push image to the registry. \n\
  make shell   	 Run container in the foreground with an interactive shell. \n\
  make run       Run the container and attach the console (foreground). \n\
  make start     Start the container in the background (detached). \n\
  make stop      Gracefully stop a running container. \n\
  make rm        Remove the container. \n\
  make release   Create tag, build and push an image to the registry. \n\
  make clean     Remove untagged images. \n\
"

all: build tag

build:
	@echo "\n\033[0;35mBuilding $(NAME) container from Dockerfile:\033[0m\n" \
	      "Repository: [\033[0;33m$(REPO)\033[0m]\n" \
	      "Name:       [\033[0;33m$(NAME)\033[0m]\n" \
	      "Version:    [\033[0;33m$(VERSION)\033[0m]\n"
	docker build -t $(REPO)/$(NAME):$(VERSION) .

tag:
	docker tag -f $(REPO)/$(NAME):$(VERSION) $(REPO)/$(NAME):latest

push:
	docker push $(REPO)/$(NAME):$(VERSION)

shell:
	docker run --rm --name $(INSTANCE) -it $(REPO)/$(NAME):$(VERSION) /bin/bash

run:
	docker run --rm --name $(INSTANCE) $(PORTS) $(ENV) $(REPO)/$(NAME):$(VERSION)

start:
	docker run -d --name $(INSTANCE) $(PORTS) $(ENV) $(REPO)/$(NAME):$(VERSION)

stop:
	docker stop $$(INSTANCE)

rm:
	docker rm $(INSTANCE)

release: build
	make push -e version=$(VERSION)

clean:
	docker rmi -f $$(docker images -q --filter 'dangling=true')
	docker rmi -f $(REPO)/$(NAME):$(VERSION)
	docker rmi -f $(REPO)/$(NAME):latest
