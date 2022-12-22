#! /bin/bash

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

# validate that argument is not a directory
if [ -d $1 ]; then
    echo "Unable to recycle directories –- operation aborted" 
    exit 1
fi

# validate if we can find the file in root and sub directories 
if [ ! -f $1 ] ; then
    echo "File does not exist –- operation aborted" 
    exit 1
fi

# validate that "recycle.sh" is not within the arugments
if [[ $@ =~ "recycle" ]]; then
    echo "Attempting to delete recycle –- operation aborted"       
    exit 1
fi

# get inode and save to variable
inode=$(ls -i $1 | cut -d' ' -f1)

# combine inode and filename
newName=$1_$inode

# get absolute path and save to variable
absolutePath=$(readlink -f $1 | cut -d "/" -f1,2,3,4)
echo $absolutePath

# create entry and update .restore.info
entry=$newName:$absolutePath/
echo $entry >> /$HOME/.restore.info

# move file to recyclebin and rename it
mv $1 /$HOME/recyclebin/$newName

# output success message
echo "Success! -- $1 recycled as $newName"

# quit
exit 0

# === PHASE 3 ==============================================================================
create helper func that does read if $1 is -i
create helper func that does echo if $1 is -v
create helper func that calls above 2 func if $1 is -vi or -iv
else if $1 or whatever the -i position is false then echo "$1" exit 1 . 
# ==========================================================================================

# === PHASE 4 ==============================================================================
let count = (count argument symbol - 1) 
for (let i = 0; i <= count; i++){
    need to put above stuff into func
    maybe might need to add continue to keep loop runing - fix above syntax first
    call func
}
remember to store abs path and delete the directory in question
# ==========================================================================================

# === PHASE 5 ==============================================================================
similar to above
# ==========================================================================================

