#!/bin/bash

# Check if recycle bin exists, if not create one.
if [ -d /$HOME/recyclebin ]; then
    :
else 
    mkdir recyclebin    
fi

# Check if hidden file exists, if not create one.
if [ -e .restore.info ]; then
    :
else 
    touch .restore.info    
fi

# Check if there is at least one argument.
if [ $# >= 1 ]; then     
    echo "No filename provided."    
fi

# Check if we can find the file.
if [ find /project -name $1] ; then      
    echo "File does not exist."    
fi

# Check if the file name is 'recycle.sh'.
if [ $1 == recycle.sh ]; then
    echo "Attempting to delete recycle – operation aborted."       
fi

# Check if file is a directory.
if [ -d $1 ]; then  
    echo "Unable to recycle directories."    
fi

# Find inode and save to variable.
inode=$(ls -i project | cut -d' ' -f1)

# Find absolute path and save to variable.
absolutePath=$(readlink -f $1)

# Create new file name.
newName=$1_$inode

# Rename file and move it to recyclebin.
mv $1 $newName /$HOME/recyclebin

# Create entry title and update hidden file.
entry=$newName:$absolutePath
echo $entry >> .restore.info

exit 0




# === PHASE 3 ==============================================================================
create helper func that does read if $1 is -i
create helper func that does echo if $1 is -v
create helper func that calls above 2 func if $1 is -vi or -iv
else if $1 or whatever the -i position is false then echo "$1" exit 1
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

