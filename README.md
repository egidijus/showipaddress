# showipaddress


## What?
one binary solution to see all IP addresses for:

* linux
* windows
* osx
* bsd
* arm64

## How?

download a release version or build your own with make

```make all```

### How to install latest version

### OSX

```
wget $(curl -sL https://api.github.com/repos/egidijus/showipaddress/releases/latest | jq -r '.assets[].browser_download_url' | grep -e darwin | grep amd64) -O ~/.local/bin/showipaddress
chmod +x ~/.local/bin/showipaddress
```

### Linux

```
wget $(curl -sL https://api.github.com/repos/egidijus/showipaddress/releases/latest | jq -r '.assets[].browser_download_url' | grep -e linux | grep amd64) -O ~/.local/bin/showipaddress
chmod +x ~/.local/bin/showipaddress
```

sample output

```
./build/linux-amd64/showipaddress
127.0.0.1
::1
192.168.1.14
172.30.0.1
172.22.0.1
172.27.0.1
192.168.49.1
```

