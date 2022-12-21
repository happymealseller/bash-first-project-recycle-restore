#!/bin/bash

# 2.  Create "recyclebin" Directory
mkdir recyclebin

# 3.  The file to be deleted will be a command line argument and the script should be executed as follows: 	bash recycle fileName 
if [$1 === 'recycle' type && $2 === non directory]

# 4.	The script must test for the following error conditions and display the same kind of error messages as the rm command.
use case and switch 

    if [no filename]
    echo "Missing input for filename."
    echo "Please use this format 'bash recycle fileName'"
    exit 1 
    fi

    if [file does not exist]
    echo "File you entered does not exist."
    exit 1 
    fi

    if [directory name provided]
    echo "Missing input for filename."
    echo "Please use this format 'bash recycle fileName'"
    exit 1 
    fi

    if [filename = reycle]
    echo "Attempting to delete recycle, operation aborted"
    exit 1 
    fi

fi

# 5.	The filenames in the recyclebin, will be in the following format: fileName_inode
# For example, if a file named f1 with inode 1234 is recycled, the file in the recyclebin will be named f1_1234. This gets around the potential problem of deleting two files with the same name. The recyclebin will only contain files, not directories. 

else 
read "confirm file delete ?" (write if else )
let inode = ls -i fileName
let filename = filename
let newname = `${fileName}_${inode}`

touch .restore.info
echo name of the file , ; , original absolute path of the file >> .restore.info

mv fileName $newname /$HOME/recyclebin
exit 0





