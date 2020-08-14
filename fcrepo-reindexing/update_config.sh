#!/bin/bash
i=0
input="object_paths.txt"
while IFS= read -r line
do
  if [ $((i++)) -gt 0 ] 
  then
    # sleep for random N to NN minutes
    min=$(jot -r 1 2 5)
    echo "$(date): Waiting $min minutes..."
    sleep $((min*60))
  fi
  
  # remove trailing carrier return
  line=$( echo $line | tr -d '\r')
  echo "$(date): Updating $line ..."
  # update object path with escape
  escpath=$(echo $line | sed 's/\//\\\//g')
  # update identifier in config.json
  sed -i '' 's/\/prod[^"]*/'"$escpath"'/' config.json
  
  # commit and push
  git commit -a -m "Update identifier to $line"
  git push
done < "$input"
