#! /bin/bash

# validate we have at least one argument
if [ $# -eq 0 ]; then
    echo "No filename provided -- usage: bash restore [options] [file...] –- operation aborted" 
    exit 1
fi

# validate if we can find the file in recyclebin
if [ ! -f /$HOME/recyclebin/$1 ] ; then
    echo "File does not exist –- operation aborted" 
    exit 1
fi

# validate if file already exists in pwd .
if [ -f ./$1 ]; then
    echo "Do you want to overwrite? y/n"
    read input
    # prompt for input to overwrite file
    if [ -nocase $input = y* ]; then
      :
    else
      exit 1
    fi
fi

# get original file name
originalName=$(grep $1 /$HOME/.restore.info | cut -d: -f1)

# get absolute path
path=$(grep $1 /$HOME/.restore.info | cut -d: -f2)

# move file back to orignial place rename it
mv /$HOME/recyclebin/$1 $path/$originalName

# rewrite file without selected log (test last)
# grep -v $1 /$HOME/.restore.info > /$HOME/.restore.info

# output success message
echo "Success! -- $originalName restored"

# quit
exit 0