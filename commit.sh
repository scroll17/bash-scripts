#!/bin/bash

# var
echo_bransh=$(git branch)

branch=${echo_bransh:2}
origin="https://username:password@myrepository.biz/$branch.git"

options=$1 
comments=$2

# start
git add *
if [ "$options" == '_' ]
  then
    git commit -m $comments
    git push $origin
fi
if [ "$options" == '_ammend' ]
  then
    git commit "if [ "$options" != '_ammend' ]
  then
    git commit "--${options:1}"
    git push $origin
fi"
    git push $origin
fi
if [ "$options" == '_force' ]
  then
    git commit -m $comments
    git push "--${options:1}" $origin
fi
if [ "$options" == '_ammend:force' ]
  then
    git commit "--${options:1}"
    git push "--${options:1}" $origin
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




