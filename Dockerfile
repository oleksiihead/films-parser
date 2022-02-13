FROM golang:1.16.5
WORKDIR /go/src/github.com/oleksiihead/films-parser
COPY main.go go.mod .
RUN go get -v
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app main.go

FROM alpine:latest

RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=0 /go/src/github.com/oleksiihead/films-parser/app .
CMD ["./app"]
