#!/bin/bash

docker run --name rpg-db -e POSTGRES_PASSWORD=secret -e POSTGRES_DB=rpg_dev -e POSTGRES_USER=rpg -d -p 5432:5432 --rm postgres