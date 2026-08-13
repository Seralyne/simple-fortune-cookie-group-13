FROM golang:1.21 AS builder
WORKDIR /app
COPY . /app
RUN cd /app && CGO_ENABLED=0 go build -o backend
FROM alpine:3.18
WORKDIR /app
COPY --from=builder /app/backend .
ENTRYPOINT ["./backend"]