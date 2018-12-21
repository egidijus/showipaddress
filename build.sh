#! /bin/bash

set -ex
GOOS=linux go build -o $2 "${1:-showipaddress}-linux"
GOOS=darwin go build -o $2 "${1:-showipaddress}-darwin"

ls -l $2*
md5sum "showipaddress-linux"
md5sum "showipaddress-darwin"
