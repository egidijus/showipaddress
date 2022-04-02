NAME := showipaddress
PACKAGE_NAME := github.com/egidijus/showipaddress
VERSION := $(shell git describe --tags || echo "unknown-version")
COMMIT := $(shell git rev-parse HEAD)
BUILDTIME := $(shell date -u "+%Y-%m-%d %H:%M:%S %Z")
BUILD_DIR := build
VAR_SETTING := -X "$(PACKAGE_NAME)/constant.Version=$(VERSION)" -X "$(PACKAGE_NAME)/constant.Commit=$(COMMIT)" -X "$(PACKAGE_NAME)/constant.BuildTime=$(BUILDTIME)"
GOBUILD = CGO_ENABLED=0 go build -trimpath -ldflags '-s -w -buildid= $(VAR_SETTING)' \
		-o $(BUILD_DIR)

PLATFORM_LIST = \
	darwin-amd64 \
	darwin-arm64 \
	linux-amd64 \
	linux-arm64 \
	windows-amd64 \
	windows-arm64
	

zip_release = $(addsuffix .zip, $(PLATFORM_LIST))


.PHONY: build clean release
normal: clean build

clean:
	@rm -rf $(BUILD_DIR)
	@echo "Cleaning up."

$(zip_release): %.zip : %
	@zip -du $(BUILD_DIR)/$(NAME)-$<-$(VERSION).zip -j -m $(BUILD_DIR)/$</$(NAME)*
	@zip -du $(BUILD_DIR)/$(NAME)-$<-$(VERSION).zip *.ini
	@echo "✅ $(NAME)-$<-$(VERSION).zip"

all: linux-amd64 darwin-amd64 windows-amd64 linux-arm64

all-arch: $(PLATFORM_LIST)

release: $(zip_release)

build:
	@-mkdir -p $(BUILD_DIR)
	$(GOBUILD)/$(NAME)

darwin-amd64:
	GOARCH=amd64 GOOS=darwin $(GOBUILD)/$(NAME)-$@

darwin-arm64:
	GOARCH=arm64 GOOS=darwin $(GOBUILD)/$(NAME)-$@

linux-386:
	GOARCH=386 GOOS=linux $(GOBUILD)/$(NAME)-$@

linux-amd64:
	GOARCH=amd64 GOOS=linux $(GOBUILD)/$(NAME)-$@

linux-arm:
	GOARCH=arm GOOS=linux $(GOBUILD)/$(NAME)-$@

linux-armv5:
	GOARCH=arm GOOS=linux GOARM=5 $(GOBUILD)/$(NAME)-$@

linux-armv6:
	GOARCH=arm GOOS=linux GOARM=6 $(GOBUILD)/$(NAME)-$@

linux-armv7:
	GOARCH=arm GOOS=linux GOARM=7 $(GOBUILD)/$(NAME)-$@

linux-arm64:
	GOARCH=arm64 GOOS=linux $(GOBUILD)/$(NAME)-$@

linux-mips-softfloat:
	GOARCH=mips GOMIPS=softfloat GOOS=linux $(GOBUILD)/$(NAME)-$@

linux-mips-hardfloat:
	GOARCH=mips GOMIPS=hardfloat GOOS=linux $(GOBUILD)/$(NAME)-$@

linux-mipsle-softfloat:
	GOARCH=mipsle GOMIPS=softfloat GOOS=linux $(GOBUILD)/$(NAME)-$@

linux-mipsle-hardfloat:
	GOARCH=mipsle GOMIPS=hardfloat GOOS=linux $(GOBUILD)/$(NAME)-$@

linux-mips64:
	GOARCH=mips64 GOOS=linux $(GOBUILD)/$(NAME)-$@

linux-mips64le:
	GOARCH=mips64le GOOS=linux $(GOBUILD)/$(NAME)-$@

freebsd-386:
	GOARCH=386 GOOS=freebsd $(GOBUILD)/$(NAME)-$@

freebsd-amd64:
	GOARCH=amd64 GOOS=freebsd $(GOBUILD)/$(NAME)-$@

freebsd-arm64:
	GOARCH=arm64 GOOS=freebsd $(GOBUILD)/$(NAME)-$@

windows-386:
	GOARCH=386 GOOS=windows $(GOBUILD)/$(NAME)-$@.exe

windows-amd64:
	GOARCH=amd64 GOOS=windows $(GOBUILD)/$(NAME)-$@.exe

windows-arm:
	GOARCH=arm GOOS=windows $(GOBUILD)/$(NAME)-$@.exe

windows-armv6:
	GOARCH=arm GOOS=windows GOARM=6 $(GOBUILD)/$(NAME)-$@.exe

windows-armv7:
	GOARCH=arm GOOS=windows GOARM=7 $(GOBUILD)/$(NAME)-$@.exe

windows-arm64:
	GOARCH=arm64 GOOS=windows $(GOBUILD)/$(NAME)-$@.exe



prep_new_golang:
	go mod init github.com/egidijus/showipaddress
	go mod tidy