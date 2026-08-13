FROM golang:1.21 AS builder
WORKDIR /app
COPY . /app
RUN cd /app && CGO_ENABLED=0 go build -o frontend
FROM alpine:3.18
WORKDIR /app
COPY --from=builder /app/frontend .
ENTRYPOINT ["./frontend"]