#Paper Minecraft server

## Building

In root folder, run:

``` bash
podman build -t mc-paper
```

## Running

``` bash
MC_VERSION="1.21"
PAPER_BUILD="108"
EULA="true"
MC_RAM="8G"
WORLD_DIR="/home/user/mc_data"

podman run --name myworld -dt \
  -v ${WORLD_DIR}:/server:z \
  -e MC_VERSION=${MC_VERSION} \
  -e PAPER_BUILD=${PAPER_BUILD} \
  -e EULA=${EULA} \
  -e MC_RAM=${MC_RAM} \
  -p 25565:25565 -p 25575:25575 \
  mc-paper
```

