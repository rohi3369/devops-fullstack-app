FROM  golang:1.19-alpine
WORKDIR /app
COPY . .
RUN go mod init employees
RUN go get ./... 
EXPOSE 8080
CMD ["/app/server"]

