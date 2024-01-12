FROM registry.access.redhat.com/ubi9/go-toolset:1.18 as builder

ENV CGO_ENABLED=0

WORKDIR /pebble-src
COPY . .

RUN go build -o /go/bin/pebble ./cmd/pebble

## main
FROM registry.access.redhat.com/ubi9-minimal:9.2

COPY --from=builder /go/bin/pebble /usr/bin/pebble
COPY --from=builder /pebble-src/test/ /test/

CMD [ "/usr/bin/pebble" ]

EXPOSE 14000
EXPOSE 15000
