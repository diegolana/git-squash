#!/bin/bash
current=$(git rev-parse --abbrev-ref HEAD)
older="$1"

if [ "$older" == "" ]; then
    echo "must pass origin branch name to squash from"
    exit
fi

qtd=$(git rev-list --no-merges --count $older..$current)
git rebase -i HEAD~$qtd

echo "Make sure that everything is OK then run the following command:"
echo "git push origin $current --force"
