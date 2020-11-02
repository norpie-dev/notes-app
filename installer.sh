#!/bin/bash

NOTESDIR=/home/$SUDO_USER/Notes
COMPILEDNOTESDIR=/home/$SUDO_USER/Compiled\ Notes

FONTSDIR=/home/$SUDO_USER/.notes_data/

if [[ $EUID -ne 0 ]]; then
    echo "this script should run as root"
    exit 1
fi

mkdir $FONTSDIR
mkdir $NOTESDIR
mkdir $COMPILEDNOTESDIR

cp notes_app/notes.sh /bin/notes
chmod +x /bin/notes

cp notes_app/fonts/font.tex $FONTSDIR

chown "$SUDO_USER":"$SUDO_USER" /home/"$SUDO_USER"/*
