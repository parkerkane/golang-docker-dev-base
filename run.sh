export GOPATH=`pwd`/_vendor:`pwd`

go get all
docker build -t remotego .
docker run --rm -ti --publish 3000:3000 --name test remotego
