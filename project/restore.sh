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

# validate if file already exists in pwd 
if [ -f ./$(echo $1 | cut -d"_" -f1) ]; then
    echo "File with similar name exists -- do you want to overwrite? y/n"
    read input
    # prompt for input to overwrite file
    if [[ $input =~ ^[Yy] ]]; then
      :
    else
      echo "Operation aborted" 
      exit 1
    fi
fi

# get original file name
originalName=$(grep $1 /$HOME/.restore.info | cut -d":" -f1 | cut -d"_" -f1)

# get absolute path
path=$(grep $1 /$HOME/.restore.info | cut -d":" -f2)

# move file back to orignial place rename it
mv /$HOME/recyclebin/$1 $path/$originalName

# select all except current entry and overwrite log file without selected log
sed -i "/$1/d" /$HOME/.restore.info

# output success message
echo "Success! -- $originalName restored"

# quit
exit 0