FROM  golang:1.19-alpine
WORKDIR /app
COPY . .
RUN go mod download
RUN go get ./... 
EXPOSE 8080
ENTRYPOINT ["go","run","main.go"]

