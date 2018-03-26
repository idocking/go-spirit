FROM golang:1.9.4 as builder
WORKDIR /go/src/github.com/go-spirit
RUN go get -v github.com/go-spirit/go-spirit
RUN cd go-spirit && CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o go-spirit .

FROM alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /go/src/github.com/go-spirit/go-spirit/go-spirit .
CMD ["./go-spirit"]