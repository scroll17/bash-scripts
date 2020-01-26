# read -p "Are you sure? " -n 1 -r
# echo    # (optional) move to a new line
# if [[ $REPLY =~ ^[Yy]$ ]]
#     then
#         echo "Yes"
#         # do dangerous stuff
# fi

# read -p "Continue (y/n)?" choice
# case "$choice" in 
#   y|Y ) echo "yes";;
#   n|N ) echo "no";;
#   * ) echo "invalid";;
# esac

#  read -r -p "Are you sure? [Y/n]" response
#  response=${response,,} # tolower
#  if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
#     echo "YES"
#  fi

echo are you sure?
read x
if [ "$x" = "yes" ]
then
  echo "x = $x"
fi

# select one of this exapmles 