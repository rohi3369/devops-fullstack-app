FROM  golang:1.19-alpine
WORKDIR /app
COPY . .
RUN go build -o server .
EXPOSE 8080
CMD ["/app/server"]

