FROM node:24-alpine AS frontend

WORKDIR /app/svelte
COPY svelte/package.json svelte/package-lock.json ./
RUN npm ci
COPY svelte/ ./
RUN npm run build

FROM python:3.14-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential vim sqlite3 && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt uwsgi

COPY . .
COPY --from=frontend /app/svelte/public/ ./svelte/public/

RUN useradd --no-create-home appuser
USER appuser

CMD ["uwsgi", "--http-socket", "0.0.0.0:9091", "--wsgi-file", "app.py", "--callable", "app", "--enable-threads", "--master", "--lazy-apps"]
