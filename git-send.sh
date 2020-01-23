#!/bin/bash

# example => git send * _amend
# example => git send * _ "..."
# example => git send * _force "..."
# example => git ['/home/folder', '1.sh', '2.sh'] _ "add.."
#     then   git add /home/folder/1.sh
#            git add /home/folder/2.sh
#            ...

# var
echo_bransh=$(git branch)

branch=${echo_bransh:2}
origin="https://username:password@myrepository.biz/file.git"

add=$1
options=$2
comments=$2

# start
if [ add == '*' -o add == '-A']
  then
    git add $add
  else
    add_string=${1:1:-1}
    add_to_array=${add_string//,/' '} 	# // - global; replace ',' to ' '
    add_array=($add_to_array) # fixed
   # add ...

if [ "$options" == '_' ]
  then
    git commit -m $comments
    git push $origin
  elif [ "$options" != '_ammend' ]
    then
      git commit "--${options:1}"
      git push $origin
  elif [ "$options" == '_force' ]
    then
      git commit -m $comments
      git push "--${options:1}" $origin
  elif [ "$options" == '_ammend:force' ]
    then
      git commit "--${options:1}"
      git push "--${options:1}" $origin
  else
    echo "Something is wrong"
fi

# echo
echo "git commit on $branch"
if [ "$options" != '_' ]
  then
    echo "	=> options: --${options:1}"
fi
if [ "$comments" ]
  then
    echo "	=> comments: ${comments}"
fi




