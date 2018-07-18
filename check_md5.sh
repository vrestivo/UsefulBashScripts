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
EXT=".md5"
CMD=/usr/bin/md5sum

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

#TODO delete debugging
echo -e "\nChecking file: $1"
echo -e "Against Signature file: $SIG_FILE\n"


if [ ! -r $1 ] ; then
  echo "error: can't read: $1"
  exit -1
fi 
 
if [ ! -r $SIG_FILE ] ; then 
  echo "error: can't read the signagure file: $SIG_FILE"
  exit -1
fi



echo "checking $1"
grep $($CMD $1) $SIG_FILE

# print result message for clarity
if [ $?  == 0 ] ; then
  echo
  echo "Signature Matches!"
else
  echo
  echo "*************************"
  echo "Signature DOES NOT match!"
  echo "*************************"
fi
