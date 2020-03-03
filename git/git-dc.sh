#!/bin/bash

# var
echo_branch=$(git branch)
array_branches=($(tr -s '\r\n' ' ' <<<"${echo_branch//'*'/''}" ))
branch="${array_branches[0]}" # if specific branch => "'${array_branches[0]'"

# read folder_name <<< `basename $(pwd)`
read folder_name <<<$(basename $(pwd))
origin="https://dzolotarenko:9c117vb@git.freshcode.org/agavrilenko/${folder_name}.git"

git_adds=()
git_push_options=()
git_commit_options=''

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
if [ "$add" == '_' ]; then
  git_adds+=("no params")
elif [ "${add:0:2}" == '-r' ]; then
  IFS=',' read -a array_add <<<"${add:4:-1}"
  IFS=' ' # to default

  folder_add=${array_add[0]}
  unset array_add[0]

  for _add in "${array_add[@]}"; do
    git add "$folder_add/$_add"
    git_adds+=("$folder_add/$_add")
  done

elif [ "${add:0:1}" != '[' ]; then
  echo "Parametrs 'git add' has been array..."
  exit 0
else
  IFS=',' read -a array_add <<<"${add:1:-1}"
  IFS=' ' # to default

  for _add in "${array_add[@]}"; do
    git add "$_add"
    git_adds+=("$_add")
  done
fi

if [ "$options" == '--commit' ]; then
  git_commit_options="-m \"$comments\""
  git_push_options=( $origin )

elif [ "$options" == '--amend' ]; then
  git_commit_options=${options}
  git_push_options=( $origin $branch )

elif [ "$options" == '--force' ]; then
  git_push_options=( "--force" $origin $branch )

elif [ "$options" == '--force:amend' ] || [ "$options" == '--amend:force' ]; then
  git_commit_options="--amend"
  git_push_options=( "--force" $origin $branch )

elif [ "$options" == '_' ]; then
  git_commit_options="no params"

else
  echo "Something is wrong..."
  exit 0
fi

# echo
echo
echo "git on $folder_name/$branch"
if [[ ${git_adds[0]} ]]; then
  for _add in "${git_adds[@]}"; do
    echo "	  => add: $_add"
  done
fi

if [[ $git_commit_options ]]; then
    echo "	  => git commit $git_commit_options"
fi
if [[ ${git_push_options[0]} == "$origin" ]]; then
  echo "	  => git push $branch"
else
  echo "	  => git push ${git_push_options[0]} $branch"
fi
# if [[ $options ]] && [[ "$options" != '_' ]]; then
#   echo "	  => options: ${options}"
# fi

echo
read -r -p "Are you sure? [Y/n]" response
echo

response=${response,,} # toLower
if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
  if [[ $git_commit_options ]]; then
    git commit "$git_commit_options"  # git
  fi

  if [[ ${git_push_options[0]} ]]; then
    git push "${git_push_options[0]}" "${git_push_options[1]}" "${git_push_options[2]}"  # git
  fi
else
  if [[ "${git_adds[0]}" != 'no params' ]]; then
    for _add in "${git_adds[@]}"; do
      echo "reset => $_add"
      output=`git reset HEAD "$_add"`
    done
    echo "$output"
  fi
fi

