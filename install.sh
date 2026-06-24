#!/bin/bash

echo "=============Begin Installation =============="

linkdot() {
    rc="$PWD/$1"
    # we only support the files in the first child dir as dotfiles
    rcshort=$(awk -v col="$2" -F / '{print $col}' <(ls -Ad $rc))
    if [[ ${rcshort:0:1} = '.' ]]
    then
        rcshort="$HOME/$rcshort"
    else
        rcshort="$HOME/.$rcshort"
    fi
    echo "linking $rc as $rcshort"
    # check if file exists and then delete
    if [[ -f $rcshort || -d $rcshort ]]
    then
        # recurse as we support directories
        rm -r $rcshort
    fi
    ln -s $rc $rcshort
    unset rcshort
    unset rc
}

for rc in */*
do
    linkdot $rc 6
done
unset rc

for dotdir in */.*;
do
    linkdot $dotdir 6
done
unset dotdir

echo "=============Installation Complete==========="
