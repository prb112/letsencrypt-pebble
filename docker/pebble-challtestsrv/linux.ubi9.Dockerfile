FROM registry.access.redhat.com/ubi9/go-toolset:1.18 as builder

ENV CGO_ENABLED=0

WORKDIR /pebble-src
COPY . .

RUN go build -o /go/bin/pebble-challtestsrv ./cmd/pebble-challtestsrv

## main
FROM registry.access.redhat.com/ubi9-minimal:9.2

COPY --from=builder /go/bin/pebble-challtestsrv /usr/bin/pebble-challtestsrv

CMD [ "/usr/bin/pebble-challtestsrv" ]
