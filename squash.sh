#!/bin/bash
opt="$1"
older="$2"
execute1="-exec"
execute2="-x"
show1="-show"
show2="-s"
list1="-list"
list2="-l"

if [ "$opt" != "$show1" ] && [ "$opt" != "$show2" ] && [ "$opt" != "$execute1" ] && [ "$opt" != "$execute2" ] && [ "$opt" != "$list1" ]  && [ "$opt" != "$list2" ] ; then
    echo "missing first parameter: ..."
    exit
fi

if [ "$older" == "" ]; then
    echo "missing second parameter: must pass origin branch name to squash from"
    exit
fi


current=$(git rev-parse --abbrev-ref HEAD)
qtd=$(git rev-list --no-merges --count $older..$current)

if [ "$opt" = "$show1" ] || [ "$opt" = "$show2" ]; then
  echo "$ git rebase -i HEAD~$qtd"
elif [ "$opt" = "$execute1" ] || [ "$opt" = "$execute2" ]; then
  git rebase -i HEAD~$qtd
elif [ "$opt" = "$list1" ] || [ "$opt" = "$list2" ]; then
  echo "git rev-list --no-merges $older..$current"
fi

echo "#############"
echo "Make sure that everything is OK then run the following command:"
echo "$ git push origin $current --force"
echo "Ask yout coworker to run the following command:"
echo "$ git reset --hard origin/$current"
echo "#############"
echo .
