FROM golang:1.16.5 as build
WORKDIR /go/src/github.com/oleksiihead/films-parser
COPY main.go go.mod ./
RUN go get -v \
    && CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app main.go

FROM alpine:latest
LABEL maintainer="oleksiihead"
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=build /go/src/github.com/oleksiihead/films-parser/app .
CMD ["./app"]
