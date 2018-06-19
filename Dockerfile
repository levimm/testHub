# build stage
FROM golang:latest
WORKDIR /go/src/my/
RUN go get -u github.com/gin-gonic/gin
COPY *.go ./
RUN go build -o ginserver -v -ldflags "-linkmode external -extldflags -static"

# final stage
FROM alpine:latest
WORKDIR /app/
COPY --from=0 /go/src/my/ginserver .
COPY templates/* templates/
CMD ["./ginserver"]

