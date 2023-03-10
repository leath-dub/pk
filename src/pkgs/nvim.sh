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
    json_response=`http_get $uris`
    download_url=`json_print "$json_response" | json_raw $gh_filter_downloads | grep ".*$uri$"`

    download_file=`temp_file tgz`
    http_get_download $download_url -o $download_file

    printf "%s %s %s" "$download_file" "$download_url" "$json_response"
}

# | select (.browser_download_url | contains("'$uri'")))'
installer() {
    uri="$1"
    download_url="$2"
    shift 2
    json_response="$@"
    mkdir -p $pkgdest/nvim/
    json_print "$json_response" \
        | jq '.assets[] | select(.browser_download_url=="'$download_url'")' \
        > $pkgdest/nvim/pk.json
    extract $uri | tar xvf - -C $pkgdest/nvim/
}
