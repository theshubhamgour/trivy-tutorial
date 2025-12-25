FROM python:3.10-slim

# ❌ BAD PRACTICE – secrets in Dockerfile
ENV DB_PASSWORD=HardcodedDockerPassword123
ENV API_TOKEN=token_abcdef123456789

COPY app.py /app/app.py
CMD ["python", "/app/app.py"]
