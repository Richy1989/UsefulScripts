
#!/bin/bash

# This script moves all files into a directory with the same name as the file, without the extension. 
# Examlpe: /mnt/user/data/FilesToFolderScript/dir
# The first argument is the base folder
search_dir=$1

echo "Base Folder: $1"

cd $search_dir

for entry in "$search_dir"/*
do
    if [ ! -d "$entry" ];
    then
        base="$(basename "$entry" | sed 's/\(.*\)\..*/\1/')"
        file=$(basename "$entry")

        echo "Moving File: $file"
        
        mkdir -p "$base"
        mv "$file" "$base"/"$file"
    fi
done