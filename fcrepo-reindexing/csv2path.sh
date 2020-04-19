#!/bin/bash

# transform graphdb query-result.csv with one subject column to object_path.txt
# $1: query-result.csv directory
if [ -z "$1" ]
  then
    echo "Usage:"
    echo "  csv2path \$dir > object_paths.txt"
    echo "  \$dir: query-results.csv directory"
    exit 1
fi
# create query-all.csv from query-result*.csv
cat $1/query-result*.csv > /tmp/query-all.csv
# remove subject header lines
sed -i '' '/^s/d' /tmp/query-all.csv
# remove server urls
sed 's/http:\/\/mycombe.library.ualberta.ca:8080\/fedora\/rest//' /tmp/query-all.csv
