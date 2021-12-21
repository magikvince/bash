#!/bin/sh

#author: Vincent NAVARRO
#creation date: 17/12/2021

#creates empty source files based on the missingFiles.txt file
#this way you will gain time and avoid misspelling files or package name (like I did in TP09 ! ).


missingFile=missingFiles.txt

echo " "
echo "creating empty source files ..."
echo " "

for fic in $(cat $missingFile)
do
  
  if [[ ! -f $fic ]]
  then
    touch $fic
    cr_touch=$?

    if (( cr_touch == 0 ))
    then
      echo " "
      echo "file $fic was created : OK"
      ls -lrt $fic
      echo " "
    else
      echo "[ ERROR ] problem when trying to create file $fic !"
    fi
  else
    echo "file $fic already present !"
  fi
done