#! /bin/bash

function recycle {
# validate that argument is not a directory
if [ -d $arg ]; then
    echo "Unable to recycle directories –- operation aborted"      
    return 1
fi

# validate if we can find the file in root and sub directories     
if [ ! -f $arg ] ; then
    echo "File does not exist –- operation aborted" 
    return 1
fi

# validate that "recycle.sh" is not within the arugments
if [[ $@ =~ "recycle" ]]; then
    echo "Attempting to delete recycle –- operation aborted"       
    return 1
fi

# get inode and save to variable
inode=$(ls -i $arg | cut -d' ' -f1)

# combine inode and filename
newName=${arg}_${inode}

# get absolute path and save to variable
absolutePath=$(readlink -f $arg | cut -d "/" -f1,2,3,4)

# create entry and update .restore.info
entry=$newName:$absolutePath/
echo $entry >> /$HOME/.restore.info

# move file to recyclebin and rename it
mv $arg /$HOME/recyclebin/$newName

# output success message
echo "Success! -- $arg recycled as $newName"
}

function optFunc() {
interactive=false
verbose=false

while getopts :iv opt
do
   case $opt in
        i) interactive=true;;
        v) verbose=true;;
        *) echo Bad Option - $OPTARG
           exit 1;;
   esac
done
}

function initFunc() {
  if $interactive && $verbose
       then
        # foreach loop run below on each arg
        for arg in $@; do
            echo "Confirm recycle $arg? y"
            read input
            if [[ $input =~ ^[Yy] ]]; then
                :
            else
                # if no then exit func for this iteration
                continue
            fi
            # run recycle func on each arg
            echo "Attempting to recycle $arg"
            recycle $arg
        done
        return 0
  fi

  if $interactive
     then
        # foreach loop run below on each arg
        for arg in $@; do
            echo "Confirm recycle $arg? y"
            read input
            if [[ $input =~ ^[Yy] ]]; then
                :
            else
                # if no then exit func for this iteration
                continue
            fi
            # run recycle func on each arg
            recycle $arg
        done
        return 0
  fi

 if $verbose
     then
        # foreach loop run below on each arg
        for arg in $@; do
            echo "Attempting to recycle $arg"
            # run recycle func on each arg
            recycle $arg
        done
        return 0
  fi

# handle if no options specified
for arg in $@; do
    # run recycle func on each arg    
    recycle $arg
done
}

# ================================================ MAIN ================================================

# call optFunc at the start of the script to look for input and set them
optFunc $*

# remove imput and its param
shift $[OPTIND-1]

# validate if recycle bin exists, if not create one 
if [ -d /$HOME/recyclebin ]; then
    :
else
    mkdir /$HOME/recyclebin
fi

# validate if hidden file exists, if not create one 
if [ -e /$HOME/.restore.info ]; then
    :
else
    touch /$HOME/.restore.info
fi

# validate we have at least one argument 
if [ $# -eq 0 ]; then
    echo "No filename provided -- usage: bash recycle [options] [file...] –- operation aborted" 
    exit 1
fi

# run main function
initFunc $*

# quit
exit 0