FROM golang:1.23 AS build

WORKDIR /app

COPY go.mod ./
COPY main.go ./
COPY templates ./templates

RUN CGO_ENABLED=0 go build -o bandname .

FROM scratch

WORKDIR /

COPY --from=build /app/bandname /bandname
COPY --from=build /app/templates /templates

EXPOSE 8080

ENTRYPOINT ["/bandname"]