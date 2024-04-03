# Ports

## Build

```sh
git clone --recurse-submodules git@github.com:mvasilkov/ports.git
docker buildx build -t ports .
```

## Update ports

```sh
git submodule foreach 'git pull --rebase'
```
