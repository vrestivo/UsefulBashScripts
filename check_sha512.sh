#!/bin/bash
# the purpose of this script is to automate
# SHA256 signature checking process
# and eliminate excuses for not checking the
# file signatures

###NOTE:
# the text file containing the SHA256 signature
# must have the same name as the file to be hashed
# plus the ".sha256" extension

# signature file extension
EXT=".sha512"
CMD=/usr/bin/sha512sum
RED='\e[1;31m'
GREEN='\e[1;32m'
YELLOW='\e[1;33m'
NO_COLOR='\e[0m'


# check for a file argument
if [ $# -lt 1 ] || [ $# -gt 2 ] ; then
  echo "usage: <file_to_check> [file_containing_checksum]"
  exit -1
fi


if [ ! -x $CMD ] ; then 
  echo "$CMD not foud"
  exit -1
fi


SIG_FILE=$1$EXT 
if [ $# == 2 ] ; then
  SIG_FILE=$2
fi


if [ ! -r $1 ] ; then
  echo -e "${RED}ERROR: can't read: $1${NO_COLOR}"
  exit -1
fi 


if [ ! -r $SIG_FILE ] ; then 
  echo -e "${RED}ERROR: can't read the signagure file: $SIG_FILE${NO_COLOR}"
  exit -1
fi


# conduct and actual test
echo -e "\n${YELLOW}Checking file: $1${NO_COLOR}"
echo -e "Against Signature file: $SIG_FILE"

grep $($CMD $1) $SIG_FILE > /dev/null

# print result message for clarity
if [ $?  == 0 ] ; then
  echo
  echo -e "${GREEN}Signature Matches!\n\n${NO_COLOR}"
else
  echo -e "$RED"
  echo "*************************"
  echo "Signature DOES NOT match!"
  echo "*************************"
  echo -e "$NO_COLOR\n\n"
fi
