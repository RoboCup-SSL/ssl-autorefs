#!/bin/bash

if [ "$1" == "-c" ] || [ "$1" == "--continue" ]; then
  set +e
else
  set -e
fi

echo "######################################"
echo "## Build ERforce"
echo "######################################"
cd erforce
git submodule update --init
mkdir -p build
cd build
cmake ..
make
cd ../..


echo "######################################"
echo "## Build CMDragons"
echo "######################################"
cd cmdragons
mkdir -p build
cd build
cmake ..
make
cd ../..


echo "######################################"
echo "## Build TIGERs"
echo "######################################"
cd tigers
mvn install -DskipTests -Dmaven.javadoc.skip=true
cd ..
