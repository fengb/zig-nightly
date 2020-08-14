# zig-nightly

### Docker

```bash
$ docker build . -t zig:latest
$ docker run -v "$PWD:/app" zig [args]
```

### Archlinux

```bash
$ sudo pacman -S jq
$ ./PKGBUILD-create.sh
$ makepkg -i
```
