#!/bin/bash

# The directory to search recursively
directory="/mnt/user/plex/movies"

# The maximum file size in bytes (700MB = 734003200 bytes)
max_size=734003200

# Recursively list all files smaller than max_size
find "$directory" -type f -size -$max_sizec -printf "%s\t%p\n"