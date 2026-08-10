FROM golang:1.25-alpine AS builder

WORKDIR /app
COPY ./ ./

ENV CGO_ENABLED=0
ENV GOOS=linux
RUN go build -o smtprelay

FROM alpine:3.24

WORKDIR /root/

COPY --from=builder /app/smtprelay  .
COPY --from=builder /app/smtprelay.ini /etc/smtprelay/

CMD ["./smtprelay", "--config=/etc/smtprelay/smtprelay.ini"]
