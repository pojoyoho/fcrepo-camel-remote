#!/bin/bash
input="object_paths.txt"
while IFS= read -r line
do
  echo "Updating $line ..."
  # update object path with escape
  escpath=$(echo $line | sed 's/\//\\\//g')
  # update identifier in config.json
  sed -i '' 's/\/prod[^"]*/'"$escpath"'/' config.json
  # commit and push
  git commit -a -m "Update identifier to $line"
  git push
  # sleep for random 10 to 60 minutes
  min=$(jot -r 20 60)
  echo "$(date) Waiting $min minutes..."
  sleep $((min*60))
done < "$input"
