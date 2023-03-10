#!/bin/sh

filter_shasums() {
    grep -v '.*.sha[0-9]*sum'
}

default_uri="nvim-linux64.tar.gz"

uris="`gh_api_url neovim/neovim`/${tag:-latest}"
show_releases() {
    http_get $uris \
        | json_raw $gh_filter_downloads \
        | filter_shasums \
        | sed 's/.*\///g'
}

fetch() {
    : ${uri:=${default_uri}}
    download_url=`http_get $uris \
        | json_raw $gh_filter_downloads \
        | grep ".*$uri$"`

    download_file=`temp_file tgz`
    http_get_download $download_url -o $download_file

    echo $download_file
}

installer() {
    uri="$@"
    extract $uri | tar xvf - -C $pkgdest
}
