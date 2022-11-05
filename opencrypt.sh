#!/bin/bash

## Essais :
# opencrypt img.jpg

# console colors 2020-08-22 12:47:37
GREEN='\033[0;32m' 
LGREEN='\033[1;32m' 
WHITE='\033[1;37m'
YELL='\033[1;33m'
RED='\033[0;31m'
LRED='\033[1;31m'
MAG='\033[0;35m'
LMAG='\033[1;35m'
CYAN='\033[0;36m'
LCYAN='\033[1;36m'
NC='\033[0m' # No Color
 
# parameter $1, arg filename, get basename, extension , and name without extension
filename=$1
basename=$(basename "$filename")
extension="${filename##*.}" #not working
name_no_ext="${filename%.*}"
 
# echo "file:$1"
# echo "ext:$extension"
# echo "noext:$name_no_ext"
 
# check if file not found
if [ ! -f "$1" ];
then
    printf "${LRED}File not found :'${1}'${NC}\n"
    exit
fi

# delete fileToFind fileToDelete
delete_if_output_exists()
{
    outputfile="$1"
    filetodel="$2"
    if [ -f "$outputfile" ];
    then
        echo "'$outputfile' exists."
        stat "$outputfile" | grep -i c
        printf "${WHITE}Delete file '${filetodel}'${NC} ?\n"
        rm -i "$filetodel"
    else
        printf "${LRED}Ouch, file '${outputfile}' not created ?${NC}\n"
    fi
}

 

if [[ "$extension" == des3 || "$extension" == des3i ]]
then
    iter=""
    if [[ "$extension" == des3i ]]
    then
        iter="-iter 1000"
    fi
    original_name="$name_no_ext"
    printf "${YELL}Start decrypt... ${NC}\n"
    openssl des3 -d -in "$1" -out "$original_name" $iter
    delete_if_output_exists "$original_name" "$1"
else
    des3file="$1.des3i" #2022-11-05 12:13:16 - Use of iter
    printf "${YELL}Start encrypt... ${NC}\n"
    openssl des3 -in "$1" -out "$des3file" -iter 1000
    delete_if_output_exists "$des3file" "$1"
fi

#printf "Jumping to ${YELL}'${target}'${NC}\n"


