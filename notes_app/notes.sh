#!/bin/bash

NOTESDIR=~/Notes
COMPILEDNOTESDIR=~/Compiled\ Notes

FONTSDIR=~/.notes_data/font.tex

USAGE="notes [read|edit|create|del|compile] [class] [module] [note]"

if [[ -d $COMPILEDNOTESDIR ]]; then
    mkdir -p "$COMPILEDNOTESDIR"
fi

if [[ -d $NOTESDIR ]]; then
    mkdir -p "$NOTESDIR"
fi

suffix=".md"

makepdf() {
    local madepath="$NOTESDIR/$1/$2/$3$suffix"
    if [[ ! -f $madepath ]]; then
        echo "non-existant file"
        return
    fi
    if [[ ! -d "$COMPILEDNOTESDIR/$1" ]]; then
        mkdir -p "$COMPILEDNOTESDIR/$1"
    fi
    pandoc "$madepath" -f markdown -o "$COMPILEDNOTESDIR/$1/$2 - $3.pdf" --pdf-engine=xelatex --include-in-header $FONTSDIR -s --toc 
}

#if no arguments were sent
if [[ $# -eq 0 ]]; then 
    echo "$USAGE"
#if 1 argument was sent
elif [[ $# -eq 1 ]]; then 
    if [[ $1 = "read" ]] || [[ $1 = "edit" ]] || [[ $1 = "create" ]] || [[ $1 = "del" ]] || [[ $1 = "compile" ]]; then
        echo $USAGE
        echo "list of classes:"
        ls $NOTESDIR
    else
        echo "invalid syntax"
        echo $USAGE 
    fi
#if 2 arguments were sent
elif [[ $# -eq 2 ]]; then 
    if [[ $1 = "read" ]] || [[ $1 = "edit" ]] || [[ $1 = "compile" ]]; then
        if [[ ! -e $NOTESDIR/"$2" ]]; then 
            echo "that class does not exist!"
            echo "list of classes:"
            ls $NOTESDIR
        else
            echo $USAGE
            echo "list of classes:"
            ls $NOTESDIR/"$2"
        fi
    elif [[ $1 = "create" ]]; then
        if [[ -e $NOTESDIR/"$2" ]]; then 
            echo "that directory already exists!"
        else
            mkdir -p $NOTESDIR/"$2"
        fi
    elif [[ $1 = "del" ]]; then
        if [[ ! -e $NOTESDIR/"$2" ]]; then 
            echo "that directory does not exist!"
        else
            rm -R $NOTESDIR/"$2"
        fi
    fi
#if 3 arguments were sent
elif [[ $# -eq 3 ]]; then 
    if [[ $1 = "read" ]] || [[ $1 = "edit" ]] || [[ $1 = "compile" ]]; then
        if [[ ! -e $NOTESDIR/"$2"/"$3" ]]; then 
            echo "that class does not exist!"
            echo "list of classes:"
            ls $NOTESDIR/"$2"
        elif [[ ! -e $NOTESDIR/"$2"/ ]]; then 
            echo "that class does not exist!"
            echo "list of classes:"
            ls $NOTESDIR
        else
            echo $USAGE
            echo "list of classes:"
            ls $NOTESDIR/"$2"/"$3"
        fi
    elif [[ $1 = "create" ]]; then
        if [[ -e $NOTESDIR/"$2"/"$3" ]]; then 
            echo "that directory already exists!"
        else
            mkdir -p $NOTESDIR/"$2"/"$3"
        fi
    elif [[ $1 = "del" ]]; then
        if [[ ! -e $NOTESDIR/"$2"/"$3" ]]; then 
            echo "that directory does not exist!"
        else
            rm -R $NOTESDIR/"$2"/"$3"
        fi
    fi
#if 4 arguments were sent
elif [[ $# -eq 4 ]]; then 

    if [[ $1 = "read" ]]; then
        if [[ -a $NOTESDIR/"$2"/"$3"/"$4.md" ]]; then
            makepdf $2 $3 $4
            zathura "$COMPILEDNOTESDIR/$2/$3 - $4.pdf"
        else
            echo "that note does not exist"
        fi

    elif [[ $1 = "compile" ]]; then
        if [[ -a $NOTESDIR/"$2"/"$3"/"$4.md" ]]; then
            makepdf $2 $3 $4
        else
            echo "that note does not exist"
        fi

    elif [[ $1 = "edit" ]]; then
        if [[ -a $NOTESDIR/"$2"/"$3"/"$4.md" ]]; then
            vim $NOTESDIR/"$2"/"$3"/"$4.md"
        else
            echo "that note does not exist"
        fi

    elif [[ $1 = "del" ]]; then
        if [[ -a $NOTESDIR/"$2"/"$3"/"$4.md" ]]; then
            rm $NOTESDIR/"$2"/"$3"/"$4.md"
        else
            echo "that note does not exist"
        fi

    elif [[ $1 = "create" ]]; then
        if [[ -a $NOTESDIR/"$2"/"$3"/"$4.md" ]]; then
            echo "that note already exists"
        else
            if [[ -a $NOTESDIR/"$2"/"$3" ]]; then
                touch $NOTESDIR/"$2"/"$3"/"$4.md"
            else 
                mkdir -p $NOTESDIR/"$2"/"$3"
                touch $NOTESDIR/"$2"/"$3"/"$4.md"
            fi
        fi
    else
        echo $USAGE
    fi
fi