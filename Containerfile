FROM alpine:latest

RUN apk update \
    && apk add openjdk21-jre \
    && apk add bash \
    && apk add wget \
    && apk add jq \
    && mkdir /papermc \
    && mkdir /server

ARG MC_VER="1.21" \
    PAPER_VER="44"

ARG JARNAME="paper-${MC_VER}-${PAPER_VER}.jar"

# Environment variables
ENV MC_VERSION=${MC_VER} \
    PAPER_BUILD=${PAPER_VER} \
    JAR_NAME="paper-${MC_VER}-${PAPER_VER}.jar" \
    URL="https://api.papermc.io/v2/projects/paper/versions/${MC_VER}/builds/${PAPER_VER}/downloads/" \
    EULA="false" \
    MC_RAM="" \
    JAVA_OPTS=""

RUN wget "${URL}${JARNAME}" -O "/papermc/${JARNAME}"

COPY papermc.sh .

# Start script
CMD ["bash", "./papermc.sh"]

# Container setup
EXPOSE 25565/tcp
EXPOSE 25565/udp
VOLUME /server
