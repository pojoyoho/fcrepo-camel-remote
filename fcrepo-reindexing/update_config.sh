#!/bin/bash
input="object_paths.txt"
while IFS= read -r line
do
  # remove trailing carrier return
  line=$( echo $line | tr -d '\r')
  echo "$(date): Updating $line ..."
  # update object path with escape
  escpath=$(echo $line | sed 's/\//\\\//g')
  # update identifier in config.json
  sed 's/\/prod[^"]*/'"$escpath"'/' config.json
  
  # commit and push
  git commit -a -m "Update identifier to $line"
  git push
  # sleep for random N to NN minutes
  min=$(jot -r 1 3 10)
  echo "$(date): Waiting $min minutes..."
  sleep $((min*60))
done < "$input"
