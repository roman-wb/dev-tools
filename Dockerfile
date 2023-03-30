FROM golang:1.20-alpine as build

RUN --mount=type=cache,target=/root/.cache \
    --mount=type=cache,target=/go/src \
    --mount=type=cache,target=/go/pkg \
    go install github.com/cosmtrek/air@v1.42.0 && \
    go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.51.2  && \
    go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28 && \
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2 && \
    go install github.com/vektra/mockery/v2@v2.20.0 && \
    go install github.com/deepmap/oapi-codegen/cmd/oapi-codegen@v1.12.4 && \
    go install github.com/pressly/goose/v3/cmd/goose@v3.10.0 && \
    cd /go/pkg/mod/github.com/ogen-go/ogen@v0.60.1 && go build -o /go/bin/ogen cmd/ogen/main.go

FROM alpine:latest

RUN --mount=type=cache,target=/var/cache/apk \
    apk update && apk upgrade && apk add git htop mc curl wget ncdu

COPY --from=build /go/bin /bin

COPY waiter.sh /bin

CMD ["waiter.sh"]
