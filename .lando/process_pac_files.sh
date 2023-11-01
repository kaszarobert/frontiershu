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

# Check if the destination folder exists; if not, create it
if [ ! -d "$destination_folder" ]; then
    mkdir -p "$destination_folder"
fi

# Process each *.pac file in the source folder
for pac_file in "$source_folder"/*.pac; do
    if [ -f "$pac_file" ]; then
        # Get the base filename without the path and extension
        base_filename=$(basename "$pac_file" .pac)
        # Run the HedgeArcPack command
        HedgeArcPack "$pac_file" "$destination_folder/$base_filename"
    fi
done

echo "Processing complete."