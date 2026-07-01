FROM golang:1.22 as builder

WORKDIR /build

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /app

FROM scratch

COPY --from=builder /app /app
COPY tracker.db /tracker.db

CMD ["/app"]