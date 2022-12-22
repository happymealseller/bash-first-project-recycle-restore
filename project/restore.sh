#!/bin/bash

# validate we have at least one argument
if [ $# -eq 0 ]; then     
    echo "No filename provided -- usage: bash restore [options] [file...] –- operation aborted" 
    exit 1   
fi

# validate if we can find the file in recyclebin
if [ find /$HOME/recyclebin -name $1] ; then    
    echo "File does not exist –- operation aborted" 
    exit 1   
fi

# Check if file is going to be overwritten and prompt for input.
if [ grep -w $1 n .restore.info ]; then 
    echo "Do you want to overwrite? y/n"
    read input
fi

# Restore and edit log.
if [ input === lower(Y*) ]; then
  mv fileName $(grep path from restore info)
  find out how to remove line from file 
  exit 0
fi

exit 1