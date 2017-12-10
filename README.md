# Docker Cisco lab

A Docker image based GNS3 lab for Cisco IOS/IOU

## Features

1. Support IOU (with iouyap)
1. Support IOS (with dynamips)
1. Support VPCS
1. Support Common Switch (with ubridge)
1. No VM Required (high performance)
1. Work with Linux/macOS/Windows (tested in macOS)
1. Support for GNS3 GUI Client 2.1.0

## Usage

pull the docker image

```shell
$ docker pull jeffctor/cisco-lab
```

expose server port (3080 inside container) and console port (5000 - 10000 inside container, you can just expose some of them) for client access

```shell
$ docker run --name lab -d -p 3080:3080 -p 5000-5100:5000-5100 cisco-lab
```

open your GNS3-GUI client go to __Preference__ -> __Server__

inside the __Main Server__ window, leave the `Enable Local Server` unchecked and fill the fields in consistent with your docker run command.

e.g. according to the run command above:

```conf
Host: localhost
Port: 3080 TCP
```

Okay, now you are ready to go (just in a GNS3 way).

## Notice

### Windows users

If you are using windows as the host platform

## Build

### Prerequisite

1. Docker 1.10+
1. make (optional, for easy build steps)
1. git (optional, for repo download)

### Steps

0. clone this repo (or download zip file)

```bash
$ git clone github.com/jeffreystoke/cisco-lab
```

1. Extract 32bit lib from a debian container

```bash
$ make prepare

# or without make
# docker run --rm --tty --volume `pwd`/bin:/base debian:jessie sh /base/fetchlibc.sh
```

2. make cisco-lab docker image

```bash
$ make image

# or without make
# $ docker build -t cisco-lab:latest .
```

Depending on your network status, this may take several minutes, and then you are good to go
