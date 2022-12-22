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




function recycle {
# validate we have at least one argument 
if [ $# -eq 0 ]; then
    echo "No filename provided -- usage: bash recycle [options] [file...] –- operation aborted" 
    return 1
fi

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

for arg in $@; do
  recycle $arg
done

# quit
exit 0