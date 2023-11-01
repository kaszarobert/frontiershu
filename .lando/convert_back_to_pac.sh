#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 source_folder destination_folder"
    exit 1
fi

source_folder="$1"
destination_folder="$2"

# Check if the source folder exists
if [ ! -d "$source_folder" ]; then
    echo "Source folder does not exist: $source_folder"
    exit 1
fi

# Create the destination folder if it doesn't exist
if [ ! -d "$destination_folder" ]; then
    mkdir -p "$destination_folder"
fi

mkdir -p "$destination_folder"

# Iterate over subfolders in the source folder
for subfolder in "$source_folder"/*/; do
    subfolder_name=$(basename "$subfolder")
    
    # Run HedgeArcPack command for each subfolder
    echo "$source_folder/$subfolder_name/" "$destination_folder/$subfolder_name.pac"
    HedgeArcPack "$source_folder/$subfolder_name/" "$destination_folder/$subfolder_name.pac" -P -T=frontiers
done

echo "HedgeArcPack completed for subfolders in $source_folder."