#!/bin/bash

NOTESDIR=/home/$SUDO_USER/Notes
COMPILEDNOTESDIR=/home/$SUDO_USER/Compiled\ Notes

FONTSDIR=/home/$SUDO_USER/.notes_data/

if [[ $EUID -ne 0 ]]; then
    echo "this script should run as root"
    exit 1
fi

cp notes_app/notes.sh /bin/notes
chmod +x /bin/notes

if [[ ! -e $NOTESDIR ]]; then
    mkdir "$NOTESDIR"
fi

if [[ ! -e $COMPILEDNOTESDIR ]]; then
    mkdir "$COMPILEDNOTESDIR"
fi

if [[ ! -e $FONTSDIR ]]; then
    mkdir "$FONTSDIR"
fi

chown "$SUDO_USER":"$SUDO_USER" /home/"$SUDO_USER"/*

cp notes_app/fonts/font.tex $FONTSDIR
