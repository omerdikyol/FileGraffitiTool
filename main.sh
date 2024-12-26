#!/bin/bash

if [ $# -ne 1 ]; then
    echo "You should give one argument."
    exit 2
fi

# i)

# Check if legal_arts directory exists
if [ ! -d legal_arts ]; then
    echo "legal_arts directory does not exist." >&2
    exit 1
fi

# Check if iwashere.sh exists
if [ ! -f legal_arts/iwashere.sh ]; then
    echo "iwashere.sh does not exist." >&2
    exit 1
fi

# Check if iwashere.sh is executable
if [ ! -x legal_arts/iwashere.sh ]; then
    chmod +x legal_arts/iwashere.sh
fi

# ii)

# Check if performances directory exists on the iwashere.sh directory
if [ ! -d legal_arts/performances ]; then
    echo "performances directory does not exist." >&2
    exit 2
fi

# Get directory of performances
performances_dir=$(dirname $(find . -name performances))

# Check if filegraffiti.c exists and is readable
if [ ! -r legal_arts/performances/filegraffiti.c ]; then
    echo "filegraffiti.c does not exist or is not readable." >&2
    exit 2
fi

# iii)

# Check if filegraffiti exists and is executable
if [ ! -x legal_arts/performances/filegraffiti ]; then
    gcc -o legal_arts/performances/filegraffiti legal_arts/performances/filegraffiti.c
    if [ $? -ne 0 ]; then
        echo "Error compiling filegraffiti.c" >&2
        exit 3
    fi
fi

# iv)

# Check if the argument is a directory and is readable
if [ ! -d $1 -o ! -r $1 ]; then
    echo "The argument is not a directory or is not readable." >&2
    exit 4
fi

# Call iwashere.sh
# the lines from the output will be sorted in reverse lexicographic order
# duplicate lines will be removed, after which each occurrence of the "/" character (forward slash) will be
# replaced with the empty string (in other words, all occurrences of the "/" character will be removed).
$iwashere_dir/iwashere.sh $1 | sort -r | uniq | tr -d /
exit 0 # Success !
