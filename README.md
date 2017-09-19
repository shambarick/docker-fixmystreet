# Docker FixMyStreet

## Build

Build the database image

```
docker build -t local/fms-db:latest db
```

Build the app image

```
docker build -t local/fms-app:latest .
```

## Usage

```
docker run \
  --name fms-db \
  -e POSTGRES_DB=fms \
  -e POSTGRES_USER=fms \
  -e POSTGRES_PASSWORD=fms \
  fms-db:latest

docker run \
  --name fms-app \
  --link fms-db \
  -e DB_HOST=fms-db \
  -e DB_NAME=fms \
  -e DB_USER=fms \
  -e DB_PASSWORD=fms \
  fms-app:latest
```

