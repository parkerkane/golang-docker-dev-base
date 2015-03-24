#! /bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

export GOPATH=$DIR/_vendor:$DIR

go get all
docker build -t remotego $DIR
docker run --rm -ti --publish 3000:3000 --name test remotego
