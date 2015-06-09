
include includes.mk


CONTAINER = squid router alpine centos-6 centos-7 fedora-21 ubuntu-14.04 \
						nginx chef-server consul docker dockerui elasticsearch kibana \
						logstash seagull

START_ORDER = squid router

all: init build

dev-registry: check-docker
	@docker inspect registry >/dev/null 2>&1 && docker start registry || docker run --restart="always" -d -p 5000:5000 --name registry registry:0.9.1
	@echo
	@echo "To use the local registry for development:"
	@echo "    export DEV_REGISTRY=`docker-machine ip ip 2>/dev/null`:5000"

init: check-docker
	@$(foreach C, $(START_ORDER), $(MAKE) -C $(C) build &&) echo done
	@$(foreach C, $(START_ORDER), $(MAKE) -C $(C) run &&) echo done

build: check-docker
	@$(foreach C, $(CONTAINER), $(MAKE) -C $(C) build &&) echo done

clean:
	@$(foreach C, $(CONTAINER), $(MAKE) -C $(C) clean &&) echo done

full-clean:
	@$(foreach C, $(CONTAINER), $(MAKE) -C $(C) full-clean &&) echo done

start:
	@$(foreach C, $(START_ORDER), $(MAKE) -C $(C) start &&) echo done

stop:
	@$(foreach C, $(CONTAINER), $(MAKE) -C $(C) stop &&) echo done

restart: stop start

run: start

dev-release:
	@$(foreach C, $(CONTAINER), $(MAKE) -C $(C) dev-release &&) echo done

push:
	@$(foreach C, $(CONTAINER), $(MAKE) -C $(C) push &&) echo done

set-image:
	@$(foreach C, $(CONTAINER), $(MAKE) -C $(C) set-image &&) echo done

release: check-registry
	@$(foreach C, $(CONTAINER), $(MAKE) -C $(C) release &&) echo done

deploy: build dev-release restart

test:
