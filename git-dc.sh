#!/bin/bash

# var
echo_bransh=$(git branch)
branch=${echo_bransh:2}

# read folder_name <<< `basename $(pwd)`
read folder_name <<< $(basename $(pwd))
origin="https://username:password@myrepository.biz/file.git"

git_adds=()
git_commit_options
git_push_options

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
       add_echo="  => add: no params"
  elif [ "${add:0:2}" == '-r' ]
    then
        IFS=',' read -a array_add <<< "${add:4:-1}"
        IFS=' ' # to default

        folder_add=${array_add[0]}
        unset array_add[0]

        for _add in ${array_add[@]}; 
          do
            git add "$folder_add/$_add"
            git_adds+=( "$folder_add/$_add" )
          done

  elif [ "${add:0:1}" != '[' ]
    then
      echo "Parametrs 'git add' has been array..."
      exit 0
  else
    IFS=',' read -a array_add <<< "${add:1:-1}"
    IFS=' ' # to default

    for _add in ${array_add[@]}; 
      do
        git add "$folder_add/$_add"
        git_adds+=( "$folder_add/$_add" )
      done
fi


if [ "$options" == '--commit' ]
    then 
        git_commit_options="-m $comments"
        git_push_options="$origin"
  elif [ "$options" == '--amend' ]
    then
        git_commit_options=${options}
        git_push_options="$origin"
  elif [ "$options" ==  '--force' ]
    then
        git_push_options="$options $origin"
  elif [ "$options" == '--force:amend' ] || [ "$options" == '--amend:force' ]
    then
      git_commit_options="--amend"
      git_push_options="--force $origin"
  else
    echo "Something is wrong..."
    exit 0
fi

# echo
echo "git commit on $folder_name/$branch"
if [ ${git_adds} ]
  then 
    for _add in ${git_adds[@]}
      do
        echo "  => add: $_add"
      done
fi

if [ $options ] && [ "$options" != '_' ]
  then
    echo "	=> options: ${options}"
fi

if [ "$comments" ]
  then
    echo "	=> comments: ${comments}"
fi


 read -r -p "Are you sure? [Y/n]" response
 response=${response,,} # tolower
 if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; 
  then
    if [ $git_commit_options ]
      then
        git commit "$git_commit_options"
    fi
    if [ $git_push_options ]
      then
        git push "$git_push_options"
    fi
  else
    if [ ${git_adds} ]
      then 
        for _add in ${git_adds[@]}
          do
            git reset HEAD "$_add"
          done
      elif [ "${add:0:1}" == '[' ]
        then 
            for _add in ${git_adds[@]}; 
              do
                git reset HEAD "$_add"
              done
    fi
 fi
