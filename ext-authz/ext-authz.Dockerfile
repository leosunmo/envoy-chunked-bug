FROM golang:1.15 AS build
ADD . /src
RUN  cd /src && CGO_ENABLED=0 \
  GOOS=linux \
  GOARCH=amd64 \
  go build -o ext-authz

FROM alpine:3.11
WORKDIR /app
COPY --from=build /src/ext-authz /app/
ENTRYPOINT /app/ext-authz