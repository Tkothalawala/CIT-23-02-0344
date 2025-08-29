FROM python:3.11-slim

# Avoid interactive prompts
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app
COPY app.py /app

# Install dependencies
RUN pip install --no-cache-dir flask psycopg2-binary

EXPOSE 5000
CMD ["python", "app.py"]
