#!/bin/bash
docker container stop postgresql
docker container stop phppgadmin
docker container rm postgresql
docker container rm phppgadmin
docker network rm red-operez
