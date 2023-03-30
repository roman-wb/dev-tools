#!/bin/sh

air -v
golangci-lint --version
protoc-gen-go --version
protoc-gen-go-grpc --version
mockery --version
oapi-codegen -version
goose -version

while :; do
    sleep 600
done
