# syntax=docker/dockerfile:1

# Base lightweight Python image
FROM python:3.11-

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PORT=8000

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
 && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
# Upgrade pip and install dependencies
RUN pip install --upgrade pip \
 && pip install -r requirements.txt

# Copy application code
COPY . .

# Expose application port
EXPOSE $PORT

# Run the app using Gunicorn
CMD ["gunicorn", "app:app", "--bind=0.0.0.0:8000"]
