# Stage 1: Build the Go frontend application
FROM golang:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the rest of the frontend source code
COPY ./app/ ./

# Build the frontend application
RUN go build -o backend

EXPOSE 9000

# Command to run the frontend binary with go run
CMD ["./backend"]
