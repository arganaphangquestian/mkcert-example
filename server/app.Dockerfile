FROM golang:alpine AS builder
WORKDIR /server
COPY go.mod ./
COPY . .
RUN go mod download
RUN GO111MODULE=on go build -o /go/bin/app_server ./

FROM alpine:latest
WORKDIR /usr/bin
COPY --from=builder /go/bin/app_server .
EXPOSE 5000
CMD ["app_server"]