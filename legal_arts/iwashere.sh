#!/bin/bash

if [ $# -ne 1 ]; then
    echo "You should give one argument."
    exit 2
fi

file_name=$1

# Get current user name
name=$(whoami)

# If the file is of a regular type, call the "filegraffiti" executable, with name of user
if [ -f $file_name ]; then

    # Call filegraffiti
    ./filegraffiti $file_name $name
fi

# if the file name given as argument is a directory, the script will perform the following processing
# of the contents of that directory: it will loop, using a repetitive structure, through all direct entries in that
# directory, and for each entry, the script will recursively call itself, with that entry as a command-line
# parameter.

# Write Recursive function
function foo() {
    for file in $1/*; do
        if [ -d $file ]; then
            foo $file
        elif [ -f $file ]; then
            ./filegraffiti $file $name
        fi
    done
}

if [ -d $file_name ]; then
    foo $file_name
fi

exit 0 # Success !
