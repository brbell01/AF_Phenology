#!/bin/bash
# enable next line for debugging purpose
# set -x 

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

# use fourth parameter for path to target products
targetDirectory="$4"

# the fifth parameter is a file suffix for the target product name, typically indicating the type of processing
targetFileSuffix="$5"

   
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
for F in $(ls -1 *.zip); do
  sourceFile="$(grealpath "$F")"
  targetFile="${targetDirectory}/$(removeExtension "$(basename ${F})")_${targetFileSuffix}.tif"
  ${gptPath} ${graphXmlPath} -e -p ${parameterFilePath} -t ${targetFile} ${sourceFile}
done