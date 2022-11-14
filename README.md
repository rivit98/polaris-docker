# Polaris docker

Dockerfile for [polaris](https://github.com/agersant/polaris) app.

## Env variables

- `POLARIS_DB` - location of the database file (if you want to persist it, mount it using `-v` Docker option)
- `POLARIS_CACHE_DIR` - App cache directory (if you want to persist it, mount it using `-v` Docker option)

## Build image

```sh
docker build -t polaris .
```

## Run
```sh
docker run -it --name=polaris -p 5050:5050 -v /my/music/library:/music polaris
```

Access it: [http://localhost:5050/](http://localhost:5050/)
