#!/bin/sh

url="$1:5000"
vote_option="$2"
count=10

if [ "$vote_option" = "cat" ]; then
  vote="vote=a"
elif [ "$vote_option" = "dog" ]; then
  vote="vote=b"
else
  echo "Invalid vote option. Please use 'cat' or 'dog'."
  exit 1
fi

echo "Repeatedly voting for cat"

for i in $(seq 1 $count); do
  echo "Vote $i of $count"
  curl -sSL -o /dev/null -X POST -d "$vote" "$url"
  sleep 1
done

echo "Done voting for cat"