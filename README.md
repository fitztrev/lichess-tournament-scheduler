## Server setup

1. `devenv shell`
2. `cp config/config.example.py config/config.py` and fill out the values

## Frontend setup

1. `devenv shell`
2. `cd svelte`
3. `cp src/config.example.ts src/config.ts` and fill out the values
4. Create production build: `npm run build`. Output is in `svelte/public`

## Dev

- Dev server: `FLASK_ENV=development flask run --no-reload` (reloading would create multiple scheduler threads)
- Python type checking: `pyright` (install with `pip install pyright`)
- Svelte dev: `cd svelte; npm run dev`

### Test Docker build locally

```bash
docker build . -t lichess-tournament-scheduler

docker run --rm -it lichess-tournament-scheduler
```

## License

All the code in this repository is in the public domain. Or if you prefer, you may also use it under the [MIT license](LICENSE-MIT) or [CC0 license](LICENSE-CC0).
