BUILD_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/build"

function get_repository {
    location=$1
    destination=$2
    url="https://api.github.com/repos/$location/tarball/master"
    echo "Downloading and extracting from $url to $destination"

    rm -rf $destination
    mkdir -p $destination

    download_location=$(mktemp)
    curl -L $url -o $download_location
    tar -xzf $download_location -C $destination
    rm $download_location
}

function main {
    get_repository "ghdl/ghdl" "$BUILD_DIR/ghdl"
    get_repository "ghdl/ghdl-language-server" "$BUILD_DIR/ghdl-language-server"
}

main
