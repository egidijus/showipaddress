#! /bin/sh

GOOS=linux go build -o $2 "$1"
ls -l $2*
