FROM golang

ADD _vendor /go
ADD src /go/src

RUN go install all

ENTRYPOINT /go/bin/server

EXPOSE 3000