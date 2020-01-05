#!/bin/bash

NOTESDIR=~/Notes
COMPILEDNOTESDIR=~/Compiled\ Notes

FONTSDIR=~/.notes_data/

if [[ $EUID -ne 0 ]]; then
    echo "this script should run as root"
    exit 1
fi

if [[ ! -e $NOTESDIR ]]; then
    mkdir $NOTESDIR
fi

if [[ ! -e $COMPILEDNOTESDIR ]]; then
    mkdir $COMPILEDNOTESDIR
fi

if [[ ! -e $FONTSDIR ]]; then
    mkdir $FONTSDIR
fi

cp notes_app/notes.sh /bin/notes
chmod +x /bin/notes

cp fonts/font.tex $FONTSDIR