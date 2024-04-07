# Ports

## Build

```sh
git clone --recurse-submodules git@github.com:mvasilkov/ports.git
docker buildx build -f Dockerfile.arm64 --platform linux/arm64 -t ports .
```

## Update ports

```sh
git submodule foreach 'git pull --rebase'
```
