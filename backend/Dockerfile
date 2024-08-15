# Stage 1: Build the Go application
FROM golang:latest AS builder

# Set the working directory inside the builder container
WORKDIR /app

# Copy the source code into the container
COPY ./app/ ./

# Build the Go application
RUN go build -o backend

# Build the Go application with static linking
RUN CGO_ENABLED=0 GOOS=linux go build -a -o backend

# Stage 2: Create the minimal final image
FROM scratch

# Set the working directory inside the final container
WORKDIR /app

# Copy the Go binary from the builder stage
COPY --from=builder /app/backend /app/

# Expose the necessary port
EXPOSE 9000

# Command to run the Go binary
CMD ["./backend"]
