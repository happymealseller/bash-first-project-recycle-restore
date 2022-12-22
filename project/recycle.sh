#! /bin/bash

# ================================================================================================================= 
# =============== the guy has to cd to the directory right to run my script right? ================================
# =============== if so this is fine right? =======================================================================
# ================================================================================================================= 

# Check if recycle bin exists, if not create one
if [ -d /$HOME/recyclebin ]; then
    :
else 
    mkdir recyclebin    
fi

# Check if hidden file exists, if not create one
if [ -e .restore.info ]; then
    :
else 
    touch .restore.info    
fi

# ================================================================================================================= 
# =========================================== should i be using "$x" or $x========================================= 
# =========================================== should i be using elif ============================================== 
# =========================================== do i need to output error =========================================== 
# ================================================================================================================= 

# validate we have at least one argument
if [ $# -eq 0 ]; then     
    echo "No filename provided -- usage: bash recycle [options] [file...] –- operation aborted" 
    exit 1   
fi

# validate if we can find the file in root and sub directories
# =============== the guy has to cd to the directory right to run my script right? =================================
# =============== if so do i need to even put root? ================================================================
if [ find / -name $1] ; then    
    echo "File does not exist –- operation aborted" 
    exit 1   
fi

# validate that "recycle.sh" is not within the arugments
if [[ $@ =~ "recycle.sh" ]]; then
    echo "Attempting to delete recycle –- operation aborted"       
    exit 1   
fi

# validate that argument is not a directory
# =============== the guy has to cd to the directory right to run my script right? =================================
# =============== if so this is fine right? ========================================================================
if [ -d $1 ]; then  
    echo "Unable to recycle directories." 
    exit 1      
fi

# ================================================================================================================= 
# ================================================================================================================= 
# ================================================================================================================= 


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

