#!/bin/bash
# enable next line for debugging purpose
set -x 

############################################
# User Configuration
############################################

# adapt this path to your needs
export PATH=/Applications/snap/bin/:$PATH
gptPath="gpt"

############################################
# Command line handling
############################################

# first parameter is a path to the graph xml
graphXmlPath="$1"

# second parameter is a path to a parameter file
parameterFilePath="$2"

# use third parameter for path to source products
sourceDirectory="$3"

# fourth parameter is for path to processed VH products
targetDirectoryVH="$4"

# fourth parameter is for path to processed VV products
targetDirectoryVV="$5"

# the fifth parameter is for file name suffix of VH products
targetFileSuffixVH="$6"

# the fifth parameter is for file name suffix of VV products
targetFileSuffixVV="$7"
   
############################################
# Helper functions
############################################
removeExtension() {
    file="$1"
    echo "$(echo "$file" | sed -r 's/\.[^\.]*$//')"
}


############################################
# Main processing
############################################

# Create the target directory 
mkdir -p "${targetDirectory}"

# the d option limits the elemeents to loop over to directories. Remove it, if you want to use files.
for F in $(ls -1 "${sourceDirectory}"/S1*.zip); do
  sourceFile="$(grealpath "$F")"
  targetFileVH="${targetDirectoryVH}/$(removeExtension "$(basename ${F})")_${targetFileSuffixVH}.tif"
  targetFileVV="${targetDirectoryVV}/$(removeExtension "$(basename ${F})")_${targetFileSuffixVV}.tif"
  ${gptPath} ${graphXmlPath} -e -p ${parameterFilePath} -t ${targetFileVH} ${targetFileVV} ${sourceFile}
done