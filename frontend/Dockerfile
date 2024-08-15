# Stage 1: Build the Go frontend application
FROM golang:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the rest of the frontend source code
COPY ./app/ ./

# Build the frontend application
RUN go build -o frontend

# Expose the port that the frontend will run on
EXPOSE 8080

# Command to run the frontend binary with go run
CMD ["./frontend"]
