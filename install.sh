#!/bin/bash

echo "=============Begin Installation =============="

linkdot() {
    rc="$PWD/$1"
    # we only support the files in the first child dir as dotfiles
    rcshort=$(awk -v col="$2" -F / '{print $col}' <(ls -Ad "$rc"))
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
        rm -r "$rcshort"
    fi
    ln -s "$rc" "$rcshort"
    unset rcshort
    unset rc
}

for rc in */*
do
    # claude/ goes into ~/.claude, handled below
    [[ $rc == claude/* ]] && continue
    linkdot "$rc" 6
done
unset rc

for dotdir in */.*;
do
    linkdot "$dotdir" 6
done
unset dotdir

# link individual files into ~/.claude (never replace the dir itself,
# it holds credentials and session state)
mkdir -p "$HOME/.claude"
for rc in claude/* claude/*/*
do
    target="$HOME/.claude/${rc#claude/}"
    # top-level dirs (agents/, commands/, skills/, hooks/) are created for real
    # and their entries linked, so anything already in them is left alone
    if [[ -d $rc && $rc != claude/*/* ]]
    then
        mkdir -p "$target"
        continue
    fi
    # never replace a real dir, e.g. a skill created outside the repo
    if [[ -d $target && ! -L $target ]]
    then
        echo "skipping $target: real directory exists"
        continue
    fi
    echo "linking $PWD/$rc as $target"
    ln -sfn "$PWD/$rc" "$target"
done
unset rc target

echo "=============Installation Complete==========="
