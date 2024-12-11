# Start from the official Go image
FROM golang:1.20 as builder

# Set the working directory
WORKDIR /app

# Copy the source code
COPY . .

# Build the application
RUN go build -o main .

# Start from a minimal base image for the final build
FROM debian:bullseye-slim

# Set the working directory
WORKDIR /app

# Copy the binary from the builder stage
COPY --from=builder /app/main .

# Expose the port
EXPOSE 8080

# Run the application
CMD ["./main"]
