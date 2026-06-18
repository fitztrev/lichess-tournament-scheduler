FROM node:24-alpine AS frontend

WORKDIR /app/svelte
COPY svelte/package.json svelte/package-lock.json ./
RUN npm ci
COPY svelte/ ./
RUN npm run build

FROM python:3.14-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt uwsgi

COPY . .
COPY --from=frontend /app/svelte/public/ ./svelte/public/

RUN useradd --no-create-home appuser
USER appuser

EXPOSE 9091

CMD ["uwsgi", "--socket", "127.0.0.1:9091", "--wsgi-file", "app.py", "--callable", "app", "--enable-threads", "--master"]
