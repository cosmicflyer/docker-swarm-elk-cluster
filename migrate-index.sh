#!/bin/bash

old_elastic="http://user:password@old-node-ip:9200"
new_elastic="http://user:password@new-node-ip:9200"

all_indexes=`curl -sb -X GET "${old_elastic}/_cat/indices?v" |grep -v uuid |awk '{print $3}'`

for i in `echo "${all_indexes}"`; do
  curl -H 'Content-Type: application/json' -X POST "${new_elastic}/_reindex?pretty" -d"{
    \"source\": {
      \"remote\": {
        \"host\": \"$old_elastic\",
        \"username\": \"elastic\",
        \"password\": \"top-secret\"
      },
      \"index\": \"$i\"
    },
    \"dest\": {
      \"index\": \"$i\"
    }
  }"
done
