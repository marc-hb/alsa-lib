#!/bin/sh

set -e

die()
{
    printf 'ERROR: '
    printf "$@"
    exit 1
}

main()
{
    if ls ../liba*.deb; then
        die '%s\n' 'some ../liba*.deb already exist'
    fi

    set -x
    # Dependencies for any debuild
    sudo apt install devscripts

    # Dependencies for building alsa-lib
    sudo apt install debhelper-compat python3-dev:native libpython3-dev \
         doxygen graphviz

    time debuild -b -us -uc -i -I

    cat <<EOF

SUCCESSFULLY BUILT ../*.deb alsa packages

To install locally all packages listed in file ../alsa-lib*.changes:

   sudo debi

To clean:

   ./debian/rules clean

EOF
}


main "$@"
