FROM golang:1.27-alpine AS builder

WORKDIR /app
COPY ./ ./

ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64
RUN go build -buildvcs=false -ldflags "-w -s" -o smtprelay

FROM alpine:3

WORKDIR /root/

COPY --from=builder /app/smtprelay  .
COPY --from=builder /app/smtprelay.ini /etc/smtprelay/

CMD ["./smtprelay", "--config=/etc/smtprelay/smtprelay.ini"]
