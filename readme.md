# Simple package installer
This is a simple shell script that can be used to install
programs using github api

## Usage
```sh
pk pkgpath ./pkgs:./other-pkgs dest ~/bin add nvim
```
The above will search for `nvim.sh` in `./pkgs` and `./other-pkgs`
if it finds a unique instance it will install it to `~/bin`.

## How to add packages to path
You can add the following to your `.bashrc`, `.zshrc` or whatever
you shell rc is.
```sh
export pkgpath=<repo/src/pkgs>
export pkgdest=$HOME/bin
for dir in $(find $HOME/bin -type f -executable)
do
    case "$PATH" in
        *":$(dirname $dir):"*) ;;
        *) export PATH="${PATH}${PATH+:}${dir%/*}" ;;
    esac
done
```
This looks in `~/bin` for any executable recursively. If found the
directory it is in is added to the PATH
