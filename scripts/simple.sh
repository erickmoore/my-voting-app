#!/bin/sh

url="http://20.122.225.76:5000/"
count=10

echo "Repeatedly voting for cat"

for i in $(seq 1 $count); do
  echo "Vote $i of $count"
  curl -sSL -o /dev/null -X POST -d "vote=a" "$url"
  sleep 1
done

echo "Done voting for cat"