#!/bin/bash

MC_VERSION="1.21"
PAPER_BUILD="44"
EULA="true"
MC_RAM="8G"

podman run --name mypapermc -dt \
  -v /home/jkelly/mc_data:/server:z \
  -e MC_VERSION=${MC_VERSION} \
  -e PAPER_BUILD=${PAPER_BUILD} \
  -e EULA=${EULA} \
  -e MC_RAM=${MC_RAM} \
  -p 25565:25565 -p 25575:25575 \
  papermc 
