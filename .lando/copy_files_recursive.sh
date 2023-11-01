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

# Copy everything from source to destination, but convert "cnvrs-text" files
find "$source_folder" -type f -exec sh -c '
    source_file="$1"
    source_file_relative=$(realpath --relative-to="'$source_folder'" "$source_file")  # Get the relative path

    relative_path="${source_file#$source_folder/}"
    destination_file="'"$destination_folder"'/$source_file_relative"

    # Check if the source file has a "cnvrs-text" extension
    if [ -n "$(echo "$source_file" | grep -o '\.cnvrs-text\$')" ]; then
        # Convert the "cnvrs-text" file to "xml" format using PuyoTextEditor
        destination_file="${destination_file%.cnvrs-text}.xml"

        # Create the destination directory if it does not exist
        destination_dir=$(dirname "$destination_file")
        mkdir -p "$destination_dir"

        PuyoTextEditor "$source_file" -o "$destination_file"

        echo "Converted $source_file to $destination_file"
    else
        # Create the destination directory if it does not exist
        destination_dir=$(dirname "$destination_file")
        mkdir -p "$destination_dir"

        # Copy the file to the destination folder
        cp "$source_file" "$destination_file"

        echo "Copied $source_file to $destination_file"
    fi    

' sh {} \;

echo "Copy process complete."
