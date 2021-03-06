#!/bin/bash

# stop on errors
set -e

if [ "`id -nu`" != "root" ]; then
  echo "Must be called as root"
  exit 1
fi

PKG_MGR_FOUND=0
if which dnf 2>/dev/null >/dev/null; then
  PKG_MGR_FOUND=1
  FLAGS="-y"
  echo "Detected dnf package manager"

  dnf $FLAGS install git

  echo "################################"
  echo "## erforce"
  echo "################################"
  dnf $FLAGS install cmake protobuf-compiler qt5-devel luajit-devel gcc-c++

  echo "################################"
  echo "## tigers"
  echo "################################"
  dnf $FLAGS install java-1.8.0-openjdk-devel maven

  echo "################################"
  echo "## cmdragons"
  echo "################################"
  dnf $FLAGS install cmake protobuf-compiler wxBase3 wxGTK3-devel
fi

if which apt-get 2>/dev/null >/dev/null; then
  PKG_MGR_FOUND=1
  FLAGS="-qq -y"
  echo "Detected apt-get package manager"

  apt-get $FLAGS update
  apt-get $FLAGS install git

  echo "################################"
  echo "## erforce"
  echo "################################"
  apt-get $FLAGS install cmake protobuf-compiler qtbase5-dev libluajit-5.1-dev g++

  echo "################################"
  echo "## tigers"
  echo "################################"
  apt-get $FLAGS install openjdk-8-jdk maven

  echo "################################"
  echo "## cmdragons"
  echo "################################"
  apt-get $FLAGS install libwxbase3.0-dev libwxgtk3.0-dev cmake protobuf-compiler
fi

if which pacman 2>/dev/null >/dev/null; then
  PKG_MGR_FOUND=1
  FLAGS="--needed"
  echo "Detected Arch Linux (Pacman)"

  pacman -S $FLAGS git

  echo "################################"
  echo "## erforce"
  echo "################################"
  pacman -S $FLAGS cmake protobuf qt5-base luajit gcc

  echo "################################"
  echo "## tigers"
  echo "################################"
  pacman -S $FLAGS jdk8-openjdk maven

  echo "################################"
  echo "## cmdragons"
  echo "################################"
  pacman -S $FLAGS wxgtk-common cmake protobuf
fi

if [ $PKG_MGR_FOUND == 0 ]; then
  echo "Your distribution is not yet supported"
  exit 1
fi

