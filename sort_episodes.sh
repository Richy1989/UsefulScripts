#!/bin/bash

# The folder containing TV show episode files
TV_SHOW_DIR="/path/to/tv/show/folder"

# The destination folder for the season directories
SEASON_DIR="/path/to/destination/folder"

# Create the destination folder if it doesn't exist
if [ ! -d "$SEASON_DIR" ]; then
    mkdir "$SEASON_DIR"
fi

# Loop through all the subdirectories in the source folder
find "$TV_SHOW_DIR" -type d -print0 | while IFS= read -r -d $'\0' dir; do
    # Change to the subdirectory
    cd "$dir"

    # Loop through all the video files in the subdirectory
    for file in *.mp4 *.mkv *.avi
    do
        # Extract the season and episode numbers from the file name
        if [[ $file =~ S([0-9]{2})E([0-9]{2}) ]]; then
            season=${BASH_REMATCH[1]}
            episode=${BASH_REMATCH[2]}

            # Create the season directory if it doesn't exist
            season_name=$(echo "Season $season" | tr '[:upper:]' '[:lower:]' | sed 's/[ .]/_/g')
            if [ ! -d "$SEASON_DIR/$season_name" ]; then
                mkdir "$SEASON_DIR/$season_name"
            fi

            # Move the file into the appropriate season directory
            mv "$file" "$SEASON_DIR/$season_name/$file"
        fi
    done
done