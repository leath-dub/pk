# Simple package installer
This is a simple shell script that can be used to install
programs using github api

## Usage
```sh
pk pkgpath ./pkgs:./other-pkgs dest ~/bin add nvim
```
The above will search for `nvim.sh` in `./pkgs` and `./other-pkgs`
if it finds a unique instance it will install it to `~/bin`.
