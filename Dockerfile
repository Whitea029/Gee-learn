FROM golang:1.20 AS builder
LABEL authors="Whitea"

WORKDIR /app
COPY go.mod ./
COPY . .
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o myapp ./cmd/myapp
FROM gcr.io/distroless/base-debian10
COPY --from=builder /app/myapp /myapp
EXPOSE 8080
CMD ["/myapp"]