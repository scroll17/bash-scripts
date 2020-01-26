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

# read folder_name <<< `basename $(pwd)`
read folder_name <<< $(basename $(pwd))
origin="https://username:password@myrepository.biz/file.git"

add=$1
options=$2
comments=$3

# create array from arguments => 
# 1)
  # string="a,b,s"
  # IFS=',' read -a array <<< "$var"
  # echo ${array[@]}
# 2)
  # var2=${string//,/' '}
  # array=($var2)
  # echo ${array[1]}


# start
if [ "$add" = '_' ]
    then
       add_echo="git add => no params"
  elif [ "${add:0:2}" == '-r' ]
    then
        IFS=',' read -a array_add <<< "${add:4:-1}"
        IFS=' ' # to default

        folder_add=${array_add[0]}
        unset array_add[0]

        # recursive logic
  elif [ "${add:0:1}" != '[' ]
    then
      echo "Parametrs 'git add' has been array..."
      exit 0
  else
    IFS=',' read -a array_add <<< "${add:1:-1}"
    IFS=' ' # to default
fi


if [ "$options" == '--commit' ]
    then 
        git commit -m "$comments"
        git push "$origin"
  elif [ "$options" == '--amend' ]
    then
        git commit ${options}
        git push "$origin"
  elif [ "$options" ==  '--force' ]
    then
        git push "$options" "$origin"
  elif [ "$options" == '--force:amend' ] || [ "$options" == '--amend:force' ]
    then
      git commit --amend
      git push --force "$origin"
  else
    echo "Something is wrong..."
    exit 0
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




