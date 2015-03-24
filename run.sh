#! /bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

export GOPATH=$DIR/_vendor:$DIR

go get all
docker build -t httpserver $DIR

## Remove unused images
docker rmi $(docker images -f 'dangling=true' -q) &> /dev/null &

id=$(docker run -d --publish 3000:3000 httpserver)

function cleanup() {
	echo "Cleanup..."

	docker kill $id &> /dev/null
	docker wait $id &> /dev/null
	docker rm $id &> /dev/null
	exit 0
}

trap cleanup EXIT

docker logs $id
docker attach --sig-proxy=false $id 
