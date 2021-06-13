FROM golang:1.16.5 as workspace
WORKDIR /go/src/github.com/testcontainers/moby-ryuk
COPY go.mod go.sum ./
RUN go mod download
COPY . ./
RUN make build

FROM alpine:3.13
RUN apk --no-cache add ca-certificates
COPY --from=workspace /go/src/github.com/testcontainers/moby-ryuk/bin/moby-ryuk /app
CMD ["/app"]
