# Bash Recycle and Restore

* My first attempt at bash scripting.
* This project is to write a recycle script and a restore script. 
* This will provide users with a recycle bin which can be used to safely delete and restore files.

## Recycle
* Works like the rm command, but instead of permanently deleting the file, it moves it to a recyclebin.
* Can be run in interactive mode using the __-i option__ and in verbose mode using the __-v option__.
* Can also remove directories and their contents using the __-r option__.
```bash
bash recycle fileName   
```

## Restore
* Restore individual files back to their original location, able to restore files that were recycled recursively.
* User will determine which file is to be restored and use the file name with inode number.

```bash
bash restore fileName_1234    
```
