IMAGE_NAME := reireireireireireireireirei/ports
IMAGE_VERSION := 1.0.1
SHELL := /bin/bash

.PHONY: all
all: amd64 arm64

.PHONY: amd64
amd64:
	docker buildx build -f Dockerfile.amd64 --platform linux/amd64 \
		-t $(IMAGE_NAME):$(IMAGE_VERSION)-amd64 .

.PHONY: arm64
arm64:
	docker buildx build -f Dockerfile.arm64 --platform linux/arm64 \
		-t $(IMAGE_NAME):$(IMAGE_VERSION)-arm64 .

.PHONY: push
push: amd64 arm64
	docker push $(IMAGE_NAME):$(IMAGE_VERSION)-amd64
	docker push $(IMAGE_NAME):$(IMAGE_VERSION)-arm64

	docker manifest create $(IMAGE_NAME):$(IMAGE_VERSION) \
		--amend $(IMAGE_NAME):$(IMAGE_VERSION)-amd64 \
		--amend $(IMAGE_NAME):$(IMAGE_VERSION)-arm64
	docker manifest push $(IMAGE_NAME):$(IMAGE_VERSION)
