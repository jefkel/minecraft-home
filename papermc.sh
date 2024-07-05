#!/bin/bash

# Enter server directory
cd server

# Set nullstrings back to 'latest'
: ${MC_VERSION:='latest'}
: ${PAPER_BUILD:='latest'}

# Lowercase these to avoid 404 errors on wget
MC_VERSION="${MC_VERSION,,}"
PAPER_BUILD="${PAPER_BUILD,,}"

# Get version information and build download URL and jar name
URL='https://papermc.io/api/v2/projects/paper'
if [[ $MC_VERSION == latest ]]
then
  # Get the latest MC version
  MC_VERSION=$(wget -qO - "$URL" | jq -r '.versions[-1]') # "-r" is needed because the output has quotes otherwise
fi
URL="${URL}/versions/${MC_VERSION}"
if [[ $PAPER_BUILD == latest ]]
then
  # Get the latest build
  PAPER_BUILD=$(wget -qO - "$URL" | jq '.builds[-1]')
fi
JAR_NAME="paper-${MC_VERSION}-${PAPER_BUILD}.jar"
URL="${URL}/builds/${PAPER_BUILD}/downloads/${JAR_NAME}"

echo "Using ${JAR_NAME} for server, starting ..."
# Update eula.txt with current setting
echo "eula=${EULA:-false}" > eula.txt

exec java -Xms${MC_RAM} -Xmx${MC_RAM} \
          -XX:+AlwaysPreTouch \
          -XX:+DisableExplicitGC \
          -XX:+ParallelRefProcEnabled \
          -XX:+PerfDisableSharedMem \
          -XX:+UnlockExperimentalVMOptions \
          -XX:+UseG1GC \
          -XX:G1HeapRegionSize=8M \
          -XX:G1HeapWastePercent=5 \
          -XX:G1MaxNewSizePercent=40 \
          -XX:G1MixedGCCountTarget=4 \
          -XX:G1MixedGCLiveThresholdPercent=90 \
          -XX:G1NewSizePercent=30 \
          -XX:G1RSetUpdatingPauseTimePercent=5 \
          -XX:G1ReservePercent=20 \
          -XX:InitiatingHeapOccupancyPercent=15 \
          -XX:MaxGCPauseMillis=200 \
          -XX:MaxTenuringThreshold=1 \
          -XX:SurvivorRatio=32 \
          -Dusing.aikars.flags=https://mcflags.emc.gs \
          -Daikars.new.flags=true \
          -jar ../papermc/${JAR_NAME} nogui

