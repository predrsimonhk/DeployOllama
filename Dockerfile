# Use an official Python image as a base (modify this to your needs)
FROM python:3.10-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Docker inside the container (so you can use docker-compose)
RUN curl -fsSL https://get.docker.com | sh

# Set up a working directory
WORKDIR /app

# Copy the Docker Compose file to the container
COPY docker-compose.yml /app/docker-compose.yml

# Install Docker Compose
RUN curl -L "https://github.com/docker/compose/releases/download/v2.1.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# Expose port 11434 for Ollama
EXPOSE 11434

# Start Ollama server
CMD ["docker-compose", "up", "-d"]

# Start the Llama 3 model
RUN docker exec -it ollama ollama run llama3
