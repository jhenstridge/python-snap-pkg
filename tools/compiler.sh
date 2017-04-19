#!/bin/sh

# dpkg-architecture will try to execute $CC, so make sure we don't end
# up re-calling our script.
export CC=gcc

get_target() {
    while [ $# -gt 1 ]; do
        case "$1" in
            -o)
                echo "$2"
                return
                ;;
        esac
        shift
    done
}

target="$(get_target "$@")"
target="$(basename "$target")"

triplet=$(dpkg-architecture -q DEB_TARGET_MULTIARCH)

rpath=""
case "$target" in
    python*)
        rpath="\$ORIGIN/../lib:\$ORIGIN/../lib/$triplet:\$ORIGIN/../usr/lib/$triplet"
        ;;
    libpython*)
        rpath="\$ORIGIN:\$ORIGIN/$triplet:\$ORIGIN/../usr/lib/$triplet"
        ;;
    *.so)
        rpath="\$ORIGIN/../..:\$ORIGIN/../../$triplet:\$ORIGIN/../../../usr/lib/$triplet"
        ;;
esac

if [ -n "$rpath" ]; then
    exec $CC "$@" -Wl,-rpath,"$rpath"
fi

# Fall back to executing gcc as is
exec $CC "$@"
