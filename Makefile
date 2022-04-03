.PHONY: * setup
.SILENT:
SHELL := /bin/bash

RED="\033[0;31m"
BLUE="\033[0;32m"
GREEN="\033[0;33m"
BLUE="\033[0;34m"
LBLUE="\033[1;34m"
NC="\033[0m" # No Color
NL=${NC}

arg = $(filter-out $@,$(MAKECMDGOALS))

help:           ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e s/\\$$// | sed -e s/##//

all:		## Initial setup for the container
	make build
	-make kill
	make run
	make shell

build:		## Initial setup for the container
	docker build -t sysenv .

run:		## Run container
	docker run -it -d --name sysenv sysenv

log:		## Run container
	docker logs sysenv

kill:		## Kill containers
	-docker kill sysenv
	-docker rm sysenv

shell:		## Enter the container shell
	docker exec -it sysenv /bin/bash

