#!/bin/sh

#author: Vincent NAVARRO
#creation date: 17/12/2021

#check based on the missingFiles.txt file , if all files are found.
#this is useful to check that there are not any misspelled file or package !
#this way, when doing ./gradlew mark, there would not be any missing file in the TPXXsrc.zip file!

missingFile=missingFiles.txt

expectedFiles=$(wc -l $missingFile | cut -d " " -f1 )
errorFiles=0

function checkFileExists
{
  fileToCheck=$1

  if [[ -z $fileToCheck ]]
  then
    echo "argument missing in function $0 !"
    echo "file name to be checked is expected !"
    return 1
  fi

  if [[ ! -f $fileToCheck ]]
  then
    echo " "
    echo "[ ERROR ] File $fileToCheck doesn't exist or was not found !"
    echo "check the name or path."
    echo " "
    (( errorFiles += 1 ))
    return 1
  else
    echo "[ INFO ] File $fileToCheck found : ok"
    return 0
  fi
}

echo " "
echo "checking all files from $missingFile"
echo " "

checkFileExists $missingFile && ls -lrt $missingFile
echo " "
echo "checking project files..."
echo " "

for fic in $(cat $missingFile)
do
  checkFileExists $fic
done

echo " "
echo "listing files:"
echo " "

for fic in $(cat $missingFile)
do
  ls -lrt $fic
done

#checking results
echo " "
if (( errorFiles > 0 ))
then
  #echo "errorFiles = $errorFiles"
  echo "expected file(s) : $expectedFiles"
  echo "missing file(s) : $errorFiles"
else
  echo "all files were found correctly"
fi
echo " "

